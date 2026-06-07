library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_debouncer is
    -- Los testbenches no tienen puertos
end entity tb_debouncer;

architecture sim of tb_debouncer is

    -- Parametros de simulacion
    constant C_CLK_PERIOD  : time    := 10 ns;   -- Reloj de 100 MHz
    constant C_TIMEOUT     : integer := 8;        -- Valor reducido del generico para simulacion
    -- Con C_TIMEOUT = 8, el debouncer requiere 8 ciclos de estabilidad = 80 ns

    -- Senales de estimulo y observacion
    signal clk     : std_logic := '0';
    signal rst_n   : std_logic := '0';
    signal btn_in  : std_logic := '0';
    signal btn_out : std_logic;

begin

    -- Instanciacion del Device Under Test (DUT)
    DUT : entity work.debouncer
        generic map (
            g_timeout_cycles => C_TIMEOUT
        )
        port map (
            clk     => clk,
            rst   => rst_n,
            btn_in  => btn_in,
            btn_out => btn_out
        );

    -- Generacion de reloj
    clk <= not clk after C_CLK_PERIOD / 2;

    -- Proceso de estimulos y comprobaciones
    process
    begin
        -- INICIALIZACION: reset activo durante 3 ciclos
        rst_n  <= '0';
        btn_in <= '0';
        wait for C_CLK_PERIOD * 3;
        rst_n <= '1';
        wait for C_CLK_PERIOD * 2;

        -- CASO 1: Pulsacion limpia (sin rebotes)
        -- Se activa btn_in y se mantiene estable mas de C_TIMEOUT ciclos.
        -- Resultado esperado: btn_out se activa ('1') exactamente una vez.
        report "CASO 1: Pulsacion limpia iniciada" severity note;
        btn_in <= '1';
        wait for C_CLK_PERIOD * (C_TIMEOUT + 2);  -- Esperar mas del timeout

         -- Comprobacion: btn_out debe estar a '1' tras estabilidad suficiente
        assert (btn_out = '1')
            report "CASO 1 FALLO: btn_out deberia ser '1' tras pulsacion limpia"
            severity error;



        btn_in <= '0';
        wait for C_CLK_PERIOD * (C_TIMEOUT + 2);

                -- Comprobacion: btn_out debe volver a '0' tras soltar el boton
        assert (btn_out = '0')
            report "CASO 1 FALLO: btn_out deberia ser '0' tras soltar el boton"
            severity error;


        -- CASO 2: Rafaga de rebotes cortos (NO debe activar la salida)
        -- Se simulan rebotes: pulsos de duracion menor a C_TIMEOUT ciclos.
        -- Resultado esperado: btn_out permanece a '0' en todo momento.
        report "CASO 2: Rafaga de rebotes iniciada" severity note;

        -- TODO: Genere una secuencia de al menos 4 pulsos alternos de btn_in
        --       con duracion de 2-3 ciclos cada uno (inferior a C_TIMEOUT).
        --       Ejemplo de un pulso corto:
        --         btn_in <= '1'; wait for C_CLK_PERIOD * 3;
        --         btn_in <= '0'; wait for C_CLK_PERIOD * 3;

         -- 4 pulsos alternos, cada uno de 3 ciclos (< C_TIMEOUT = 8)
        btn_in <= '1'; wait for C_CLK_PERIOD * 3;
        btn_in <= '0'; wait for C_CLK_PERIOD * 3;

        btn_in <= '1'; wait for C_CLK_PERIOD * 3;
        btn_in <= '0'; wait for C_CLK_PERIOD * 3;

        btn_in <= '1'; wait for C_CLK_PERIOD * 2;
        btn_in <= '0'; wait for C_CLK_PERIOD * 3;

        btn_in <= '1'; wait for C_CLK_PERIOD * 3;
        btn_in <= '0'; wait for C_CLK_PERIOD * 3;

        -- TODO: Tras la rafaga, compruebe con assert que btn_out sigue siendo '0'

                assert (btn_out = '0')
            report "CASO 2 FALLO: btn_out deberia ser '0' tras rafaga de rebotes"
            severity error;

        -- CASO 3: Timeout del generico
        -- Verificar que la salida NO se activa si la senal no aguanta exactamente
        -- C_TIMEOUT ciclos, sino C_TIMEOUT - 1 (un ciclo menos del necesario).
        -- Resultado esperado: btn_out = '0'
        report "CASO 3: Pulsacion insuficiente (timeout - 1 ciclos)" severity note;

 -- Comprobacion: btn_out debe ser '0' porque no se alcanzo el timeout
        assert (btn_out = '0')
            report "CASO 3 FALLO: btn_out deberia ser '0' con pulsacion de (TIMEOUT-1) ciclos"
            severity error;

        -- FINAL: Indicar resultado global de la simulacion
        report "Simulation PASSED: tb_debouncer completado sin errores" severity note;
        wait; -- Detiene el proceso indefinidamente
    end process;

end architecture sim;