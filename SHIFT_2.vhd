library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SHIFT_Comp is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0); -- não usado, mantido no padrão
        Res   : out STD_LOGIC_VECTOR(3 downto 0);
        Flags : out STD_LOGIC_VECTOR(3 downto 0)  -- Zero, Neg, Cout, Over
    );
end SHIFT_Comp;

architecture Behavioral of SHIFT_Comp is
    signal temp_res : STD_LOGIC_VECTOR(3 downto 0);
begin

    -- Deslocamento lógico para a esquerda de 2 bits:
    -- A = abcd  ->  cd00
    temp_res <= A(1 downto 0) & "00";

    Res <= temp_res;

    Flags(0) <= '1' when temp_res = "0000" else '0';
    Flags(1) <= temp_res(3);
    Flags(2) <= A(3) or A(2);
    Flags(3) <= '0';

end Behavioral;
