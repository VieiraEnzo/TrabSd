----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:43 04/28/2026 
-- Design Name: 
-- Module Name:    SHIFT - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 4-bit Shift Left Logical component with flags using Signals.
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

entity SHIFT_Comp is
    Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
            B : in  STD_LOGIC_VECTOR (3 downto 0);
            Res : out  STD_LOGIC_VECTOR (3 downto 0);
            Flags : out  STD_LOGIC_VECTOR (3 downto 0) --Zero, Neg, Cout, Over
    );
end SHIFT_Comp;

architecture Behavioral of SHIFT_Comp is

    signal tmp_res  : STD_LOGIC_VECTOR(3 downto 0);
    signal tmp_cout : STD_LOGIC;
    signal tmp_over : STD_LOGIC;

begin

    process(A, B)
    begin
        case B is
            when "0000" => 
                tmp_res  <= A;
                tmp_cout <= '0';
                tmp_over <= '0';
                
            when "0001" => 
                tmp_res  <= A(2 downto 0) & '0';
                tmp_cout <= A(3);
                tmp_over <= A(3) xor A(2);
                
            when "0010" => 
                tmp_res  <= A(1 downto 0) & "00";
                tmp_cout <= A(2);
                tmp_over <= (A(3) xor A(2)) or (A(2) xor A(1));
                
            when "0011" => 
                tmp_res  <= A(0) & "000";
                tmp_cout <= A(1);
                tmp_over <= (A(3) xor A(2)) or (A(2) xor A(1)) or (A(1) xor A(0));
                
            when others => 
                tmp_res  <= "0000";
                tmp_cout <= '0';
                if (A = "0000") then
                    tmp_over <= '0';
                else
                    tmp_over <= '1';
                end if;
        end case;
    end process;

    Res <= tmp_res;
    Flags(0) <= '1' when tmp_res = "0000" else '0';
    Flags(1) <= tmp_res(3);
    Flags(2) <= tmp_cout;
    Flags(3) <= tmp_over;

end Behavioral;
