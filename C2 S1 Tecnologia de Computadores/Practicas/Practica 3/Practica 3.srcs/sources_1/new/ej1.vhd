library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ej1 is
    port
    (
    a,b,c: IN   STD_LOGIC;
    y:     OUT  STD_LOGIC_VECTOR(0 downto 0)
    );
end ej1;

architecture structural of ej1 is
    component mux8_1 is
        generic 
        (
        width:integer
        );
        port
        (
        d0 : in STD_LOGIC_VECTOR(width-1 downto 0);
        d1 : in STD_LOGIC_VECTOR(width-1 downto 0);
        d2 : in STD_LOGIC_VECTOR(width-1 downto 0);
        d3 : in STD_LOGIC_VECTOR(width-1 downto 0);
        d4 : in STD_LOGIC_VECTOR(width-1 downto 0);
        d5 : in STD_LOGIC_VECTOR(width-1 downto 0);
        d6 : in STD_LOGIC_VECTOR(width-1 downto 0);
        d7 : in STD_LOGIC_VECTOR(width-1 downto 0); --  y = 0,1,2,3,4,5,6 
        s : in std_logic_vector(2 downto 0);
        y : out std_logic_vector(width-1 downto 0)
        );
    end component;
    signal seleccionados : STD_LOGIC_VECTOR(2 downto 0);

begin 
    seleccionados <= a&b&c;
    Multiplex1 : mux8_1 
        generic map(1)
        port map
        (
          d0 => "1"
        , d1 => "1"
        , d2 => "1"
        , d3 => "1"
        , d4 => "1"
        , d5 => "1"
        , d6 => "1"
        , d7 => "0"
        ,s   => seleccionados
        ,y   => y);
end structural;