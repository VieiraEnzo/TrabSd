----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:43 04/28/2026 
-- Design Name: 
-- Module Name:    XOR - Behavioral 
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

entity XOR_Comp is
    Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
            B : in  STD_LOGIC_VECTOR (3 downto 0);
            Res : out  STD_LOGIC_VECTOR (3 downto 0);
            Flags : out  STD_LOGIC_VECTOR (3 downto 0) --Zero, Neg, Cout, Over
    );
end XOR_Comp;

architecture Behavioral of XOR_Comp is
begin
end Behavioral;