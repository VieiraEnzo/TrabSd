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
    
    component SUM_Comp is
        Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
                B : in  STD_LOGIC_VECTOR (3 downto 0);
                Res : out  STD_LOGIC_VECTOR (3 downto 0);
                Flags : out  STD_LOGIC_VECTOR (3 downto 0)
            );
    end component;

    component SUBTRACTION_Comp is
        Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
                B : in  STD_LOGIC_VECTOR (3 downto 0);
                Res : out  STD_LOGIC_VECTOR (3 downto 0);
                Flags : out  STD_LOGIC_VECTOR (3 downto 0)
            );
    end component;

    component OR_Comp is
        Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
                B : in  STD_LOGIC_VECTOR (3 downto 0);
                Res : out  STD_LOGIC_VECTOR (3 downto 0);
                Flags : out  STD_LOGIC_VECTOR (3 downto 0)
            );
    end component;

    component LESS_Comp is
        Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
                B : in  STD_LOGIC_VECTOR (3 downto 0);
                Res : out  STD_LOGIC_VECTOR (3 downto 0);
                Flags : out  STD_LOGIC_VECTOR (3 downto 0)
            );
    end component;

    component SHIFT_Comp is
        Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
                B : in  STD_LOGIC_VECTOR (3 downto 0);
                Res : out  STD_LOGIC_VECTOR (3 downto 0);
                Flags : out  STD_LOGIC_VECTOR (3 downto 0)
            );
    end component;

    component XOR_Comp is
        Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
                B : in  STD_LOGIC_VECTOR (3 downto 0);
                Res : out  STD_LOGIC_VECTOR (3 downto 0);
                Flags : out  STD_LOGIC_VECTOR (3 downto 0)
            );
    end component;

    component GREATER_Comp is
        Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
                B : in  STD_LOGIC_VECTOR (3 downto 0);
                Res : out  STD_LOGIC_VECTOR (3 downto 0);
                Flags : out  STD_LOGIC_VECTOR (3 downto 0)
            );
    end component;

    signal res_and, flags_and : STD_LOGIC_VECTOR(3 downto 0);
    signal res_sum, flags_sum : STD_LOGIC_VECTOR(3 downto 0);
    signal res_sub, flags_sub : STD_LOGIC_VECTOR(3 downto 0);
    signal res_or, flags_or : STD_LOGIC_VECTOR(3 downto 0);
    signal res_less, flags_less : STD_LOGIC_VECTOR(3 downto 0);
    signal res_shift, flags_shift : STD_LOGIC_VECTOR(3 downto 0);
    signal res_xor, flags_xor : STD_LOGIC_VECTOR(3 downto 0);
    signal res_greater, flags_greater : STD_LOGIC_VECTOR(3 downto 0);

    
begin

    ULA_AND: AND_Comp port map (A => A, B => B, Res => res_and, Flags => flags_and);
    ULA_SUM: SUM_Comp port map (A => A, B => B, Res => res_sum, Flags => flags_sum);
    ULA_SUB: SUBTRACTION_Comp port map (A => A, B => B, Res => res_sub, Flags => flags_sub);
    ULA_OR: OR_Comp port map (A => A, B => B, Res => res_or, Flags => flags_or);
    ULA_LESS: LESS_Comp port map (A => A, B => B, Res => res_less, Flags => flags_less);
    ULA_SHIFT: SHIFT_Comp port map (A => A, B => B, Res => res_shift, Flags => flags_shift);
    ULA_XOR: XOR_Comp port map (A => A, B => B, Res => res_xor, Flags => flags_xor);
    ULA_GREATER: GREATER_Comp port map (A => A, B => B, Res => res_greater, Flags => flags_greater);

    process(A, B, Op, res_and, flags_and, res_sum, flags_sum, res_sub, flags_sub,
        res_or, flags_or, res_less, flags_less, res_shift, flags_shift,
        res_xor, flags_xor, res_greater, flags_greater)
    begin
        case Op is
            when "0001" => --and
                Res <= res_and;
                Flags <= flags_and;
            when "0010" => --or
                Res <= res_or;
                Flags <= flags_or;
            when "0011" => --xor
				    Res <= res_xor;
                Flags <= flags_xor;
            when "0100" => --sum
                Res <= res_sum;
                Flags <= flags_sum;
            when "0101" => --sub
                Res <= res_sub;
                Flags <= flags_sub;
            when "0110" => --greater
                Res <= res_greater;
                Flags <= flags_greater;
            when "0111" => --less
                Res <= res_less;
                Flags <= flags_less;
            when "1000" => --shift
					 Res <= res_shift;
                Flags <= flags_shift;
            when others =>
                Res <= "1111";
                Flags <= "1111";
        end case;
    end process;


end Behavioral;
