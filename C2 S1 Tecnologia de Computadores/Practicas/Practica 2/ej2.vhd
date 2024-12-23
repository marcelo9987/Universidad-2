----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2024 08:43:12
-- Design Name: 
-- Module Name: ej2 - Behavioral
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

entity ff_d is
    Port ( 
           d : in STD_LOGIC;
           clk : in STD_LOGIC;
           q : out STD_LOGIC
          );
end ff_d;

architecture Behavioral of ff_d is
signal salida:STD_LOGIC;
begin
    ff_d_p : process(clk)
    begin
        if(rising_edge(clk)) then
            if(d='1') then
                q <= d;
            else
                salida<=salida;
            end if;
         end if;
     end process ff_d_p;
     q <= salida;
end Behavioral;
