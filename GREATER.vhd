library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GREATER_Comp is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0);
        Res   : out STD_LOGIC_VECTOR(3 downto 0);
        Flags : out STD_LOGIC_VECTOR(3 downto 0)
    );
end GREATER_Comp;

architecture Behavioral of GREATER_Comp is
begin
    process(A, B)
    begin
        if signed(A) > signed(B) then
            Res <= "0001";
        else
            Res <= "0000";
        end if;

        Flags(0) <= '1' when Res = "0000" else '0'; -- zero
        Flags(1) <= '0'; -- negativo não é muito útil aqui
        Flags(2) <= '0'; -- carry não se aplica
        Flags(3) <= '0'; -- overflow não se aplica
    end process;
end Behavioral;
