library ieee;
use ieee.std_logic_1164.all;

entity tb_ej_6 is
end entity;

architecture beh of tb_ej_6 is

    signal tb_clk, tb_rst_n : std_logic; 

begin
    -- instanciar un componente --> port map(...)
    p_tb_clk: process
        -- c_clk_period = 1/Fclk = 1/20Mhz
        constant c_clk_period : time := 50 ns;
    begin
        tb_clk<=('0');
        wait for c_clk_period/2; 

        tb_clk<=('1');
        wait for c_clk_period/2; 
    end process p_tb_clk;

    p_tb_rst_n: process; -- todo: aqui seria sin _n
    begin
        tb_rst_n<=('0');
        wait for 20 ns;
        
        tb_rst_n<=('1');
        wait;
    end process p_tb_rst_n;
end beh;

