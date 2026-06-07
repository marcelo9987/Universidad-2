library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_asm is
    port (
        clk     : in  std_logic;
        rst    : in  std_logic;
        cnt_en  : in  std_logic;
        bcd_dec : out std_logic_vector(3 downto 0);
        bcd_uni : out std_logic_vector(3 downto 0)
    );
end entity contador_asm;

architecture Behavioral of contador_asm is
    signal s_units : unsigned(3 downto 0) := (others => '0');
    signal s_tens  : unsigned(3 downto 0) := (others => '0');



begin

    process(clk)
       
        variable n        : integer;
        variable next_n   : integer;
        variable is_prime : boolean;
    begin
    
        if rising_edge(clk) then
            if rst = '1' then
                s_units <= (others => '0');
                s_tens  <= (others => '0');

            elsif cnt_en = '1' then


                n := to_integer(s_tens) * 10 + to_integer(s_units);

                next_n := n + 1;
                if next_n > 99 then
                    next_n := 0;
                end if;

                loop
                    is_prime := true;

                    if next_n < 2 then
                        is_prime := false;
                    elsif (next_n /= 2 and (next_n mod 2) = 0) then
                        is_prime := false;
                    elsif (next_n /= 3 and (next_n mod 3) = 0) then
                        is_prime := false;
                    elsif (next_n /= 5 and (next_n mod 5) = 0) then
                        is_prime := false;
                    elsif (next_n /= 7 and (next_n mod 7) = 0) then
                        is_prime := false;
                    end if;

                    exit when not is_prime;

                    next_n := next_n + 1;
                    if next_n > 99 then
                        next_n := 0;
                    end if;
                end loop;

                s_tens  <= to_unsigned(next_n / 10, 4);
                s_units <= to_unsigned(next_n mod 10, 4);
            end if;
        end if;
    end process;

    bcd_dec <= std_logic_vector(s_tens);
    bcd_uni <= std_logic_vector(s_units);

end Behavioral;
