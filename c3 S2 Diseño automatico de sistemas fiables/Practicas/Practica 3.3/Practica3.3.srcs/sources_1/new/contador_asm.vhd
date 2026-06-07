
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_asm is
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        cnt_en  : in  std_logic;
        bcd_dec : out std_logic_vector(3 downto 0);
        bcd_uni : out std_logic_vector(3 downto 0)
    );
end entity contador_asm;

architecture Behavioral of contador_asm is
    signal s_units : unsigned(3 downto 0) := (others => '0');
    signal s_tens  : unsigned(3 downto 0) := (others => '0');
    
    signal n: integer;
    signal estado: integer range 0 to 3;
    
begin

    process(clk)

    begin
    
        if rising_edge(clk) then
            if rst = '1' then
                s_units <= (others => '0');
                s_tens  <= (others => '0');
            
            elsif cnt_en = '1' then
            
                case estado is
                
                    when 0 =>
                        n <= TO_INTEGER(unsigned(s_tens)) * 10 + TO_INTEGER(unsigned(s_units));
                        estado <= 1;
                    
                    when 1 =>
                    
                        if s_units = 9 and s_tens=9 then
                            s_units <= (others => '0');
                            s_tens  <= (others => '0');s_tens<="0000";
                        elsif s_units = 9 then
                            s_units <= (others => '0');
                            s_tens  <= s_tens  + 1;
                        else 
                            s_units <= s_units + 1;
                        end if;
                        
                        estado <= 2;
                    
                    when 2 =>
                    
                        estado <= 1;
                        
                        if n < 2 then
                            estado <= 3;                 -- 0 y 1 no son primos
                        end if;
                     
                        if (n>=100) then
                            estado <= 3;                 -- 0 y 1 no son primos
                        end if;
                        if (((n mod 2) = 0) and n /= 2) then 
                            estado <= 3;
                        end if;
                            
                        if (((n mod 3) = 0) and n /= 3) then
                            estado <= 3;  
                        end if;
            
                        if (((n mod 5) = 0) and n /= 5) then
                            estado <= 3; 
                        end if;
            
                        if (((n mod 7) = 0) and n /= 7) then
                            estado <= 3; 
                        end if;
                        
                    when others =>
                        null;
                   
                end case;
            end if;
            
        end if;
    end process;

    bcd_uni <= std_logic_vector(s_units);
    bcd_dec  <= std_logic_vector(s_tens);

end Behavioral;

