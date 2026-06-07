library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_contador_asm is
end entity tb_contador_asm;

architecture sim of tb_contador_asm is

    constant C_CLK_PERIOD : time := 15 ns;
    --ASM necesita varios cycles per transtition
    --Numero can be whatever needed
    constant C_SETTLE     : integer := 15;

    signal clk     : std_logic := '0';
    signal rst     : std_logic := '0';
    signal cnt_en  : std_logic := '0';
    signal bcd_dec : std_logic_vector(3 downto 0);
    signal bcd_uni : std_logic_vector(3 downto 0);

    function is_prime(n : integer) return boolean is
    begin
        if n < 2 then return false; end if;
        if n = 2 then return true; end if;
        if n mod 2 = 0 then return false; end if;
        if n < 9 then return true; end if;
        if n mod 3 = 0 then return false; end if;
        if n mod 5 = 0 then return false; end if;
        if n mod 7 = 0 then return false; end if;
        return true;
    end function;

begin

    DUT : entity work.contador_asm
        port map(
            clk     => clk,
            rst     => rst,
            cnt_en  => cnt_en,
            bcd_dec => bcd_dec,
            bcd_uni => bcd_uni
        );

    clk <= not clk after C_CLK_PERIOD / 2;

    process
        variable v_valor : integer;

        -- Funcion para dejar al asm procesar cada paso y no saltar de pasos durante una calculacion
        procedure pulse_and_wait is
        begin
            cnt_en <= '1'; wait for C_CLK_PERIOD;
            cnt_en <= '0'; wait for C_CLK_PERIOD * C_SETTLE;
        end procedure;

    begin
    
    
        rst    <= '1';
        cnt_en <= '0';
        wait for C_CLK_PERIOD * 3;
        rst <= '0';
        wait for C_CLK_PERIOD * 2;

        -- Check counter at 0
        v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                   to_integer(unsigned(bcd_uni));
        assert (v_valor = 0)
            report "ERROR RESET: el contador no arranca en 00, vale " &
                   integer'image(v_valor)
            severity error;

        -- CASO A: 00 -> 1 pulso -> esperado 01

        report "CASO A: 00 -> 1 pulso -> esperado 01" severity note;
        pulse_and_wait;
        v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                   to_integer(unsigned(bcd_uni));
        assert (v_valor = 1)
            report "ERROR CASO A: esperado 01, obtenido " & integer'image(v_valor)
            severity error;
        assert (not is_prime(v_valor))
            report "ERROR CASO A: el valor " & integer'image(v_valor) & " es primo"
            severity error;

   
        -- CASO B: 01 -> 1 pulso -> esperado 04 (salta 02 y 03, primos)

        report "CASO B: 01 -> 1 pulso -> esperado 04" severity note;
        pulse_and_wait;
        v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                   to_integer(unsigned(bcd_uni));
        assert (v_valor = 4)
            report "ERROR CASO B: esperado 04, obtenido " & integer'image(v_valor)
            severity error;
        assert (not is_prime(v_valor))
            report "ERROR CASO B: el valor " & integer'image(v_valor) & " es primo"
            severity error;


        -- CASO C: 04 -> 1 pulso -> esperado 06 (salta 05, primo)

        report "CASO C: 04 -> 1 pulso -> esperado 06" severity note;
        pulse_and_wait;
        v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                   to_integer(unsigned(bcd_uni));
        assert (v_valor = 6)
            report "ERROR CASO C: esperado 06, obtenido " & integer'image(v_valor)
            severity error;
        assert (not is_prime(v_valor))
            report "ERROR CASO C: el valor " & integer'image(v_valor) & " es primo"
            severity error;


        -- CASO D: 06 -> 1 pulso -> esperado 08 (salta 07, primo)

        report "CASO D: 06 -> 1 pulso -> esperado 08" severity note;
        pulse_and_wait;
        v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                   to_integer(unsigned(bcd_uni));
        assert (v_valor = 8)
            report "ERROR CASO D: esperado 08, obtenido " & integer'image(v_valor)
            severity error;
        assert (not is_prime(v_valor))
            report "ERROR CASO D: el valor " & integer'image(v_valor) & " es primo"
            severity error;


        -- CASO E: 08 -> 1 pulso -> esperado 09

        report "CASO E: 08 -> 1 pulso -> esperado 09" severity note;
        pulse_and_wait;
        v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                   to_integer(unsigned(bcd_uni));
        assert (v_valor = 9)
            report "ERROR CASO E: esperado 09, obtenido " & integer'image(v_valor)
            severity error;
        assert (not is_prime(v_valor))
            report "ERROR CASO E: el valor " & integer'image(v_valor) & " es primo"
            severity error;


        -- CASO F: 09 -> 1 pulso -> esperado 10

        report "CASO F: 09 -> 1 pulso -> esperado 10" severity note;
        pulse_and_wait;
        v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                   to_integer(unsigned(bcd_uni));
        assert (v_valor = 10)
            report "ERROR CASO F: esperado 10, obtenido " & integer'image(v_valor)
            severity error;
        assert (not is_prime(v_valor))
            report "ERROR CASO F: el valor " & integer'image(v_valor) & " es primo"
            severity error;

        
        -- Para llegar al caso G necesitamos el contador en 96.
        -- En vez de escribir pulse_and_wait 80 veces a mano,
        -- reseteamos a 00 y dejamos que el bucle pulse solo hasta llegar a 96.
        
        report "Avanzando hasta 96 para casos G y H..." severity note;
        rst <= '1'; wait for C_CLK_PERIOD * 3;
        rst <= '0'; wait for C_CLK_PERIOD * 2;

        -- From 00, drive until counter shows 96
        -- We loop with a limit stop when value reaches 96
        for i in 0 to 200 loop
            v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                       to_integer(unsigned(bcd_uni));
            exit when v_valor = 96;
            pulse_and_wait;
        end loop;

        v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                   to_integer(unsigned(bcd_uni));
        assert (v_valor = 96)
            report "ERROR setup G: no se alcanzo 96, valor actual " &
                   integer'image(v_valor)
            severity error;


        -- CASO G: 96 -> 1 pulso -> esperado 98 (salta 97, primo)

        report "CASO G: 96 -> 1 pulso -> esperado 98" severity note;
        pulse_and_wait;
        v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                   to_integer(unsigned(bcd_uni));
        assert (v_valor = 98)
            report "ERROR CASO G: esperado 98, obtenido " & integer'image(v_valor)
            severity error;
        assert (not is_prime(v_valor))
            report "ERROR CASO G: el valor " & integer'image(v_valor) & " es primo"
            severity error;

        -- CASO H: 98 -> 2 pulsos -> esperado 00 (reinicio del contador)
        -- 98 -> 99 -> 00

        report "CASO H: 98 -> 2 pulsos -> esperado 00 (wraparound)" severity note;
        pulse_and_wait;
        pulse_and_wait;
        v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                   to_integer(unsigned(bcd_uni));
        assert (v_valor = 0)
            report "ERROR CASO H: esperado 00 tras wraparound, obtenido " &
                   integer'image(v_valor)
            severity error;


        -- BUCLE GENERAL: verificar no-primo para toda una vuelta completa

        report "BUCLE GENERAL: verificando ciclo completo 00->99" severity note;
        rst <= '1'; wait for C_CLK_PERIOD * 3;
        rst <= '0'; wait for C_CLK_PERIOD * 2;

        for i in 0 to 109 loop
            pulse_and_wait;
            v_valor := to_integer(unsigned(bcd_dec)) * 10 +
                       to_integer(unsigned(bcd_uni));
            assert (not is_prime(v_valor))
                report "ERROR BUCLE: numero primo detectado en posicion " &
                       integer'image(i) & ": " & integer'image(v_valor)
                severity error;
        end loop;

        report "Simulation PASSED: tb_contador_asm completado sin errores" severity note;
        wait;
    end process;

end architecture sim;