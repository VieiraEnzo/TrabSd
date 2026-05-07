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

    component GCD_Comp is
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

    component INVERT_Comp is
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
    signal res_gcd, flags_gcd : STD_LOGIC_VECTOR(3 downto 0);
    signal res_shift, flags_shift : STD_LOGIC_VECTOR(3 downto 0);
    signal res_xor, flags_xor : STD_LOGIC_VECTOR(3 downto 0);
    signal res_invert, flags_invert : STD_LOGIC_VECTOR(3 downto 0);

    
begin

    ULA_AND: AND_Comp port map (A => A, B => B, Res => res_and, Flags => flags_and);
    ULA_SUM: SUM_Comp port map (A => A, B => B, Res => res_sum, Flags => flags_sum);
    ULA_SUB: SUBTRACTION_Comp port map (A => A, B => B, Res => res_sub, Flags => flags_sub);
    ULA_OR: OR_Comp port map (A => A, B => B, Res => res_or, Flags => flags_or);
    ULA_GCD: GCD_Comp port map (A => A, B => B, Res => res_gcd, Flags => flags_gcd);
    ULA_SHIFT: SHIFT_Comp port map (A => A, B => B, Res => res_shift, Flags => flags_shift);
    ULA_XOR: XOR_Comp port map (A => A, B => B, Res => res_xor, Flags => flags_xor);
    ULA_INVERT: INVERT_Comp port map (A => A, B => B, Res => res_invert, Flags => flags_invert);

    process(A, B, Op, res_and, flags_and, res_sum, flags_sum, res_sub, flags_sub,
        res_or, flags_or, res_gcd, flags_gcd, res_shift, flags_shift,
        res_xor, flags_xor, res_invert, flags_invert)
    begin
        case Op is
            when "0001" =>
                Res <= res_and;
                Flags <= flags_and;
            when "0010" =>
                Res <= res_sum;
                Flags <= flags_sum;
            when "0011" =>
                Res <= res_sub;
                Flags <= flags_sub;
            when "0100" =>
                Res <= res_or;
                Flags <= flags_or;
            when "0101" =>
                Res <= res_gcd;
                Flags <= flags_gcd;
            when "0110" =>
                Res <= res_shift;
                Flags <= flags_shift;
            when "0111" =>
                Res <= res_xor;
                Flags <= flags_xor;
            when "1000" =>
                Res <= res_invert;
                Flags <= flags_invert;
            when others =>
                Res <= "1111";
                Flags <= "1111";
        end case;
    end process;


end Behavioral;
