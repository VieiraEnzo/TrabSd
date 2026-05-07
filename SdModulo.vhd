----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:32:59 04/28/2026 
-- Design Name: 
-- Module Name:    SdModulo - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SdModulo is
    Port ( 
			clk : in STD_LOGIC;
			Btn : in  STD_LOGIC;
			VecIn	: in STD_LOGIC_VECTOR (3 downto 0);
			VecLed : out  STD_LOGIC_VECTOR (3 downto 0);
			FlagZero : out  STD_LOGIC;
			FlagNeg : out  STD_LOGIC;
			FlagCout : out  STD_LOGIC;
			FlagOver : out  STD_LOGIC);
end SdModulo;

architecture Behavioral of SdModulo is

	component Debounce is
		  Port ( CLK : in  STD_LOGIC;
			  Btn_in : in  STD_LOGIC;
			  Db : out  STD_LOGIC);
	end component;

	component ULA is
		Port ( 
			A      : in  STD_LOGIC_VECTOR (3 downto 0);
			B      : in  STD_LOGIC_VECTOR (3 downto 0);
			Op     : in  STD_LOGIC_VECTOR (3 downto 0);
			Res    : out STD_LOGIC_VECTOR (3 downto 0);
			Flags   : out STD_LOGIC_VECTOR (3 downto 0) --Zero, Neg, Cout, Over
		);
	end component;

	--Maquina de stados
	type state_type is (ST_OP, ST_A, ST_B, ST_RESULT);
	signal state : state_type := ST_OP;
	signal in_A, in_B, in_Op, F , R: STD_LOGIC_VECTOR (3 downto 0);
	signal debounced_button : STD_LOGIC;
	signal db_prev : STD_LOGIC := '0';
	signal can_print : STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin

	DB : Debounce port map ( CLK => clk, Btn_in => Btn, Db => debounced_button );
	U1 : ULA port map (A => in_A, B => in_B, Op => in_Op, Res => R, Flags => F);

	process(clk)
	begin
		if rising_edge(clk) then
			if debounced_button = '1' and db_prev = '0' then
				case state is
					when ST_OP =>
						in_Op <= VecIn;
						state <= ST_A;
					when ST_A =>
						in_A <= VecIn;
						state <= ST_B;
					when ST_B =>
						in_B <= VecIn;
						state <= ST_RESULT;
						can_print <= "1111";
					when ST_RESULT =>
						state <= ST_OP;
						can_print <= "0000";
				end case;
			end if;
			db_prev <= debounced_button;
		end if;
	end process;

			
	VecLed <= R and can_print;
   	FlagZero <= debounced_button;
	FlagNeg <= Btn;
	FlagCout <= F(2) and F(1) and F(0);
	FlagOver <= F(3);


end Behavioral;

