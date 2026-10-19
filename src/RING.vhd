library ieee;
use ieee.std_logic_1164.all;
    
entity RING is
  generic (n   : integer);
  port (CLK    : in std_logic;
        RST    : in std_logic;
        SIN    : in std_logic; 
               
        SHFT_O : out std_logic_vector((n-1) downto 0));
end RING;

architecture RING of RING is
  signal ShftL   : std_logic_vector((n-1) downto 0) ;
begin
  
  process(CLK, RST, SIN)
  begin
    
    if RST = '1' then
      ShftL <= "011";
    elsif CLK'event and CLK = '1' then
      ShftL <= SIN & ShftL((n-1) downto 1);
    end if;
  end process;
  
  SHFT_O <= ShftL;
  
end RING;
