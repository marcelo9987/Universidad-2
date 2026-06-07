----------------------------------------------------------------------------------
-- Company: Universidad de Nebrija
-- Engineer: Carlos Mestre
--
-- Create Date: 15.02.2026 22:58:03
-- Module Name: tb_debouncer - Behavioral
-- Project Name: Contador en FPGA
-- Target Devices: Diligent Nexys A7 T100
-- Revision 1.00
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_debouncer is
-- El testbench no tiene puertos
end tb_debouncer;

architecture Behavioral of tb_debouncer is

    component debouncer is
        Generic ( g_timeout_cycles : integer );
        Port ( clk, rst, btn_in : in STD_LOGIC; btn_out : out STD_LOGIC );
    end component;

    signal s_clk     : STD_LOGIC := '0';
    signal s_rst     : STD_LOGIC := '0';
    signal s_btn_in  : STD_LOGIC := '0';
    signal s_btn_out : STD_LOGIC;

    -- Constante de reloj (100 MHz = 10 ns)
    constant k_period : time := 10 ns;

begin

    -- Instanciamos el debouncer con POCOS CICLOS para simular rápido
    DUT: debouncer
    generic map ( g_timeout_cycles => 10 ) -- Solo 10 ciclos para testear
    port map (
        clk     => s_clk,
        rst     => s_rst,
        btn_in  => s_btn_in,
        btn_out => s_btn_out
    );

    -- Generación de Reloj
    p_clk: process
    begin
        s_clk <= '0'; wait for k_period/2;
        s_clk <= '1'; wait for k_period/2;
    end process;

    -- Proceso de estímulos (Simulando un dedo nervioso)
    p_stim: process
    begin
        -- 1. Reset inicial
        s_rst <= '1'; wait for 50 ns;
        s_rst <= '0'; wait for 50 ns;

        -- 2. Ruido/Rebotes (Pulsaciones cortas que NO deben activar la salida)
        -- El debouncer necesita 10 ciclos (100ns) estables. Daremos menos.
        s_btn_in <= '1'; wait for 20 ns; -- Ruido
        s_btn_in <= '0'; wait for 20 ns;
        s_btn_in <= '1'; wait for 30 ns; -- Ruido un poco mas largo
        s_btn_in <= '0'; wait for 20 ns;

        -- 3. Pulsación Real (Larga y estable)
        wait for 100 ns;
        s_btn_in <= '1';
        wait for 500 ns; -- Mucho más de 100ns -> Debe activarse s_btn_out

        -- 4. Soltamos el botón
        s_btn_in <= '0';
        wait for 200 ns;

        assert false report "Fin de la simulacion" severity failure;
        wait;
    end process;

end Behavioral;
