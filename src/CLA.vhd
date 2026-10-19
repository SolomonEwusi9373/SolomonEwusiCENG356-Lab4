library ieee;
use ieee.std_logic_1164.all;

entity CLA is
  generic (n : integer );
  port (A    : in std_logic_vector((n-1) downto 0);
        B    : in std_logic_vector((n-1) downto 0);
        CIN  : in std_logic;

        COUT : out std_logic;
        SUM  : out std_logic_vector((n-1) downto 0) );
end CLA;

architecture CLA of CLA is
  signal P_Sum  : std_logic_vector((n-1) downto 0);
  signal Carry  : std_logic_vector(n downto 0);
  
begin
  
  process(A, B, CIN)
    variable cv : std_logic_vector(n downto 0);
    variable c_gen  : std_logic;
    variable c_prop : std_logic;
  begin
    cv(0) := CIN;
    for i in 0 to A'left loop
      c_gen   := A(i) and B(i);
      c_prop  := cv(i) and (A(i) or B(i));
      cv(i+1) := c_gen or (c_prop and cv(i));
    end loop;
    Carry <= cv;
  end process;

  SUM  <= A xor B xor Carry((n-1) downto 0);
  COUT <= Carry(n);

end CLA;
