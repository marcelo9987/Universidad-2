library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_99 is
    Port (
        clk      : in  STD_LOGIC;   -- Señal de reloj
        rst      : in  STD_LOGIC;   -- Reset síncrono
        cnt_en   : in  STD_LOGIC;   -- Enable del contador
        cnt_units : out STD_LOGIC_VECTOR (3 downto 0); -- Salida BCD unidades
        cnt_tens  : out STD_LOGIC_VECTOR (3 downto 0)  -- Salida BCD decenas
    );
end contador_99;

architecture Behavioral of contador_99 is

    -- Registro para las unidades (BCD 0–9)
    signal s_units : unsigned(3 downto 0) := (others => '0');
    
    -- Registro para las decenas (BCD 0–9)
    signal s_tens  : unsigned(3 downto 0) := (others => '0');

begin

    -- Proceso síncrono activado por flanco de subida
    process(clk)
    begin
        if rising_edge(clk) then
            
            -- Reset síncrono: pone el contador en 00
            if rst = '1' then
                s_units <= (others => '0');
                s_tens  <= (others => '0');

            -- Solo cuenta si está habilitado
            elsif cnt_en = '1' then

                ----------------------------------------------------------------
                -- LÓGICA DEL CONTADOR BCD 00 → 99
                ----------------------------------------------------------------

                -- Caso 1: Si estamos en 99 → volver a 00
                if s_units = 9 and s_tens = 9 then
                    s_units <= (others => '0');
                    s_tens  <= (others => '0');

                -- Caso 2: Si unidades llega a 9 → reiniciar unidades e incrementar decenas
                elsif s_units = 9 then
                    s_units <= (others => '0');
                    s_tens  <= s_tens + 1;

                -- Caso 3: Incremento normal de unidades
                else 
                    s_units <= s_units + 1;
                end if;

            end if;
        end if;
    end process;

    -- Conversión de unsigned a std_logic_vector para las salidas
    cnt_units <= std_logic_vector(s_units);
    cnt_tens  <= std_logic_vector(s_tens);

end Behavioral;
