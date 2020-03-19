LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY main IS
GENERIC( 
        RES : INTEGER := 4
    );
    PORT(
        rst : IN STD_LOGIC;
        clk : IN STD_LOGIC;      
        sw_mode : IN STD_LOGIC;
        sw_resolution : IN STD_LOGIC;        
        btn_save : IN STD_LOGIC; 
        btn_record : IN STD_LOGIC;             
        btn_up : IN STD_LOGIC;
        btn_down : IN STD_LOGIC;
        en_acquire : OUT STD_LOGIC;
        en_save : OUT STD_LOGIC;
        resolution: OUT INTEGER;
        radar_arming : OUT STD_LOGIC      
    );
END main;

ARCHITECTURE behavioral OF main IS

    COMPONENT control
        GENERIC( 
            RES : INTEGER
        );
        PORT(
            rst : IN STD_LOGIC;
            clk: IN STD_LOGIC;
            sw_mode : IN STD_LOGIC;
            sw_resolution : IN STD_LOGIC;
            btn_record : IN STD_LOGIC;
            btn_save : IN STD_LOGIC;        
            btn_up : IN STD_LOGIC;
            btn_down : IN STD_LOGIC;
            en_acquire : OUT STD_LOGIC;
            en_save : OUT STD_LOGIC;
            resolution: OUT INTEGER;
            arming : OUT STD_LOGIC    
        );
    END COMPONENT;
    
    COMPONENT debouncer 
        PORT(
            rst : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            i : IN STD_LOGIC;
            o : OUT STD_LOGIC
        );
    END COMPONENT; 
    
    COMPONENT holder 
        PORT(
            rst : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            i : IN STD_LOGIC;
            o : OUT STD_LOGIC
        );
    END COMPONENT;
    
    SIGNAL btn_record_0 : STD_LOGIC := '0';
    SIGNAL btn_save_0 : STD_LOGIC := '0';
    SIGNAL btn_up_0 : STD_LOGIC := '0';
    SIGNAL btn_down_0 : STD_LOGIC := '0';
    SIGNAL radar_arming_0 : STD_LOGIC := '0';

BEGIN

    INST_DEBOUNCER_0 : debouncer 
        PORT MAP(
            rst => rst,
            clk => clk,
            i => btn_record,
            o => btn_record_0
        );
        
    INST_DEBOUNCER_1 : debouncer 
        PORT MAP(
            rst => rst,
            clk => clk,
            i => btn_save,
            o => btn_save_0
        );
        
    INST_DEBOUNCER_2 : debouncer 
        PORT MAP(
            rst => rst,
            clk => clk,
            i => btn_up,
            o => btn_up_0
        );
        
    INST_DEBOUNCER_3 : debouncer 
        PORT MAP(
            rst => rst,
            clk => clk,
            i => btn_down,
            o => btn_down_0
        );
        
    INST_CONTROL : control
        GENERIC MAP( 
            RES => RES
        )   
        PORT MAP(
            rst => rst,
            clk => clk,
            sw_mode => sw_mode,
            sw_resolution => sw_resolution,
            btn_record=> btn_record_0,
            btn_save => btn_save_0,        
            btn_up => btn_up_0,
            btn_down => btn_down_0,
            en_acquire => en_acquire,
            en_save => en_save,
            resolution => resolution,
            arming => radar_arming_0
        );
        
    INST_HOLDER : holder 
        PORT MAP(
            rst => rst,
            clk => clk,
            i => radar_arming_0,
            o => radar_arming
        );

END behavioral;
