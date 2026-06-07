library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_debouncer is
end entity tb_debouncer;

architecture sim of tb_debouncer is

    constant C_CLK_PERIOD : time    := 10 ns;
    constant C_TIMEOUT    : integer := 8;

    signal clk     : std_logic := '0';
    signal rst_n   : std_logic := '0';
    signal btn_in  : std_logic := '0';
    signal btn_out : std_logic;

begin

    DUT : entity work.debouncer
        generic map (
            g_timeout_cycles => C_TIMEOUT
        )
        port map (
            clk     => clk,
            rst     => rst_n,
            btn_in  => btn_in,
            btn_out => btn_out
        );

    clk <= not clk after C_CLK_PERIOD / 2;

    process
    begin

        -- INICIALIZACION
        rst_n  <= '0';
        btn_in <= '0';
        wait for C_CLK_PERIOD * 3;
        rst_n <= '1';
        wait for C_CLK_PERIOD * 2;

        -- CASO 1: Pulsacion limpia (sin rebotes)
        report "CASO 1: Pulsacion limpia iniciada" severity note;
        btn_in <= '1';
        wait for C_CLK_PERIOD * (C_TIMEOUT + 2);
        assert (btn_out = '1')
            report "ERROR CASO 1: btn_out deberia ser '1' tras pulsacion estable"
            severity error;

        btn_in <= '0';
        wait for C_CLK_PERIOD * (C_TIMEOUT + 2);
        assert (btn_out = '0')
            report "ERROR CASO 1: btn_out deberia volver a '0' tras soltar el boton"
            severity error;

        -- CASO 2: Rafaga de rebotes cortos (NO debe activar la salida)
        report "CASO 2: Rafaga de rebotes iniciada" severity note;
        btn_in <= '1'; wait for C_CLK_PERIOD * 3;
        btn_in <= '0'; wait for C_CLK_PERIOD * 3;
        btn_in <= '1'; wait for C_CLK_PERIOD * 2;
        btn_in <= '0'; wait for C_CLK_PERIOD * 2;
        btn_in <= '1'; wait for C_CLK_PERIOD * 3;
        btn_in <= '0'; wait for C_CLK_PERIOD * 2;
        btn_in <= '1'; wait for C_CLK_PERIOD * 2;
        btn_in <= '0'; wait for C_CLK_PERIOD * 3;
        assert (btn_out = '0')
            report "ERROR CASO 2: btn_out no deberia activarse con rebotes cortos"
            severity error;

        -- CASO 3: Pulsacion insuficiente (C_TIMEOUT - 1 ciclos)
        report "CASO 3: Pulsacion insuficiente (timeout - 1 ciclos)" severity note;
        btn_in <= '1';
        wait for C_CLK_PERIOD * (C_TIMEOUT - 1);
        btn_in <= '0';
        wait for C_CLK_PERIOD * 2;
        assert (btn_out = '0')
            report "ERROR CASO 3: btn_out no deberia activarse con C_TIMEOUT-1 ciclos"
            severity error;

        report "Simulation PASSED: tb_debouncer completado sin errores" severity note;
        wait;
    end process;

end architecture sim;