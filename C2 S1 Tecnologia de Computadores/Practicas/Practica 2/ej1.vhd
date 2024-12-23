----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2024 08:34:13
-- Design Name: 
-- Module Name: ej1 - Behavioral
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
entity ff_jk is
       port(
                J   : in STD_LOGIC;
                K   : in STD_LOGIC;
                clk : in STD_LOGIC;
                Q   : out STD_LOGIC
            );
    end;
   
    architecture beh of ff_jk is
        signal aux : STD_LOGIC;
    begin
        ff_jk_p:process(clk)
        begin
            if(rising_edge(clk)) then
                if(J='0' and K='0') then
                    aux <= aux;
                elsif(J='1' and K='1')then
                    aux <= not aux;
                elsif(K='1') then
                    aux <= '0';
                else
                    aux <= '1';
                end if;
            end if;
    end process ff_jk_p;
    Q<=aux;
end beh;
            