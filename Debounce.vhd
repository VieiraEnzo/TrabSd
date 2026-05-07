----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:58:19 04/28/2026 
-- Design Name: 
-- Module Name:    Debounce - Behavioral 
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

entity Debounce is
    Port ( CLK : in  STD_LOGIC;
           Btn_in : in  STD_LOGIC;
           Db : out  STD_LOGIC);
end Debounce;

architecture Behavioral of Debounce is

	constant max: integer := 50000000;

begin

	process(CLK)
		variable Count : integer range 0 to max :=0;
		variable Btn_prev : STD_LOGIC := '0';
	
	begin
		
		if falling_edge (CLK) then
			if Btn_in /= Btn_prev and Count = 0 then
				Db <= Btn_in;
				Btn_prev := Btn_in;
				Count := 1;
			end if;
			
			if Count > 0 then
				Count := Count + 1;
				if Count > max then 
					Count := 0;
				end if;	
			end if;
		end if;
	end process;


end Behavioral;

