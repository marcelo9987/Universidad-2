----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2024 09:22:59
-- Design Name: 
-- Module Name: ej5 - Behavioral
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

entity ej5 is
    Port ( 
           clk:in STD_LOGIC;
           x : in STD_LOGIC;
           o : out STD_LOGIC
          );
end ej5;

architecture Behavioral of ej5 is
type state_type is (E0,E1,E2);
signal estado_actual,siguiente_estado:state_type;

begin
p_ej5_clk : process(clk)
begin
    if(rising_edge(clk))then
        estado_actual<= siguiente_estado;
    end if;
end process p_ej5_clk;

p_ej5_c : process(estado_actual,x)
begin
case estado_actual is
    when E0 =>
    if(x='0')then
        siguiente_estado<=E1;
        o<='0';
    elsif(x='1')then
        siguiente_estado<=E0;
        o<='0';
   end if;
   
   when e1 =>
    if(x='0')then
        siguiente_estado<=E1;
        o<='0';
    elsif(x='1')then
        siguiente_estado<=e2;
        o<='0';
    end if;
    
    when E2 =>
    if(x='0')then
        siguiente_estado<=E1;
        o<='0';
    elsif(x='1')then
        siguiente_estado<=E0;
        o<='1';
    end if;
    
end case;
end process p_ej5_c;
    

end architecture Behavioral;
