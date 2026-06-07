----------------------------------------------------------------------------------
-- Company: Universidad de Nebrija
-- Engineer: Carlos Mestre
--
-- Create Date: 15.02.2026 22:31:14
-- Module Name: driver_display - Behavioral
-- Project Name: Contador en FPGA
-- Target Devices: Diligent Nexys A7 T100
-- Revision 1.00
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity driver_display is
    Port (
        clk       : in  STD_LOGIC;
        rst       : in  STD_LOGIC;
        data_units: in  STD_LOGIC_VECTOR (3 downto 0);
        data_tens : in  STD_LOGIC_VECTOR (3 downto 0);

        -- Salidas a la FPGA
        anode_out : out STD_LOGIC_VECTOR (7 downto 0); -- 8 Ánodos
        seg_out   : out STD_LOGIC_VECTOR (6 downto 0)  -- 7 Segmentos
    );
end driver_display;

architecture Behavioral of driver_display is

    component hex2sevenseg is
        Port ( hex_in : in STD_LOGIC_VECTOR (3 downto 0); seg_out : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    -- Refresco: 100 MHz / 200.000 = 500 Hz (2 ms por dígito aprox)
    constant c_refresh_limit : integer := 200000;
    signal s_refresh_counter : integer range 0 to c_refresh_limit := 0;

    -- Selección de dígito (0 = Unidades, 1 = Decenas)
    signal s_digit_select : std_logic := '0';

    signal s_hex_to_decode : STD_LOGIC_VECTOR (3 downto 0);

begin

    -- 1. Generador de Tiempos de Refresco
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                s_refresh_counter <= 0;
                s_digit_select <= '0';
            else
                if s_refresh_counter = c_refresh_limit then
                    s_refresh_counter <= 0;
                    s_digit_select <= not s_digit_select; -- Cambiamos de dígito
                else
                    s_refresh_counter <= s_refresh_counter + 1;
                end if;
            end if;
        end if;
    end process;

    -- 2. Multiplexor de Datos (¿Qué número toca pintar?)
    s_hex_to_decode <= data_units when s_digit_select = '0' else data_tens;

    -- 3. Decodificador (Instancia)
    inst_decoder: hex2sevenseg
    port map (
        hex_in  => s_hex_to_decode,
        seg_out => seg_out
    );

    -- 4. Control de Ánodos (Activos a nivel BAJO '0')
    -- AN0 son las unidades (Derecha), AN1 son las decenas.
    process(s_digit_select)
    begin
        anode_out <= (others => '1'); -- Apagamos todos por defecto

        if s_digit_select = '0' then
            anode_out(0) <= '0'; -- Encender Unidades (AN0)
        else
            anode_out(1) <= '0'; -- Encender Decenas (AN1)
        end if;
    end process;

end Behavioral;
