library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SUBTRACTION_Comp is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0);
        Res   : out STD_LOGIC_VECTOR(3 downto 0);
        Flags : out STD_LOGIC_VECTOR(3 downto 0)  -- Zero, Neg, Cout, Over
    );
end SUBTRACTION_Comp;

architecture Behavioral of SUBTRACTION_Comp is
    signal Bn : STD_LOGIC_VECTOR(3 downto 0);
    signal C  : STD_LOGIC_VECTOR(4 downto 0);
    signal S  : STD_LOGIC_VECTOR(3 downto 0);
begin
    Bn(0) <= not B(0);
    Bn(1) <= not B(1);
    Bn(2) <= not B(2);
    Bn(3) <= not B(3);

    C(0) <= '1';  -- soma do complemento

    S(0) <= A(0) xor Bn(0) xor C(0);
    C(1) <= (A(0) and Bn(0)) or (A(0) and C(0)) or (Bn(0) and C(0));

    S(1) <= A(1) xor Bn(1) xor C(1);
    C(2) <= (A(1) and Bn(1)) or (A(1) and C(1)) or (Bn(1) and C(1));

    S(2) <= A(2) xor Bn(2) xor C(2);
    C(3) <= (A(2) and Bn(2)) or (A(2) and C(2)) or (Bn(2) and C(2));

    S(3) <= A(3) xor Bn(3) xor C(3);
    C(4) <= (A(3) and Bn(3)) or (A(3) and C(3)) or (Bn(3) and C(3));

    Res <= S;

    Flags(0) <= '1' when S = "0000" else '0';           -- Zero
    Flags(1) <= S(3);                                   -- Neg
    Flags(2) <= C(4);                                   -- Cout (1 = sem borrow)
    Flags(3) <= C(3) xor C(4);                          -- Overflow
end Behavioral;
