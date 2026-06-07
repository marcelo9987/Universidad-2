----------------------------------------------------------------------------------
-- Company: Universidad de Nebrija
-- Engineer: Carlos Mestre
--
-- Create Date: 15.02.2026 23:57:50
-- Module Name: tb_top_practica1 - Behavioral
-- Project Name: Contador en FPGA
-- Target Devices: Diligent Nexys A7 T100
-- Revision 1.00
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_practica1 is
end tb_top_practica1;

architecture Behavioral of tb_top_practica1 is

    -- Declaramos el componente Top (o usamos entity work)
    component top_practica1 is
        Generic ( g_sim_debounce : integer );
        Port (
            clk, rst_n, btn_input : in STD_LOGIC;
            an : out STD_LOGIC_VECTOR (7 downto 0);
            seg : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    signal s_clk : STD_LOGIC := '0';
    signal s_rst_n : STD_LOGIC := '0'; -- Inicialmente reset activado (bajo)
    signal s_btn : STD_LOGIC := '0';
    signal s_an : STD_LOGIC_VECTOR (7 downto 0);
    signal s_seg : STD_LOGIC_VECTOR (6 downto 0);

    constant k_period : time := 10 ns;

begin

    -- Instanciamos el TOP con "Truco" de simulación (10 ciclos de rebote)
    DUT: top_practica1
    generic map ( g_sim_debounce => 10 )
    port map (
        clk => s_clk, rst_n => s_rst_n, btn_input => s_btn,
        an => s_an, seg => s_seg
    );

    p_clk: process begin
        s_clk <= '0'; wait for k_period/2;
        s_clk <= '1'; wait for k_period/2;
    end process;

    p_stim: process begin
        -- 1. Soltamos el Reset (es activo bajo, así que lo ponemos a 1)
        wait for 100 ns;
        s_rst_n <= '1';
        wait for 50 ns;

        -- 2. Pulsamos el botón (simulamos pulsación válida > 10 ciclos)
        s_btn <= '1';
        wait for 200 ns;
        s_btn <= '0';
        wait for 200 ns;

        -- 3. Observamos (en la onda) si cambian los segmentos
        -- y si los ánodos van rotando (multiplexación)
        wait for 2000 ns;

        assert false report "Fin Test Integración" severity failure;
        wait;
    end process;

end Behavioral;
