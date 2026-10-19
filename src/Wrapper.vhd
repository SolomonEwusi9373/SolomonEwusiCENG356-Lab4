library ieee;
use ieee.std_logic_1164.all;

entity Wrapper is
  -- generic (n : integer);
  generic (n : integer := 6);  -- for synthesis
  port (A    : in std_logic_vector((n-1) downto 0);
        B    : in std_logic_vector((n-1) downto 0);
        S    : in std_logic_vector(2 downto 0);
        RST  : in std_logic;
        CLK  : in std_logic;

        OVF  : out std_logic;
        CF   : out std_logic;
        NF   : out std_logic;
        ZF   : out std_logic;
        RSLT : out std_logic_vector((n-1) downto 0);
        Anodes  : out std_logic_vector(3 downto 0);
        Pattern : out std_logic_vector(7 downto 0));
end Wrapper;

architecture Wrapper of Wrapper is

  component ALU
    generic (n : integer);
    port (A    : in std_logic_vector((n-1) downto 0);
          B    : in std_logic_vector((n-1) downto 0);
          S    : in std_logic_vector(2 downto 0);

          RSLT : out std_logic_vector((n-1) downto 0);
          OVF  : out std_logic;
          CF   : out std_logic;
          NF   : out std_logic;
          ZF   : out std_logic);
  end component;

  component Display
    generic (n : integer);
    port (RST     : in std_logic;
          CLK     : in std_logic;
	  NinBin  : in std_logic_vector((n-1) downto 0);

          Anodes  : out std_logic_vector(3 downto 0);
          Pattern : out std_logic_vector(7 downto 0));
  end component;

  signal RSLTL   : std_logic_vector((n-1) downto 0);
  signal NinBin  : std_logic_vector((n-1) downto 0);
  
begin

  ArithLogic : ALU
    generic map (n   => n)
      port map (A    => A,
                B    => B,
                S    => S,

                RSLT => RSLTL,
                OVF  => OVF,
                CF   => CF,
                NF   => NF,
                ZF   => ZF);
      
  RSLT <= RSLTL;
 
  LED : Display
    generic map (n    => n)
    port map (RST     => RST,
              CLK     => CLK,
	      NinBin  => RSLTL,

              Anodes  => Anodes,
              Pattern => Pattern);

end Wrapper;
