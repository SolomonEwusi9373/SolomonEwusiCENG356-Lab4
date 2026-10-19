library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CNT is
  generic(n  : integer);
  port(CLK   : in std_logic;
       RST   : in std_logic;
       En    : in std_logic;

       CNT_O : out std_logic_vector((n-1) downto 0));
end CNT;

architecture RTL of CNT is
  signal CntL : std_logic_vector((n-1) downto 0);
begin

  process(RST, CLK, En)
  begin
    if RST = '1' then
      CntL <= (others => '0');
    elsif CLK'event and CLK = '1' then
      if En = '1' then
        CntL <= CntL + '1';
      end if;
    end if;
  end process;

  CNT_O <= CntL;

end RTL;
