library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ULA is
    Port ( 
        A      : in  STD_LOGIC_VECTOR (3 downto 0);
        B      : in  STD_LOGIC_VECTOR (3 downto 0);
        Op     : in  STD_LOGIC_VECTOR (3 downto 0);
        Res    : out STD_LOGIC_VECTOR (3 downto 0);
        Flags   : out STD_LOGIC_VECTOR (3 downto 0) --Zero, Neg, Cout, Over
    );
end ULA;

architecture Behavioral of ULA is

    component AND_Comp is
        Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
                B : in  STD_LOGIC_VECTOR (3 downto 0);
                Res : out  STD_LOGIC_VECTOR (3 downto 0);
                Flags : out  STD_LOGIC_VECTOR (3 downto 0)
            );
    end component;
        
    signal res_and, flags_and : STD_LOGIC_VECTOR(3 downto 0);

    
begin

    ULA_AND: AND_Comp port map (A => A, B => B, Res => res_and, Flags => flags_and);
    --Declarar aqui o resto

    process(A, B, Op, res_and, flags_and)
    begin
        case Op is
            when "0001" =>
                Res <= res_and;
                Flags <= flags_and;
            when others =>
                Res <= "0000";
                Flags <= "0000";
        end case;
    end process;


end Behavioral;
