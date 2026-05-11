library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ULA is
    Port (
        A     : in  STD_LOGIC_VECTOR (3 downto 0);
        B     : in  STD_LOGIC_VECTOR (3 downto 0);
        Op    : in  STD_LOGIC_VECTOR (3 downto 0);
        Res   : out STD_LOGIC_VECTOR (3 downto 0);
        Flags : out STD_LOGIC_VECTOR (3 downto 0)
    );
end ULA;

architecture Behavioral of ULA is

    component AND_Comp
        Port (
            A     : in  STD_LOGIC_VECTOR (3 downto 0);
            B     : in  STD_LOGIC_VECTOR (3 downto 0);
            Res   : out STD_LOGIC_VECTOR (3 downto 0);
            Flags : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component SUM_Comp
        Port (
            A     : in  STD_LOGIC_VECTOR (3 downto 0);
            B     : in  STD_LOGIC_VECTOR (3 downto 0);
            Res   : out STD_LOGIC_VECTOR (3 downto 0);
            Flags : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component SUBTRACTION_Comp
        Port (
            A     : in  STD_LOGIC_VECTOR (3 downto 0);
            B     : in  STD_LOGIC_VECTOR (3 downto 0);
            Res   : out STD_LOGIC_VECTOR (3 downto 0);
            Flags : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal ResAND, ResSUM, ResSUB : STD_LOGIC_VECTOR(3 downto 0);
    signal FlagAND, FlagSUM, FlagSUB : STD_LOGIC_VECTOR(3 downto 0);

begin

    U1 : AND_Comp
        port map (
            A => A,
            B => B,
            Res => ResAND,
            Flags => FlagAND
        );

    U2 : SUM_Comp
        port map (
            A => A,
            B => B,
            Res => ResSUM,
            Flags => FlagSUM
        );

    U3 : SUBTRACTION_Comp
        port map (
            A => A,
            B => B,
            Res => ResSUB,
            Flags => FlagSUB
        );

    process(Op, ResAND, ResSUM, ResSUB,
            FlagAND, FlagSUM, FlagSUB)
    begin

        case Op is

            when "0001" =>
                Res   <= ResAND;
                Flags <= FlagAND;

            when "0010" =>
                Res   <= ResSUM;
                Flags <= FlagSUM;

            when "0011" =>
                Res   <= ResSUB;
                Flags <= FlagSUB;

            when others =>
                Res   <= "0000";
                Flags <= "0000";

        end case;

    end process;

end Behavioral;
