----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2024 08:38:53
-- Design Name: 
-- Module Name: automata - Behavioral
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

entity automata is
    Port(
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
    A,B : in STD_LOGIC;
    y : out STD_LOGIC
);
end automata;

architecture Behavioral of automata is
    type estado is (S0,S1,S2,S3,S4);
    signal estadoActual,estadoSiguiente : estado;

begin
    procesoSincrono:process(clk,rst)
    begin
        if(rst='1')then
            estadoActual<=S0;
        elsif(rising_edge(clk))then
            estadoActual<=estadoSiguiente;
        end if;
    end process procesoSincrono;

procesoCombinacional:process(estadoActual,estadoSiguiente,A,B)
begin
    case estadoActual is
        when S0 =>

            y<= '0';

            if(B='0')then
                estadoSiguiente <= S1;
            elsif(B='1')then
                estadoSiguiente <= S0;
            else
                estadoSiguiente <= S0;
            end if;


        when S1 =>

            y<='0';

            if      (A = '0')then
                estadoSiguiente <= S1;
            elsif   (B = '0') then
                estadoSiguiente <= S2;
            elsif   (B = '1')then
                estadoSiguiente <= S1;
            else 
                estadoSiguiente <= S0;
            end if;


        when S2 =>
            y<='1';
            if      (B = '1') then
                estadoSiguiente <= S3;
            elsif   (A = '1') then
                estadoSiguiente <= S2;
            elsif   (A = '0') then 
                estadoSiguiente <= S1;
            else
                estadoSiguiente <= S0;
            end if;

        when S3 =>
            y <= '0';
            if       (B = '0')  then
                estadoSiguiente <= S4;
            elsif    (B = '1') then
                estadoSiguiente <= S3;
            else
                estadoSiguiente <= S0;
            end if;
        when S4 =>
            y <= '0';
            if      (B = '0') then
                estadoSiguiente <= S1;
            elsif   (B='1') then
                estadoSiguiente <= S3;
            else
                estadoSiguiente <= S0;
            end if;

        when others => 
            estadoSiguiente<=S0;
        end case;
end process procesoCombinacional;

end Behavioral;
