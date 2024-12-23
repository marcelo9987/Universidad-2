----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2024 10:03:41
-- Design Name: 
-- Module Name: tstbench - Behavioral
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
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tstbench is
--  Port ( );
    end tstbench;

architecture Behavioral of tstbench is
    component automata is
        Port(
                clk : in STD_LOGIC;
                rst : in STD_LOGIC;
        A,B : in STD_LOGIC;
        y : out STD_LOGIC
    );
    end component automata;
    constant clk_period : time := 10 ns;
    signal clk : std_logic;
    signal rst : std_logic;
    signal A : std_logic;
    signal B : std_logic;
    signal y : std_logic;

begin

    process
    begin
        clk <= '1';
        wait for clk_period/2;  
        clk <= '0';
        wait for clk_period/2;  
    end process;

    automata1 : automata
    port map
    (
        clk=>clk
        ,rst=>rst
        ,A=>A 
        ,B=>B 
        ,y=>y
    );

    process 
    begin
        wait for 1 ns;
        rst <= '1';
        wait for clk_period; -- S0 01
        rst <= '0';
        A<='0';
        B<='1';
        wait for clk_period; -- S0 11 
        A<='1';
        B<='1';
        wait for clk_period; -- S0 00
        A<='0';
        B<='0';
        wait for clk_period; -- RST
        wait for clk_period; -- RST
        rst<='1';
        wait for clk_period; -- S0 10
        rst<='0';
        A<='1';
        B<='0';
        
        
        wait for clk_period; -- S1 00
        A<='0';
        B<='0';
        wait for clk_period; -- S1 01
        A<='0';
        B<='1';
        wait for clk_period; -- S1 11
        A<='1';
        B<='1';
        wait for clk_period; -- S1 10
        A<='1';
        B<='0';
        
        wait for clk_period; -- S2 00
        A<='0';
        B<='0';
        wait for clk_period; -- S1 10 ***
        A<='1';
        B<='0';
        wait for clk_period; -- S2 10
        A<='1';
        B<='0';
        wait for clk_period; -- S2 01
        A<='0';
        B<='1';
        
        wait for clk_period; -- S3 01
        A<='0';
        B<='1';
        wait for clk_period; -- S3 11
        A<='1';
        B<='1';
        wait for clk_period; -- S3 00
        A<='0';
        B<='0';
        wait for clk_period; -- S4 01
        A<='0';
        B<='1';
        wait for clk_period; -- S3 10
        A<='1';
        B<='0';
        
        wait for clk_period; -- S4 10
        A<='1';
        B<='0';
        wait for clk_period; -- S1 11
        A<='1';
        B<='1';
        wait for clk_period; -- S2 11
        A<='1';
        B<='1';
        wait for clk_period; -- S3 10
        A<='1';
        B<='1';
        
        wait for clk_period; -- S4 11
        A<='0';
        B<='1';
        wait for clk_period; -- S3 10
        A<='0';
        B<='1';
        wait for clk_period; -- S4 00
        A<='0';
        B<='0';
        wait;
        
        
        
        
        
        
        
        
        

        wait; 
        
    end process;



end Behavioral;
