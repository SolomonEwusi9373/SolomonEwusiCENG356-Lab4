library ieee;
use ieee.std_logic_1164.all;

entity WrapperTb is
end WrapperTb;

architecture behave of WrapperTb is
  
  component Wrapper
    generic (n : integer);  -- for synthesis
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
  end component;

  constant NofBits : integer := 6; 
  signal A    : std_logic_vector((NofBits-1) downto 0);
  signal B    : std_logic_vector((NofBits-1) downto 0);
  signal S    : std_logic_vector(2 downto 0);
  signal RST  : std_logic;
  signal CLK  : std_logic;
  signal OVF  : std_logic;
  signal CF   : std_logic;
  signal NF   : std_logic;
  signal ZF   : std_logic;
  signal RSLT : std_logic_vector((NofBits-1) downto 0);
  signal Anodes  : std_logic_vector(3 downto 0);
  signal Pattern : std_logic_vector(7 downto 0);

begin

  ALUDisplay : Wrapper
    generic map (n => NofBits)
    port map (A    => A,
              B    => B,
              S    => S,
              RST  => RST,
              CLK  => CLK,

              OVF  => OVF,
              CF   => CF,
              NF   => NF,
              ZF   => ZF,
              RSLT => RSLT,
              Anodes  => Anodes,
              Pattern => Pattern);

  process
  begin
    RST <= '1';
    wait for 22 ns;
    RST <= '0';
    wait;
  end process;

  process
  begin
    CLK <= '0';
    wait for 5 ns;
    CLK <= '1';
    wait for 5 ns;
   end process;
   
  process
  begin
    wait for 102 ns;
    A <= "101001";
    B <= "001110";
    S <= "000";
    wait for 20 ms;
    S <= "001";
    wait for 20 ms;
    S <= "010";
    wait for 20 ms;
    S <= "011";
    wait for 20 ms;
    S <= "100";
    wait for 20 ms;
    S <= "101";
    wait for 20 ms;
    S <= "110";
    wait for 20 ms;
    S <= "111";
    wait for 20 ms;
    A <= "101011";
    B <= "101010";
    S <= "000";
    wait for 20 ms;
    S <= "001";
    wait for 20 ms;
    A <= "011001";
    B <= "100011";
    S <= "000";
    wait for 20 ms;
    S <= "001";
    wait for 20 ms;
    A <= "011111";
    B <= "011111";
    S <= "000";
    wait for 20 ms;
    S <= "001";
    wait for 20 ms;
    A <= "000000";
    B <= "011111";
    S <= "000";
    wait for 20 ms;
    S <= "001";
    wait for 20 ms;
    A <= "100000";
    B <= "000000";
    S <= "000";
    wait for 20 ms;
    S <= "001";
    wait;
  end process;

end behave;
