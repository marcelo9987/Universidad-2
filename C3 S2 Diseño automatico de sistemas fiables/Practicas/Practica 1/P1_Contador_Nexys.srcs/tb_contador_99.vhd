----------------------------------------------------------------------------------
-- Company: Universidad de Nebrija
-- Engineer: Carlos Mestre
--
-- Create Date: 15.02.2026 23:05:14
-- Module Name: tb_contador_99 - Behavioral
-- Project Name: Contador en FPGA
-- Target Devices: Diligent Nexys A7 T100
-- Revision 1.00
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_contador_99 is
-- Testbench: sin puertos
end tb_contador_99;

architecture Behavioral of tb_contador_99 is

    component contador_99 is
        Port (
            clk       : in STD_LOGIC;
            rst       : in STD_LOGIC;
            cnt_en    : in STD_LOGIC;
            cnt_units : out STD_LOGIC_VECTOR (3 downto 0);
            cnt_tens  : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Señales de conexión
    signal s_clk       : STD_LOGIC := '0';
    signal s_rst       : STD_LOGIC := '0';
    signal s_cnt_en    : STD_LOGIC := '0';
    signal s_cnt_units : STD_LOGIC_VECTOR (3 downto 0);
    signal s_cnt_tens  : STD_LOGIC_VECTOR (3 downto 0);

    constant k_period : time := 10 ns; -- 100 MHz

begin

    -- Instanciamos la Unidad bajo prueba (DUT)
    DUT: contador_99
    port map (
        clk       => s_clk,
        rst       => s_rst,
        cnt_en    => s_cnt_en,
        cnt_units => s_cnt_units,
        cnt_tens  => s_cnt_tens
    );

    -- Generación de Reloj
    p_clk: process
    begin
        s_clk <= '0'; wait for k_period/2;
        s_clk <= '1'; wait for k_period/2;
    end process;

    -- Proceso de estímulos
    p_stim: process
    begin
        -- 1. Reset inicial
        s_rst <= '1';
        wait for 50 ns;
        s_rst <= '0';
        wait for 50 ns;

        -- 2. Vamos a simular 110 pulsaciones para ver el ciclo completo (00 -> 99 -> 00)
        -- Usamos un bucle 'for' para no escribir 100 veces lo mismo
        for i in 1 to 110 loop

            -- Generamos un pulso de 'cnt_en' (un ciclo de reloj de ancho)
            -- Esto simula lo que haría el Edge_Detector al pulsar el botón
            s_cnt_en <= '1';
            wait for k_period;

            s_cnt_en <= '0';
            wait for k_period * 4; -- Esperamos un poco entre pulsos

        end loop;

        -- Fin
        assert false report "Fin de la simulación del Contador" severity failure;
        wait;
    end process;

end Behavioral;
