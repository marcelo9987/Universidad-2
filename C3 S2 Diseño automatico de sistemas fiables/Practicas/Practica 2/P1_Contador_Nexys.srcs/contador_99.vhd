-- contador_99_skeleton.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_99 is
    Port (
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        cnt_en   : in  STD_LOGIC;
        cnt_units : out STD_LOGIC_VECTOR (3 downto 0);
        cnt_tens  : out STD_LOGIC_VECTOR (3 downto 0)
    );
end contador_99;

architecture Behavioral of contador_99 is
    signal s_units : unsigned(3 downto 0) := (others => '0');
    signal s_tens  : unsigned(3 downto 0) := (others => '0');
    signal n: integer;
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                s_units <= (others => '0');
                s_tens  <= (others => '0');
            elsif cnt_en = '1' then
            loop
            
                if s_units = 9 and s_tens=9 then
                     s_units <= (others => '0');
                    s_tens  <= (others => '0');s_tens<="0000";
                elsif s_units = 9 then
                    s_units <= (others => '0');
                   s_tens  <= s_tens  + 1;
                else 
                    s_units <= s_units + 1;
                end if;

               n <= TO_INTEGER(unsigned(s_tens)) * 10 + TO_INTEGER(unsigned(s_units));
               
            -- IS PRIME??/
                if n < 2 then
                    exit;                 -- 0 y 1 no son primos
                end if;
                
                if (n mod 2 = 0) and n /= 2 then 
                    exit;
                end if;
                
                if (n mod 3 = 0) and n /= 3 then
                    exit;  
                 end if;
                if (n mod 5 = 0) and n /= 5 then
                    exit; 
                end if;
                if (n mod 7 = 0) and n /= 7 then
                    exit; 
                end if;
                
            end loop;
            
            end if;
        end if;
    end process;

    cnt_units <= std_logic_vector(s_units);
    cnt_tens  <= std_logic_vector(s_tens);

end Behavioral;


