library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SUM_Comp is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0);
        Res   : out STD_LOGIC_VECTOR(3 downto 0);
        Flags : out STD_LOGIC_VECTOR(3 downto 0)  -- Zero, Neg, Cout, Over
    );
end SUM_Comp;

architecture Behavioral of SUM_Comp is
    signal C : STD_LOGIC_VECTOR(4 downto 0);
    signal S : STD_LOGIC_VECTOR(3 downto 0);
begin
    C(0) <= '0';

    -- bit 0
    S(0) <= A(0) xor B(0) xor C(0);
    C(1) <= (A(0) and B(0)) or (A(0) and C(0)) or (B(0) and C(0));

    -- bit 1
    S(1) <= A(1) xor B(1) xor C(1);
    C(2) <= (A(1) and B(1)) or (A(1) and C(1)) or (B(1) and C(1));

    -- bit 2
    S(2) <= A(2) xor B(2) xor C(2);
    C(3) <= (A(2) and B(2)) or (A(2) and C(2)) or (B(2) and C(2));

    -- bit 3
    S(3) <= A(3) xor B(3) xor C(3);
    C(4) <= (A(3) and B(3)) or (A(3) and C(3)) or (B(3) and C(3));

    Res <= S;

    Flags(0) <= '1' when S = "0000" else '0';           -- Zero
    Flags(1) <= S(3);                                   -- Neg
    Flags(2) <= C(4);                                   -- Cout
    Flags(3) <= C(3) xor C(4);                          -- Overflow
end Behavioral;
