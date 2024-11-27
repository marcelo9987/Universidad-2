library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MEMORY is  port
    ( 
    CLR, CLK : in STD_LOGIC;
    EMPTY : out STD_LOGIC;   
    Q : out STD_LOGIC_VECTOR(7 downto 0)
    ); 
 end MEMORY;  

architecture structural of MEMORY is  
    component SENDER is
        port 
            (
               ENABLE, CLR, CLK     : in STD_LOGIC;
               VALID                : out STD_LOGIC;   
               DATA                 : out STD_LOGIC_VECTOR(7 downto 0) 
           ); 
    end component;  

    component STORAGE is
        port
        (
            CLR, CLK, WE            : in STD_LOGIC;
            DATA                    : in STD_LOGIC_VECTOR (7 downto 0);
            FULL, EMPTY             : out STD_LOGIC;
            Q                       : out STD_LOGIC_VECTOR (7 downto 0) 
        );
    end component;

        SIGNAL seFULL, seENABLE, ssVALID             : STD_LOGIC;
        SIGNAL ssDatos                               : STD_LOGIC_VECTOR(7 downto 0);
begin
    seENABLE <= not(seFULL);
    sender1: SENDER port map
                            (
                                    enable=>seENABLE
                                ,   clk=>CLK
                                ,   clr=>CLR
                                ,   data => ssDatos
                                ,   valid => ssVALID
                            );
    componenteAlmacenaje: STORAGE port map
                            (
                                  CLR   => CLR
                                , CLK   => CLK
                                , DATA  => ssDatos
                                , WE    => ssVALID
                                , FULL  => seFULL
                                , Q     => Q
                                , EMPTY => EMPTY   
                            );
end architecture structural;
