----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2024 09:42:45
-- Design Name: 
-- Module Name: DECOD2A4 - Behavioral
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

entity DECOD2A4 is
    Port ( a : in STD_LOGIC_VECTOR (1 downto 0);
           b : out STD_LOGIC_VECTOR (3 downto 0));
end DECOD2A4;

architecture Behavioral of DECOD2A4 is

begin
-- Hago la selección en base a a (2 elementos)
    with a select
    b <= 
        "0001" when"00",
        "0010" when"01",
        "0100" when"10",
        "1000" when"11",
        "0000" when others; -- hago una salida de 0 cuando la entrada no es la esperada
end Behavioral;
