library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SdModulo is
    Port (
        SW        : in  STD_LOGIC_VECTOR (3 downto 0);
        BTN       : in  STD_LOGIC;

        LEDRes    : out STD_LOGIC_VECTOR (3 downto 0);

        FlagZero  : out STD_LOGIC;
        FlagNeg   : out STD_LOGIC;
        FlagCout  : out STD_LOGIC;
        FlagOver  : out STD_LOGIC
    );
end SdModulo;

architecture Behavioral of SdModulo is

    component Debouncing_Button_VHDL
        Port (
            button : in  STD_LOGIC;
            clk    : in  STD_LOGIC;
            result : out STD_LOGIC
        );
    end component;

    component ULA
        Port (
            A     : in  STD_LOGIC_VECTOR (3 downto 0);
            B     : in  STD_LOGIC_VECTOR (3 downto 0);
            Op    : in  STD_LOGIC_VECTOR (3 downto 0);
            Res   : out STD_LOGIC_VECTOR (3 downto 0);
            Flags : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal OpReg    : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal AReg     : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal BReg     : STD_LOGIC_VECTOR(3 downto 0) := "0000";

    signal State    : integer range 0 to 2 := 0;

    signal BtnClean : STD_LOGIC;

    signal ResULA   : STD_LOGIC_VECTOR(3 downto 0);
    signal FlagsULA : STD_LOGIC_VECTOR(3 downto 0);

begin

    ----------------------------------------------------------------
    -- Debounce do botão
    ----------------------------------------------------------------
    DB : Debouncing_Button_VHDL
        port map (
            button => BTN,
            clk    => BTN,
            result => BtnClean
        );

    ----------------------------------------------------------------
    -- Máquina simples de entrada
    -- Estado 0 -> recebe operação
    -- Estado 1 -> recebe A
    -- Estado 2 -> recebe B
    ----------------------------------------------------------------
    process(BtnClean)
    begin

        if rising_edge(BtnClean) then

            case State is

                when 0 =>
                    OpReg <= SW;
                    State <= 1;

                when 1 =>
                    AReg <= SW;
                    State <= 2;

                when 2 =>
                    BReg <= SW;
                    State <= 0;

                when others =>
                    State <= 0;

            end case;

        end if;

    end process;

    ----------------------------------------------------------------
    -- Instância da ULA
    ----------------------------------------------------------------
    U1 : ULA
        port map (
            A     => AReg,
            B     => BReg,
            Op    => OpReg,
            Res   => ResULA,
            Flags => FlagsULA
        );

    ----------------------------------------------------------------
    -- Saídas
    ----------------------------------------------------------------
    LEDRes <= ResULA;

    FlagZero <= FlagsULA(0);
    FlagNeg  <= FlagsULA(1);
    FlagCout <= FlagsULA(2);
    FlagOver <= FlagsULA(3);

end Behavioral;
