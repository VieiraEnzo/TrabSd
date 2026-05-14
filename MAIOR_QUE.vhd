library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GREATER_Comp is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0);
        Res   : out STD_LOGIC_VECTOR(3 downto 0);
        Flags : out STD_LOGIC_VECTOR(3 downto 0)  -- Zero, Neg, Cout, Over
    );
end GREATER_Comp;

architecture Behavioral of GREATER_Comp is
    signal temp_res : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin

    process(A, B)
        variable v_greater : STD_LOGIC;
        variable v_res     : STD_LOGIC_VECTOR(3 downto 0);
    begin
        -- Valores padrão
        v_greater := '0';
        v_res     := "0000";

        -- Caso 1: sinais diferentes
        -- Se A é positivo e B é negativo, então A é maior
        if A(3) /= B(3) then
            if A(3) = '0' then
                v_greater := '1';
            end if;

        -- Caso 2: sinais iguais
        -- Aqui basta comparar bit a bit do MSB para o LSB
        else
            if A(2) /= B(2) then
                if A(2) = '1' then
                    v_greater := '1';
                end if;

            elsif A(1) /= B(1) then
                if A(1) = '1' then
                    v_greater := '1';
                end if;

            elsif A(0) /= B(0) then
                if A(0) = '1' then
                    v_greater := '1';
                end if;
            end if;
        end if;

        -- Saída da operação:
        -- 0001 quando A > B, senão 0000
        if v_greater = '1' then
            v_res := "0001";
        else
            v_res := "0000";
        end if;

        temp_res <= v_res;
    end process;

    Res <= temp_res;

    -- Flags:
    -- Zero = 1 quando o resultado da comparação foi falso
    Flags(0) <= '1' when temp_res = "0000" else '0';
    Flags(1) <= '0';
    Flags(2) <= '0';
    Flags(3) <= '0';

end Behavioral;
