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
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Este fragmento de código es CÓDIGO LIBRE según su licencia.
--      Se distribuye para que sea útil a quien le sea útil.
--      No se dán garantías. Puedes redistribuirlo y/o modificarlo libremente.
--      No está permitido patentarlo o cerrarlo en sistemas de caja negra.
-- Licencia CERN-OHL-S v2. Si este código no lo recibiste con una copia, consulta: <https://ohwr.org/project/cernohl/wikis/Documents/CERN-OHL-version-2>.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_media is
end tb_media;


architecture simulation of tb_media is
	component sma_filter is
		port 
		(
			clk  : in STD_LOGIC;
			rst  : in STD_LOGIC;
			din  : in STD_LOGIC_VECTOR (7 downto 0);
			load : in STD_LOGIC;
			dout : out STD_LOGIC_VECTOR (7 downto 0)
		);
	end component sma_filter;

	constant C_CLK_PERIOD : time := 10 ns;
	signal s_clk          : std_logic := '0';
	signal s_rst          : std_logic := '0';
	signal s_din          : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	signal s_dout         : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	signal s_load         : std_logic := '0';

begin
	DUT : sma_filter
	port map
	(
		clk  => s_clk, 
		rst  => s_rst, 
		din  => s_din, 
		load => s_load, 
		dout => s_dout
	);

	s_clk <= not s_clk after C_CLK_PERIOD/2;

	process
	begin
		

		s_rst  <= '1';
		
		wait for C_CLK_PERIOD;
		
		s_rst  <= '0';
		
		wait for C_CLK_PERIOD;
		
		s_load <= '1';
		
		
		report " --- INICIO DEL TESTBENCH ---" severity note;


		-- TRIANGULAR

		s_din <= "00000000";
		wait for 4 * C_CLK_PERIOD;

		s_din <= "00000001";
		wait for C_CLK_PERIOD;

		s_din <= "00000010";
		wait for C_CLK_PERIOD;

		s_din <= "00000100";
		wait for C_CLK_PERIOD;

		s_din <= "00001000";
		wait for C_CLK_PERIOD;

		s_din <= "00010000";
		wait for C_CLK_PERIOD;

		s_din <= "00100000";
		wait for C_CLK_PERIOD;

		s_din <= "00010000";
		wait for C_CLK_PERIOD;

		s_din <= "00001000";
		wait for C_CLK_PERIOD;

		s_din <= "00000100";
		wait for C_CLK_PERIOD;

		s_din <= "00000010";
		wait for C_CLK_PERIOD;

		s_din <= "00000001";
		wait for C_CLK_PERIOD;

		s_din <= "00000000";
		wait for C_CLK_PERIOD;


		-- CUADRADA

		s_din <= "00000000";
		wait for C_CLK_PERIOD;

		s_din <= "00000000";
		wait for C_CLK_PERIOD;

		s_din <= "00000000";
		wait for C_CLK_PERIOD;

		s_din <= "00000000";
		wait for C_CLK_PERIOD;

		s_din <= "11111111";
		wait for C_CLK_PERIOD;

		s_din <= "11111111";
		wait for C_CLK_PERIOD;

		s_din <= "11111111";
		wait for C_CLK_PERIOD;

		s_din <= "11111111";
		wait for C_CLK_PERIOD;

		assert (s_dout = "11111111")
		  report "La media móvil de 255 255 255 y 255 es 255 y el programa tiene algo que decir al respecto"
		  severity failure;

        s_din <= "00000000";
        wait for C_CLK_PERIOD;

        s_din <= "00000000";
        wait for C_CLK_PERIOD;

        s_din <= "00000000";
        wait for C_CLK_PERIOD;

        s_din <= "00000000";
        wait for C_CLK_PERIOD;


        -- DIENTE DE SIERRA

        s_din <= "00000000";
        wait for C_CLK_PERIOD;

        s_din <= "00000001";
        wait for C_CLK_PERIOD;

        s_din <= "00000010";
        wait for C_CLK_PERIOD;

        s_din <= "00000100";
        wait for C_CLK_PERIOD;

        s_din <= "00001000";
        wait for C_CLK_PERIOD;

        s_din <= "00010000";
        wait for C_CLK_PERIOD;

        s_din <= "00100000";
        wait for C_CLK_PERIOD;

        s_din <= "00000000";
        wait for C_CLK_PERIOD;

        s_din <= "00000001";
        wait for C_CLK_PERIOD;

        s_din <= "00000010";
        wait for C_CLK_PERIOD;

        s_din <= "00000100";
        wait for C_CLK_PERIOD;

        s_din <= "00001000";
        wait for C_CLK_PERIOD;

        s_din <= "00010000";
        wait for C_CLK_PERIOD;

        s_din <= "00100000";
        wait for C_CLK_PERIOD;

        s_rst <= '1'; -- Activamos reset
        wait for C_CLK_PERIOD / 2;

        -- COMPROBAMOS:
        assert (s_dout = "00000000")
            report "ERROR: La salida no es 0 despues del RESET"
            severity failure;
        
        report "Exito: El reset hace lo que promete" 
            severity note;
        

        wait for C_CLK_PERIOD / 2;
        s_rst  <= '0'; -- Desactivamos
        s_din  <= "10000000"; -- Valor 128

        s_load <= '1';
        wait for 4 * C_CLK_PERIOD; -- Llenamos el barril

        assert (s_dout = "10000000")
            report "Error ak buscar la convergencia en torno a 10000000"
            severity failure;
        
        report "Si se llenan los cuatro registros, la media da el valor esperado y adecuado"
            severity note;
        
        
        s_load <= '0'; -- CONGELAMOS
        s_din  <= "11111111"; -- Cambiamos entrada a 255
        
        wait for 2 * C_CLK_PERIOD; -- Se le dá tiempo al sistema a "respirar"
        assert (s_dout = "10000000")
            report "ERROR: El filtro capturo datos con load a valor bajo (0)"
            severity failure;
        s_load <= '1'; -- LIBERAMOS

        report "Load funciona" severity note;

        report "Todo funciona" severity note;
        wait;
	end process;
end architecture simulation;
