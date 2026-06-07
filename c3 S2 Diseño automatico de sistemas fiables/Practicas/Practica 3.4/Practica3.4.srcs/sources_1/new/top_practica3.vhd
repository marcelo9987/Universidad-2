
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_practica3 is
    Generic ( g_sim_debounce : integer := 100000 );
    Port (
        clk       : in STD_LOGIC;
        rst_n     : in STD_LOGIC; 
        btn_input : in STD_LOGIC; 
        an        : out STD_LOGIC_VECTOR (7 downto 0);
        seg       : out STD_LOGIC_VECTOR (6 downto 0)
    );
end top_practica3;

architecture Behavioral of top_practica3 is

    -- COMPONENTES YA DECLARADOS
    component synchronizer is
        Port ( clk : in STD_LOGIC; async_in : in STD_LOGIC; sync_out : out STD_LOGIC );
    end component;
    
    component debouncer is
        Generic ( g_timeout_cycles : integer );
        Port ( clk, rst, btn_in : in STD_LOGIC; btn_out : out STD_LOGIC );
    end component;

    component edge_detector is
        Port ( clk, sig_in : in STD_LOGIC; edge_out : out STD_LOGIC );
    end component;

    component contador_asm is
        Port ( clk, rst, cnt_en : in STD_LOGIC; cnt_units, cnt_tens : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    component driver_display is
        Port ( clk, rst : in STD_LOGIC; data_units, data_tens : in STD_LOGIC_VECTOR(3 downto 0);
               anode_out : out STD_LOGIC_VECTOR(7 downto 0); seg_out : out STD_LOGIC_VECTOR(6 downto 0));
    end component;

    -- SEÑALES INTERNAS
    signal s_rst       : std_logic;
    signal s_btn_sync  : std_logic;
    signal s_btn_clean : std_logic;
    signal s_cnt_en    : std_logic;
    signal s_units     : STD_LOGIC_VECTOR (3 downto 0);
    signal s_tens      : STD_LOGIC_VECTOR (3 downto 0);

begin
    -- Reset activo alto (el botón es activo bajo)
    s_rst <= not rst_n;

    -- 1. INSTANCIA DEL SINCRONIZADOR
    inst_sync: synchronizer
    port map (
        clk      => clk,
        async_in => btn_input,
        sync_out => s_btn_sync
    );

    -- 2. INSTANCIA DEL DEBOUNCER
    inst_debouncer: entity work.debouncer
    generic map ( g_timeout_cycles => g_sim_debounce ) 
    port map (
        clk        => clk,
        rst        => s_rst,
        btn_in     => s_btn_sync,
        btn_out    => s_btn_clean
    );

    -- 3. INSTANCIA DEL DETECTOR DE FLANCOS
    inst_edge: entity work.edge_detector
    port map (
        clk      => clk,
        sig_in   => s_btn_clean,
        edge_out => s_cnt_en
    );

    -- 4. INSTANCIA DEL CONTADOR
    inst_counter: entity work.contador_asm
    port map (
        clk       => clk,
        rst       => s_rst,
        cnt_en    => s_cnt_en,
        bcd_uni  => s_units,
        bcd_dec  => s_tens
    );

    -- 5. INSTANCIA DEL DRIVER DE DISPLAY
    inst_display: entity work.driver_display
    port map (
        clk        => clk,
        rst        => s_rst,
        data_units => s_units,
        data_tens  => s_tens,
        anode_out  => an,
        seg_out    => seg
    );

end Behavioral;
