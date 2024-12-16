library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tstbnch_sumador is
end tstbnch_sumador;

architecture beh of tstbnch_sumador is

        component sumador
            Port ( A: in STD_LOGIC_VECTOR (3 downto 0);
                B: in STD_LOGIC_VECTOR (3 downto 0);
                S: in STD_LOGIC_VECTOR (1 downto 0);
                C: out STD_LOGIC;
                RESULT: out STD_LOGIC_VECTOR (3 downto 0)
                );
        end component sumador;

        signal A: std_logic_vector(3 downto 0);
        signal B: std_logic_vector(3 downto 0);
        signal S: std_logic_vector(1 downto 0);
        signal C: std_logic;
        signal RESULT: std_logic_vector(3 downto 0);
        
        begin
    
    SUMADOR1: sumador port map(A,B,S,C,RESULT);

    process begin
        --swait for 2 ns;
        A <= "0111"; -- 7
        B <= "1010"; -- 10
        S <= "00"; -- Suma
        wait for 10 ns;
        S <= "01"; -- Resta
        A<= "1110"; -- 14
        B<= "1001"; -- 9
        wait for 10 ns;
        S <= "10"; -- And
        A<= "1111"; -- 15
        B<= "0010"; -- 2
        wait for 10 ns;
        S <= "11"; -- Or
        A<= "0011"; -- 3
        B<= "1011"; -- 11
        wait;
    end process;
end beh;