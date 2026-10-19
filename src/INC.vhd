library ieee;
use ieee.std_logic_1164.all;

entity INC is
  generic (n : integer);
  port (A    : in std_logic_vector((n-1) downto 0);

        COUT : out std_logic;
        SUM  : out std_logic_vector((n-1) downto 0) );
end INC;

architecture INC of INC is
  signal P_Sum  : std_logic_vector((n-1) downto 0);
  signal Carry  : std_logic_vector(n downto 0);
  
begin
  
  process(A)
    variable cv : std_logic_vector(n downto 0);
    variable c_gen  : std_logic;
    variable c_prop : std_logic;
  begin
    cv(0) := '1';
    for i in 0 to A'left loop
      c_prop  := cv(i) and A(i);
      cv(i+1) := (c_prop and cv(i));
    end loop;
    Carry <= cv;
  end process;

  SUM  <= A xor Carry((n-1) downto 0);
  COUT <= Carry(n);

end INC;
