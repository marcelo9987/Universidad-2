-- Escriba el código VHDL de un flip-flop JK. Este tipo de flip-flops tiene 3
-- entradas (J, K y CLK) y una salida (Q). En el flanco de reloj de subida, Q
-- mantiene el valor anterior si J = K = 0. Si J = 1, entonces Q = 1 y si K = 1
-- entonces Q = 0. Si ambas señales J = K = 1, entonces el valor de Q es invertido.


library ieee;
use ieee.STD_LOGIC_1164;
--  
--
--
--
entity ff_jk is
    port(
            J   : in STD_LOGIC;
            K   : in STD_LOGIC;
            clk : in STD_LOGIC;
            Q   : out STD_LOGIC;
);
end;

architecture beh of ff_jk is
    signal aux : STD_LOGIC;
begin
    ff_jk_p:process(clk)
    begin
        if(rising_edge(clk)) then
            if(J=0 and K=0)then
                aux <= aux;
            elsif(J=1 and K=1)then
                aux <= not aux;
            elsif(K=1) then
                aux <= 0;
            else then
                aux <= 1;
            end if;
    end if;
    end process ff_jk_p;
Q<=aux;
end beh;

