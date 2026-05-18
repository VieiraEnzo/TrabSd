library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity INVERT_Comp is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0); -- não usado, mas mantido no padrão
        Res   : out STD_LOGIC_VECTOR(3 downto 0);
        Flags : out STD_LOGIC_VECTOR(3 downto 0)  -- Zero, Neg, Cout, Over
    );
end INVERT_Comp;

architecture Behavioral of INVERT_Comp is
    signal temp_res : STD_LOGIC_VECTOR(3 downto 0);
begin

    -- Inverte todos os bits de A
    temp_res <= not A;

    Res <= temp_res;

    -- Zero: resultado ficou 0000
    Flags(0) <= '1' when temp_res = "0000" else '0';

    -- Negativo: bit mais significativo do resultado
    Flags(1) <= temp_res(3);

    -- Carry out: não se aplica aqui
    Flags(2) <= '0';

    -- Overflow: não se aplica aqui
    Flags(3) <= '0';

end Behavioral;
