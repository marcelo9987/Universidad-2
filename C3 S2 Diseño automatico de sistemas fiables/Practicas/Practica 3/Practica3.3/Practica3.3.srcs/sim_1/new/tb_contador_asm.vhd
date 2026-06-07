library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_contador_asm is
end entity tb_contador_asm;

architecture sim of tb_contador_asm is

    -- Parametros de simulacion
    constant C_CLK_PERIOD  : time    := 10 ns;   -- Reloj de 100 MHz

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

    -- Proceso de estimulos y comprobaciones
    process
    begin
    
    
    
        
        wait;
    end process;

end architecture sim;