library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SUBTRACTION_Comp is
    Port (
        A     : in  STD_LOGIC_VECTOR (3 downto 0);
        B     : in  STD_LOGIC_VECTOR (3 downto 0);
        Res   : out STD_LOGIC_VECTOR (3 downto 0);
        Flags : out STD_LOGIC_VECTOR (3 downto 0)  -- Zero, Neg, Cout, Over
    );
end SUBTRACTION_Comp;

architecture Behavioral of SUBTRACTION_Comp is
    signal tmp : unsigned(4 downto 0);
begin
    tmp <= unsigned('0' & A) + unsigned('0' & (not B)) + 1;

    Res <= std_logic_vector(tmp(3 downto 0));

    Flags(0) <= '1' when tmp(3 downto 0) = "0000" else '0';           -- Zero
    Flags(1) <= tmp(3);                                               -- Neg
    Flags(2) <= tmp(4);                                               -- Cout (1 = sem borrow)
    Flags(3) <= '1' when (A(3) /= B(3)) and (tmp(3) /= A(3)) else '0'; -- Over
end Behavioral;
