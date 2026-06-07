----------------------------------------------------------------------------------
-- Company: Universidad Antonio de Nebrija
-- Engineer: Victor Arroyo Márquez
-- Engineer: Jose Fernando Marcilla Morán
-- Engineer: Marcelo Fort Muñoz


-- 
-- Create Date: 04/24/2026 12:25:36 PM
-- Design Name: 
-- Module Name: sma_filter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Additional Comments:
-- Este fragmento de código es CÓDIGO LIBRE según su licencia.
--     Se distribuye para que sea útil a quien le sea útil.
--     No se dán garantías. Puedes redistribuirlo y/o modificarlo libremente.
--     No está permitido patentarlo o cerrarlo en sistemas de caja negra.
-- Licencia CERN-OHL-S v2. Si este código no lo recibiste con una copia, consulta: <https://ohwr.org/project/cernohl/wikis/Documents/CERN-OHL-version-2>.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity sma_filter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (7 downto 0);
           load : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end sma_filter;


architecture Behavioral of sma_filter is
    signal s_in0            : STD_LOGIC_VECTOR (7 downto 0);
    signal s_in1            : STD_LOGIC_VECTOR (7 downto 0);
    signal s_in2            : STD_LOGIC_VECTOR (7 downto 0);
    signal s_in3            : STD_LOGIC_VECTOR (7 downto 0);
    signal s_suma           : unsigned(9 downto 0);
begin


process(clk, rst)
begin

    if rst='1'
        then 
            s_in0 <= (others => '0');
            s_in1 <= (others => '0');
            s_in2 <= (others => '0');
            s_in3 <= (others => '0');
    elsif rising_edge(clk)
    then
        if load='1'
        then 
            s_in0 <= din;
            s_in1 <= s_in0;
            s_in2 <= s_in1;
            s_in3 <= s_in2;
        end if;
    end if;
end process;

s_suma <= resize(unsigned(s_in0), 10) + resize(unsigned(s_in1),10) +  resize(unsigned(s_in2),10) + resize(unsigned(s_in3),10);

dout <= std_logic_vector(s_suma(9 downto 2));

end Behavioral;
