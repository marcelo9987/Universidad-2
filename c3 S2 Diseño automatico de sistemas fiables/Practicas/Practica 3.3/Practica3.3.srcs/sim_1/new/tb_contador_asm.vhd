library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_contador_asm is
end entity tb_contador_asm;

architecture sim of tb_contador_asm is

    -- Parametros de simulacion
    constant C_CLK_PERIOD : time := 10 ns;  -- Reloj de 100 MHz

    -- Senales de estimulo y observacion
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '0';
    signal cnt_en  : std_logic := '0';
    signal bcd_dec : std_logic_vector(3 downto 0);
    signal bcd_uni : std_logic_vector(3 downto 0);

begin

    -- Instanciacion del Device Under Test (DUT)
    DUT : entity work.contador_asm
        port map(
            clk     => clk,
            rst     => rst,
            cnt_en  => cnt_en,
            bcd_dec => bcd_dec,
            bcd_uni => bcd_uni
        );

    -- Generacion de reloj
    clk <= not clk after C_CLK_PERIOD / 2;

    -- ================================================================
    -- Proceso de estimulos y comprobaciones
    -- ================================================================
    process

        -- Procedimiento auxiliar: espera flanco de subida y un pequeño
        -- delta para que las senales de salida ya esten estabilizadas
        procedure wait_clk (n : integer := 1) is
        begin
            for i in 1 to n loop
                wait until rising_edge(clk);
            end loop;
            wait for 1 ns;  -- delta de estabilizacion post-flanco
        end procedure;

        -- Procedimiento de comprobacion BCD
        procedure check_bcd (
            expected_dec : integer;
            expected_uni : integer;
            test_name    : string
        ) is
        begin
            assert (to_integer(unsigned(bcd_dec)) = expected_dec)
                report test_name & " FALLO dec: esperado " &
                       integer'image(expected_dec) & " obtenido " &
                       integer'image(to_integer(unsigned(bcd_dec)))
                severity error;

            assert (to_integer(unsigned(bcd_uni)) = expected_uni)
                report test_name & " FALLO uni: esperado " &
                       integer'image(expected_uni) & " obtenido " &
                       integer'image(to_integer(unsigned(bcd_uni)))
                severity error;
        end procedure;

    begin

        -- ============================================================
        -- INICIALIZACION: Reset activo durante 3 ciclos
        -- ============================================================
        report "INICIO: Aplicando reset" severity note;
        rst    <= '1';
        cnt_en <= '0';
        wait_clk(3);
        rst <= '0';
        wait_clk(2);

        -- Tras reset, el contador debe estar en 00
        check_bcd(0, 0, "RESET");
        report "RESET OK: contador en 00" severity note;

        -- ============================================================
        -- CASO 1: cnt_en = '0', el contador NO debe avanzar
        -- ============================================================
        report "CASO 1: Verificando que cnt_en='0' congela el contador" severity note;
        cnt_en <= '0';
        wait_clk(5);
        check_bcd(0, 0, "CASO1 - cnt_en=0");
        report "CASO 1 OK: contador permanece en 00 con cnt_en='0'" severity note;

        -- ============================================================
        -- CASO 2: Cuenta de 00 hasta 09 (rollover de unidades)
        -- ============================================================
        report "CASO 2: Contando de 00 a 09" severity note;
        cnt_en <= '1';

        -- Verificar cada valor intermedio
        wait_clk(1); check_bcd(0, 1, "CASO2 - valor 01");
        wait_clk(1); check_bcd(0, 2, "CASO2 - valor 02");
        wait_clk(1); check_bcd(0, 3, "CASO2 - valor 03");
        wait_clk(1); check_bcd(0, 4, "CASO2 - valor 04");
        wait_clk(1); check_bcd(0, 5, "CASO2 - valor 05");
        wait_clk(1); check_bcd(0, 6, "CASO2 - valor 06");
        wait_clk(1); check_bcd(0, 7, "CASO2 - valor 07");
        wait_clk(1); check_bcd(0, 8, "CASO2 - valor 08");
        wait_clk(1); check_bcd(0, 9, "CASO2 - valor 09");
        report "CASO 2 OK: unidades llegaron a 9" severity note;

        -- ============================================================
        -- CASO 3: Rollover de unidades -> decenas incrementan (09->10)
        -- ============================================================
        report "CASO 3: Verificando rollover 09 -> 10" severity note;
        wait_clk(1);
        check_bcd(1, 0, "CASO3 - rollover a 10");
        report "CASO 3 OK: decenas incrementaron correctamente" severity note;

        -- ============================================================
        -- CASO 4: Pausa en medio de la cuenta (cnt_en='0')
        -- El contador debe congelarse en el valor actual
        -- ============================================================
        report "CASO 4: Pausa en cuenta (cnt_en='0' en medio)" severity note;
        cnt_en <= '0';
        wait_clk(4);
        check_bcd(1, 0, "CASO4 - congelado en 10");
        cnt_en <= '1';
        report "CASO 4 OK: contador congelado correctamente" severity note;

        -- ============================================================
        -- CASO 5: Avanzar hasta 19 y verificar segundo rollover (19->20)
        -- ============================================================
        report "CASO 5: Verificando rollover 19 -> 20" severity note;
        wait_clk(9);   -- De 10 avanzamos 9 pasos hasta 19
        check_bcd(1, 9, "CASO5 - valor 19");
        wait_clk(1);
        check_bcd(2, 0, "CASO5 - rollover a 20");
        report "CASO 5 OK: segundo rollover de decenas correcto" severity note;

        -- ============================================================
        -- CASO 6: Reset asincrono en medio de la cuenta
        -- ============================================================
        report "CASO 6: Reset asincrono durante la cuenta" severity note;
        wait_clk(5);   -- Avanzamos hasta 25
        check_bcd(2, 5, "CASO6 - antes de reset en 25");
        rst <= '1';
        wait for 3 ns; -- Reset asincrono: no esperamos flanco de reloj
        check_bcd(0, 0, "CASO6 - reset asincrono activo");
        rst <= '0';
        wait_clk(1);
        check_bcd(0, 0, "CASO6 - contador en 00 tras reset");
        report "CASO 6 OK: reset asincrono funciona correctamente" severity note;

        -- ============================================================
        -- CASO 7: Rollover global 99 -> 00
        -- ============================================================
        report "CASO 7: Avanzando hasta 99 para verificar rollover global" severity note;
        cnt_en <= '1';
        wait_clk(99);  -- Desde 00, tras 99 pulsos estamos en 99
        check_bcd(9, 9, "CASO7 - valor 99");
        wait_clk(1);
        check_bcd(0, 0, "CASO7 - rollover 99 -> 00");
        report "CASO 7 OK: rollover global 99->00 correcto" severity note;

        -- ============================================================
        -- FINAL
        -- ============================================================
        cnt_en <= '0';
        report "Simulation PASSED: tb_contador_asm completado sin errores" severity note;
        wait;

    end process;

end architecture sim;