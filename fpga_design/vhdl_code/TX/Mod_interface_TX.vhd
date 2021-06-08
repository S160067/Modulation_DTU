library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
ENTITY Mod_interface_TX IS
  GENERIC (
    pulse_width : INTEGER := 17;
    standoff : INTEGER := 0
  );
  PORT (
    clk : IN std_logic;
    reset : IN std_logic;
    data_i : IN std_logic_vector(1 DOWNTO 0);
    buffer_ready : out std_logic;
    buffer_valid : in std_logic;
    re_o : OUT std_logic;
    im_o : OUT std_logic;
    enable_o : OUT std_logic 
  );
END Mod_interface_TX;

ARCHITECTURE rtl OF Mod_interface_TX IS
  --declarations
  SIGNAL time_cnt : std_logic_vector(4 DOWNTO 0);
  SIGNAL symbol_cnt,data_reg : std_logic_vector(1 DOWNTO 0);
  SIGNAL data_available : std_logic;
  SIGNAL int_read,ready : std_logic; --internal flag to signal that read is high
  TYPE t_State IS (idle, sending);
  SIGNAL State : t_State;
BEGIN
  --assignments

  re_o <= data_reg(1);
  im_o <= data_reg(0);
  buffer_ready <= ready;
  --------------------------------------------------
  cnt_reg : PROCESS (clk)
  BEGIN
    IF (rising_edge(clk)) THEN
      IF (reset = '1') THEN
        data_available <= '0';
      ELSE
        IF (state = sending) THEN
          time_cnt <= time_cnt + 1;
        ELSE
          time_cnt <= (others=>'0');
        END IF;
        if(ready='1' AND buffer_valid = '1') THEN
          data_available <= '1';
          data_reg <= data_i;
        else
          data_available <= '0';
        end if;
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
        ready <= '0';
        CASE state IS 
          WHEN idle => 
            ready <= '1';
            IF (data_available = '1') THEN
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