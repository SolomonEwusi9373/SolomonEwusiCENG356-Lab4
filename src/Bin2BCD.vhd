----------------------------------------------------------------
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Bin2BCD is
  generic (n : integer);  
  -- generic (n : integer := 6);  -- for synthesis
  port (DI  : in std_logic_vector((n-1) downto 0);

        DOH : out std_logic_vector(3 downto 0);
        DOL : out std_logic_vector(3 downto 0));
end Bin2BCD;

architecture Bin2BCD of Bin2BCD is
  constant NofDigits : integer := 2;   -- For a 6-bit ALU, max. absolute value to display = 32
  constant NofBits   : integer := 4*NofDigits - 2;  -- BCD for the MSD requires only 2 bits
begin

  process(DI)
    variable TotalBits : std_logic_vector((n+NofBits-1) downto 0);
  begin
    TotalBits := (others => '0');        -- Initialize TotalBits to 0
    TotalBits((n+2) downto 3) := DI;     -- Then, load DI and left shift 3 bit positions
    for i in 0 to (n-4) loop                -- for each decade, which is larger than 4, add 3
      if TotalBits((n+3) downto n) > 4 then -- Again, we are assuming 2-digit decimal numbers.
        TotalBits((n+3) downto n) := TotalBits((n+3) downto n) + 3;
      end if;
      TotalBits((n+NofBits-1) downto (i+1)) := TotalBits((n+NofBits-2) downto i);  -- Right shift 1 bit
    end loop;
   
    DOH <= "00" & TotalBits((n+5) downto (n+4));
    DOL <= TotalBits((n+3) downto n);
  end process;

end Bin2BCD;
