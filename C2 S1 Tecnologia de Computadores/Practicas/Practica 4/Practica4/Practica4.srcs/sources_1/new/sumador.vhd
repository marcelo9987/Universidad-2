library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity sumador is
    Port ( A: in STD_LOGIC_VECTOR (3 downto 0);
           B: in STD_LOGIC_VECTOR (3 downto 0);
           S: in STD_LOGIC_VECTOR (1 downto 0);
           C: out STD_LOGIC;
           RESULT: out STD_LOGIC_VECTOR (3 downto 0)
         );
end entity sumador;

architecture Behavioral of sumador is

    signal NOB: std_logic_vector(3 downto 0);

    signal multiplexB: std_logic_vector(3 downto 0);

    signal Sum: std_logic_vector(3 downto 0);

    signal AandB,AorB: std_logic_vector(3 downto 0);

    signal temp: unsigned(4 downto 0);

    signal multiplexorFinal: std_logic_vector(3 downto 0);
    

begin
    -- NOB <= not B;
   -- multiplexB <= NOB when S(0) = '1' else B;
   -- Sum <= A + multiplexB;
   
   
    temp <= ('0' & unsigned(A)) + ('0' & unsigned(B)) when S(0)='0'
            else ('0' & unsigned(A)) - ('0' & unsigned(B));
    Sum <= std_logic_vector(temp(3 downto 0));
    C <= temp(4);

    AandB <= A and B;
    AorB <= A or B;
    

    multiplexorFinal <= Sum when S = "00" else
                        Sum when S = "01" else
                        AandB when S = "10" else
                        AorB;

    RESULT <= multiplexorFinal;

end Behavioral;





