----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2024 08:49:06
-- Design Name: 
-- Module Name: XNOR4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity XNOR4 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           y : out STD_LOGIC);
end XNOR4;

architecture Behavioral of XNOR4 is

begin
y <= (
        ((not a(0)) and (not a(1)) and (not a(2)) and a(3))
        or  
        ((not a(0)) and (not a(1)) and a(2) and (not a(3)))
        or
        ((not a(0)) and  a(1) and (not a(2)) and (not a(3)))
        or 
        ((not a(0)) and a(1) and a(2) and a(3))
        or
        (a(0) and (not a(1)) and (not(a(2)) and (not a(3))))
        or
        (a(0) and (not a(1)) and a(2) and a(3))
        or
        (a(0) and a(1) and (not(a(2)) and a(3)))
        or
        (a(0) and a(1) and (a(2) and not(a(3))))
    );
end Behavioral;
