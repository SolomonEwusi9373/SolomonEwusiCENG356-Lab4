----------------------------------------------------------------
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity SegDrv is
  port (DI : in std_logic_vector(3 downto 0);

        Pattern  : out std_logic_vector(6 downto 0));
end SegDrv;

architecture SegDrv of SegDrv is
  signal DispType : std_logic := '0';  -- 0 for common-anode type
  signal PatternL : std_logic_vector(6 downto 0);
begin

  process(DI)
  begin
    case DI is
      ------------------------   abcdefg
      when "0000" => PatternL <= "0000001";
      when "0001" => PatternL <= "1001111";
      when "0010" => PatternL <= "0010010";
      when "0011" => PatternL <= "0000110";
      when "0100" => PatternL <= "1001100";
      when "0101" => PatternL <= "0100100";
      when "0110" => PatternL <= "0100000";
      when "0111" => PatternL <= "0001101";
      when "1000" => PatternL <= "0000000";
      when "1001" => PatternL <= "0000100";
      when others => PatternL <= "1001000";
    end case;
  end process;

  Pattern <= PatternL when DispType = '0' else
             not PatternL;

end SegDrv;
