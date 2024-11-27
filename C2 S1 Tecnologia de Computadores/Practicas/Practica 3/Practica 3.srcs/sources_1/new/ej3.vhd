library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_memoria is
    end entity tb_memoria;

    architecture beh of tb_memoria
is
    component MEMORY is  port 
    ( 
        CLR, CLK : in STD_LOGIC;
        EMPTY    : out STD_LOGIC;   
        Q        : out STD_LOGIC_VECTOR(7 downto 0)
    ); 
    end component MEMORY;
    signal se_clk , se_clr  : std_logic;
    signal ss_empty         : std_logic; 
    constant clk_p : time := 50 ns;
begin




    memoria_a_probar : MEMORY port map
                                    (
                                      CLR   => se_clr
                                    , CLK   => se_clk
                                    , EMPTY => ss_empty
                                    );                                
       
process begin
    
    se_clk <= '0';
    
    wait for 50 ns;
    
    se_clk <= '1';

    wait for 50 ns;
end process;

process begin
    se_clr <= '1';
    wait for clk_p * 2;
    se_clr <= '0';
    wait for clk_p * 2;
    se_clr <= '1';
    wait;
end process;

end beh;


