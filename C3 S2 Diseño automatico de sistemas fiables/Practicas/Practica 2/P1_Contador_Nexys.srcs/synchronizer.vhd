----------------------------------------------------------------------------------
-- Company: Universidad de Nebrija
-- Engineer: Carlos Mestre
--
-- Create Date: 15.02.2026 22:56:39
-- Module Name: synchronizer - Behavioral
-- Project Name: Contador en FPGA
-- Target Devices: Diligent Nexys A7 T100
-- Revision 1.00
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity synchronizer is
    Port (
        clk      : in  STD_LOGIC;
        async_in : in  STD_LOGIC;
        sync_out : out STD_LOGIC
    );
end Synchronizer;

architecture Behavioral of synchronizer is
    -- Cadena de dos Flip-Flops
    signal s_reg : std_logic_vector(1 downto 0) := "00";
begin

    process(clk)
    begin
        if rising_edge(clk) then
            -- Desplazamos la entrada a través de los registros
            s_reg <= s_reg(0) & async_in;
        end if;
    end process;

    -- La salida es el segundo Flip-Flop (ya estabilizado)
    sync_out <= s_reg(1);

end Behavioral;
