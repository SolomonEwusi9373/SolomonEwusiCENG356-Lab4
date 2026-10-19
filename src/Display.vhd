----------------------------------------------------------------
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;


entity Display is
  generic (n    : integer);
  port (RST     : in std_logic;
        CLK     : in std_logic;
	NinBin  : in std_logic_vector((n-1) downto 0);

        Anodes  : out std_logic_vector(3 downto 0);
        Pattern : out std_logic_vector(7 downto 0));
end Display;

architecture Display of Display is
  
  component INC
    generic (n : integer);
    port (A    : in std_logic_vector((n-1) downto 0);
      
          COUT : out std_logic;
          SUM  : out std_logic_vector((n-1) downto 0));
  end component;

  component Bin2BCD
    generic (n: integer);
    port (DI  : in std_logic_vector((n-1) downto 0);
  
          DOH : out std_logic_vector(3 downto 0);
          DOL : out std_logic_vector(3 downto 0));
  end component;

  component SegDrv
    port (DI : in std_logic_vector(3 downto 0);
  
          Pattern : out std_logic_vector(6 downto 0));
  end component;

  component CNT
    generic (n  : integer);
    port (CLK   : in std_logic;
          RST   : in std_logic;
          EN    : in std_logic;

          CNT_O : out std_logic_vector((n-1) downto 0));
  end component;

  component Pulser
    port (CLK    : in std_logic;
          RST    : in std_logic;
          Trig   : in std_logic;
           
          Enable : out std_logic);
  end component;

  signal Enable   : std_logic;
  signal Cout     : std_logic;
  signal CntD_O   : std_logic_vector(17 downto 0);
  signal CntS_O   : std_logic_vector(1 downto 0);
  signal NinBinV  : std_logic_vector((n-2) downto 0);
  signal NinBinB  : std_logic_vector((n-2) downto 0);
  signal DIL      : std_logic_vector((n-1) downto 0);
  signal DOMeta   : std_logic_vector(3 downto 0);
  signal DO       : std_logic_vector(3 downto 0);
  signal DOH      : std_logic_vector(3 downto 0);
  signal DOL      : std_logic_vector(3 downto 0);
  signal AnodeL   : std_logic_vector(3 downto 0);
  signal PatternL : std_logic_vector(6 downto 0);
  signal PatternS : std_logic_vector(6 downto 0);
  --attribute ASYNC_REG : string;
  --attribute ASYNC_REG of PatternLSBM : signal is "TRUE";

begin

-- In case of negative number, we negate the number
  NinBinV <= not NinBin((n-2) downto 0);

  Negate : INC
    generic map (n => (n-1))
    port map (A    => NinBinV,

              COUT => Cout,
              SUM  => NinBinB);

-- Display the absolute value. The sign is displayed separately
  DIL <= NinBin when NinBin(n-1) = '0' else (Cout & NinBinB);

  Convert : Bin2BCD
    generic map (n => n)
    port map (DI   => DIL,
  
              DOH  => DOH,
              DOL  => DOL);

  Divide : CNT
    generic map (n  => 18)
    port map (CLK   => CLK,
              RST   => RST,
              EN    => '1',

              CNT_O => CntD_O);

  PulseGen : Pulser
    port map (CLK    => CLK,
              RST    => RST,
              Trig   => CntD_O(17),
           
	      Enable => Enable);        -- Each LED display is enabled for ~ 2.6 ms

  Scan : CNT
    generic map (n  => 2)
    port map (CLK   => CLK,
              RST   => RST,
              EN    => Enable,

              CNT_O => CntS_O);

  AnodeL <= "1111" when CntS_O = "00" else
            "1011" when CntS_O = "01" else
            "1101" when CntS_O = "10" else
            "1110";

  DO <= DOH when CntS_O = "10" else DOL;

  PatternGen : SegDrv
    port map (DI => DO,
  
              Pattern  => PatternL);

  AnodeS <= AnodeL;
  PatternS <= "111111" & not NinBin(n-1);
  Pattern(7 downto 1) <= PatternS when CntS_O = "01" else
	                 PatternL;
  Pattern(0) <= '1';            -- We don't use the DP

end Display;
