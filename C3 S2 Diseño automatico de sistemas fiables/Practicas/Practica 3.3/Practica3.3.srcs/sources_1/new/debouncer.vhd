
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debouncer is
    Generic (
        g_timeout_cycles : integer := 1000000
    );
    Port (
        clk       : in  STD_LOGIC;
        rst       : in  STD_LOGIC;
        btn_in    : in  STD_LOGIC;
        btn_out   : out STD_LOGIC
    );
end debouncer;

architecture Behavioral of debouncer is
    -- Definimos los estados por ellos para evitar errores de sintaxis
    type t_state is (IDLE, BTN_COUNT, VALID);
    signal state : t_state;
    signal timer : integer range 0 to g_timeout_cycles;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state   <= IDLE;
                timer   <= 0;
                btn_out <= '0';
            else
                case state is
                    when IDLE =>
                        btn_out <= '0';
                        -- TODO: Si detectamos botón pulsado (1), ir a BTN_COUNT y resetear timer
                        -- ESCRIBE TU CODIGO AQUI
                        if btn_in ='1'then 
                            state<=BTN_COUNT;
                            timer<=0;                     
                        end if;

                    when BTN_COUNT =>
                        -- TODO: Si el botón se suelta ('0'), volver a IDLE (fue ruido).
                        -- Si sigue pulsado, incrementar timer.
                        -- Si timer llega al final (g_timeout_cycles), pasar a VALID.
                         -- ESCRIBE TU CODIGO AQUI
                         
                        if timer = g_timeout_cycles then
                             -- Ya ha estado pulsado el tiempo necesario
                             state <= VALID;
                             
                        elsif btn_in ='0' then 
                            state<=IDLE;
                            timer<=0;                     
                        
                        elsif btn_in ='1'then 
                            state<=BTN_COUNT;
                            timer<=timer+1;                
                        

                        
                            
                         else
                         -- Sigue pulsado, seguimos contando
                             timer <= timer + 1;
                        end if; 
                    when VALID =>
                        btn_out <= '1';
                        if btn_in = '0' then
                            -- TODO: Quedarse aquí hasta que el botón se suelte ('0') -> volver a IDLE
                            state <= IDLE;
                            timer <= 0;
                        end if;
                    when others =>
                        state <= IDLE;
                end case;
            end if;
        end if;
    end process;
end Behavioral;

