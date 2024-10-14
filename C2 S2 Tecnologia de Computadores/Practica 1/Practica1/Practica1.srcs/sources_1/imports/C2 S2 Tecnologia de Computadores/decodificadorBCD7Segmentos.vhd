----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2024 09:47:14
-- Design Name: 
-- Module Name: decodificadorBCD7Segmentos - Behavioral
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

entity decodificadorBCD7Segmentos is
    Port ( entrada : in STD_LOGIC_VECTOR (3 downto 0);
           segmentos : out STD_LOGIC_VECTOR (7 downto 0));
end decodificadorBCD7Segmentos;

architecture Behavioral of decodificadorBCD7Segmentos is

begin
-- Selecciono dependiendo de que número quiero representar en el BCD
with entrada select
    segmentos <= -- gfedcbap
        "01111110" when "0000", -- 0
        "00001100" when "0001", -- 1 
        "10110110" when "0010", -- 2
        "10111010" when "0011", -- 3
        "11001100" when "0100", -- 4
        "11011010" when "0101", -- 5
        "11111010" when "0110", -- 6
        "00001110" when "0111", -- 7
        "11111110" when "1000", -- 8
        "11001110" when "1001", -- 9
        "11111111" when others; -- resto de entradas
end Behavioral;
