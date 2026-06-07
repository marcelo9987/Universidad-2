library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debouncer is
    Generic (
        g_timeout_cycles : integer := 1000000
        -- Número de ciclos de reloj que el botón debe permanecer estable
        -- para considerarse una pulsación válida
    );
    Port (
        clk       : in  STD_LOGIC;  -- Señal de reloj
        rst       : in  STD_LOGIC;  -- Señal de reset síncrono
        btn_in    : in  STD_LOGIC;  -- Entrada del botón (sin filtrar)
        btn_out   : out STD_LOGIC   -- Salida del botón filtrado
    );
end debouncer;

architecture Behavioral of debouncer is

    -- Definición de los estados de la máquina de estados
    type t_state is (IDLE, BTN_COUNT, VALID);

   -- Señal que guarda el estado actual
    signal state : t_state;     

    -- Contador que mide cuánto tiempo el botón permanece pulsado
    signal timer : integer range 0 to g_timeout_cycles;

begin

    -- Proceso síncrono controlado por el flanco de subida del reloj
    process(clk)
    begin
        if rising_edge(clk) then
            
            if rst = '1' then
                state   <= IDLE;  -- Volvemos al estado inicial
                timer   <= 0;     -- Reiniciamos el contador
                btn_out <= '0';   -- Salida en bajo
                
            else
                -- Máquina de estados
                case state is

                    ------------------------------------------------------------------
                    -- ESTADO IDLE
                    -- Espera a que el botón sea pulsado
                    ------------------------------------------------------------------
                    when IDLE =>
                        btn_out <= '0';  -- Salida siempre en 0 en reposo
                        
                        -- Si detectamos que el botón se pulsa
                        if btn_in = '1' then
                            state <= BTN_COUNT;  -- Pasamos a contar
                            timer <= 0;          -- Reiniciamos contador
                        end if;

                    ------------------------------------------------------------------
                    -- ESTADO BTN_COUNT
                    -- Se empieza a contar cuánto tiempo el botón permanece pulsado
                    ------------------------------------------------------------------
                    when BTN_COUNT =>
                        
                        -- Si el contador llega al valor configurado
                        if timer = g_timeout_cycles then
                            state <= VALID;  -- Pulsación válida
                        
                        -- Si el botón se suelta antes de tiempo → ruido
                        elsif btn_in = '0' then
                            state <= IDLE;  -- Volvemos a reposo
                            timer <= 0;     -- Reiniciamos contador
                        
                        -- Si sigue pulsado, incrementamos contador
                        elsif btn_in = '1' then
                            timer <= timer + 1;

                        end if;

                    ------------------------------------------------------------------
                    -- ESTADO VALID
                    -- Pulsación confirmada (estable durante el tiempo requerido)
                    ------------------------------------------------------------------
                    when VALID =>
                        btn_out <= '1';  -- Activamos salida
                        
                        -- Permanecemos aquí hasta que el botón se suelte
                        if btn_in = '0' then
                            state <= IDLE;  -- Volvemos a reposo
                            timer <= 0;     -- Reiniciamos contador
                        end if;

                    ------------------------------------------------------------------
                    -- Estado de seguridad
                    ------------------------------------------------------------------
                    when others =>
                        state <= IDLE;

                end case;
            end if;
        end if;
    end process;

end Behavioral;
