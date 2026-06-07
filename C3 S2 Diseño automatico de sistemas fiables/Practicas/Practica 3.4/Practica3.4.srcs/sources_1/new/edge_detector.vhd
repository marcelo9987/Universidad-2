----------------------------------------------------------------------------------
-- Company: Universidad de Nebrija
-- Engineer: Carlos Mestre
--
-- Create Date: 15.02.2026 22:30:21
-- Module Name: edge_detector - Behavioral
-- Project Name: Contador en FPGA
-- Target Devices: Diligent Nexys A7 T100
-- Revision 1.00
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector is
    Port (
        clk     : in  STD_LOGIC;
        sig_in  : in  STD_LOGIC; -- Señal limpia del debouncer
        edge_out: out STD_LOGIC  -- Pulso de 1 ciclo
    );
end Edge_Detector;

architecture Behavioral of edge_detector is
    signal s_prev : std_logic := '0';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            -- Guardamos el estado anterior en cada ciclo
            s_prev <= sig_in;
        end if;
    end process;

    -- Hay flanco positivo si AHORA es 1 y ANTES era 0
    edge_out <= '1' when (sig_in = '1' and s_prev = '0') else '0';

end Behavioral;
