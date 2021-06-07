
ENTITY Mod_interface_TX IS
  GENERIC (
    pulse_width : INTEGER := 17;
    standoff : INTEGER := 0
  );
  PORT (
    clk : IN std_logic;
    reset : IN std_logic;
    data_i : IN std_logic;
    fifo_empty : IN std_logic;
    fifo_read : OUT std_logic;
    re_o : OUT std_logic;
    im_o : OUT std_logic;
    enable_o : OUT std_logic 
  );
END Mod_interface_TX;

ARCHITECTURE rtl OF Mod_interface_TX IS
  --declarations
  SIGNAL counter : std_logic_vector(4 DOWNTO 0);
  SIGNAL symbol_cnt : std_logic_vector(1 DOWNTO);
  SIGNAL data_sr : std_logic_vector(1 DOWNTO 0);
  SIGNAL data_available : std_logic;
  SIGNAL int_read : std_logic; --internal flag to signal that read is high
  TYPE t_State IS (idle, ready, sending);
  SIGNAL State : t_State;
BEGIN
  --assignments

  re_o <= data_sr(1);
  im_o <= data_sr(0);
  fifo_read <= int_read;
  --------------------------------------------------
  shiftreg : PROCESS (clk)
  BEGIN
    IF (rising_edge(clk)) THEN
      IF (reset = '1') THEN
        symbol_cnt <= (OTHERS => '0');
        data_sr <= (OTHERS => '0');
        data_available <= '0';
        time_cnt <= (OTHERS => '0');
      ELSE
        IF (state = sending) THEN
          time_cnt <= time_cnt + 1;
        ELSE
          time_cnt <= '0';
        END IF;
        IF (data_available <= '0' OR data_read = '1') THEN
          IF (symbol_cnt < 2)
           symbol_cnt <= (OTHERS => '0');
           data_available <= '1';
           ELSE
             data_available <= '0';
             symbol_cnt <= symbol_cnt + 1;
           END IF; 
         END IF;
       END IF;
     END IF; 
   END PROCESS;

   FSM : PROCESS (clk)
   BEGIN
     IF (rising_edge(clk)) THEN
        IF (reset = '1') THEN
          state <= idle;
        END IF;
        enable_o <= '0'; 
        CASE state IS : 
          WHEN idle => 
            IF (data_available) THEN
              state <= sending;
            END IF;
          WHEN sending => 
            enable_o <= '1'; 
            IF (time_cnt = 16) THEN
              state <= idle;
              enable_o <= '0'; 
            END IF;
          WHEN OTHERS => 
            state <= idle;
        END CASE;
      END IF;
    END PROCESS;
END rtl;