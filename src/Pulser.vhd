library ieee;
use ieee.std_logic_1164.all;

entity Pulser is
    port (CLK    : in std_logic;
          RST    : in std_logic;
          Trig   : in std_logic;
           
          Enable : out std_logic);
end Pulser;

architecture RTL of Pulser is
  signal RstSt, PulseAct, PulseDeAct : std_logic;
begin

  Reset : process(CLK, RST, Trig)
  begin
    if RST = '1' then
      RstSt <= '1';
    elsif CLK'event and CLK = '1' then
      RstSt <= (RstSt or PulseDeAct) and not Trig;
    end if;
  end process;

  Load : process(CLK, RST, Trig, RstSt)
  begin
    if RST = '1' then
      PulseAct <= '0';
    elsif CLK'event and CLK = '1' then
      PulseAct <= RstSt and Trig;
    end if;
  end process; 

  Shift : process(CLK, RST, Trig, PulseAct)
  begin
    if RST = '1' then
      PulseDeAct <= '0';
    elsif CLK'event and CLK = '1' then
      PulseDeAct <= PulseAct or (PulseDeAct and Trig);
    end if;
  end process;

  Enable   <= PulseAct;

end RTL;
