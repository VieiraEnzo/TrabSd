----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:43 04/28/2026 
-- Design Name: 
-- Module Name:    OR - Behavioral 
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

entity OR_Comp is
    Port (  A : in  STD_LOGIC_VECTOR (3 downto 0);
            B : in  STD_LOGIC_VECTOR (3 downto 0);
            Res : out  STD_LOGIC_VECTOR (3 downto 0);
            Flags : out  STD_LOGIC_VECTOR (3 downto 0) --Zero, Neg, Cout, Over
    );
end OR_Comp;

architecture Behavioral of OR_Comp is
begin

    Res <= A and B;
    Flags(0) <= (not(A(0)and B(0))) and (not(A(1)and B(1))) and (not(A(2)and B(2))) and (not(A(3)and B(3))); 
    Flags(1) <= '0'; --trocar
    Flags(2) <= '0';
    Flags(3) <= '0';

end Behavioral;