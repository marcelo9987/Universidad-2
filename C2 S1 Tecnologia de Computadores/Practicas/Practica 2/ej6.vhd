----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2024 09:40:14
-- Design Name: 
-- Module Name: ej6 - Behavioral
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

entity ej6 is
    Port ( 
           x : in STD_LOGIC;
           clk : in STD_LOGIC;
           o : out STD_LOGIC
          );
end ej6;

architecture Behavioral of ej6 is
    type state_type is (E0, E1, E2, E3);
    signal EA, ES : state_type;
begin

p_ej6_clk : process(CLK) begin
    if (rising_edge(CLK)) then
        EA <= ES;
    end if;
end process p_ej6_clk;

p_ej6_c : process(EA, X) begin
    case EA is
    when E0 =>
        o <= '0';
        if (x = '0') then
            ES <= E1;
        else
            ES <= E0;
        end if;

    when E1 =>
        o <= '0';
        if (x = '0') then
            ES <= E1; 
        else
            ES <= E2;
        end if;


    when E2 =>
        o <= '0';
        if (x = '0') then
            ES <= E1;
        else
            ES <= E3;
        end if;

    when E3 =>
        o <= '1';
        if (x = '0') then
            ES <= E3;
        else
            ES <= E0;
        end if;
    end case;
end process p_ej6_c;


end Behavioral;
