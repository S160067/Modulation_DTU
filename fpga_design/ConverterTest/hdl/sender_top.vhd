library ieee;
use ieee.std_logic_1164.all;

entity sender_top is
port (
	clk, reset : in std_logic;
	fifo_bitstream, fifo_empty : in std_logic;
	write, read_en : out std_logic;
	data_i, data_q : out std_logic_vector(13 downto 0)
	);
end sender_top;

architecture arch of sender_top is 

-- COMPONENT DECLARATION

-- SIGNAL DECLARATION
	signal data_mod_i, data_mod_q : std_logic_vector(13 downto 0);

	TYPE STATE_TYPE IS (idle_state1,idle_state2,idle_state3,idle_state4,idle_state5,send_state1,send_state2,send_state3,send_state4,send_state5);
	signal state, next_state : STATE_TYPE ;


begin
--data_i <= data_mod_i;
--data_q <= data_mod_q;

--FSM process
PROCESS (state, next_state, data_mod_i, data_mod_q)
	BEGIN
		
	   CASE state IS
		  WHEN idle_state1 =>
		  	write <='1';
			data_i <= "11111111111111";
			data_q <= "00000000000000";
			next_state <= idle_state2;
		WHEN idle_state2 =>
			write <='1';
			data_i <= "11111111111111";
			data_q <= "00000000000000";
			next_state <= idle_state3;
		  WHEN idle_state3 =>
			write <='1';
			data_i <= "11111111111111";
			data_q <= "00000000000000";
			next_state <= idle_state4;
		WHEN idle_state4 =>
			write <='1';
			data_i <= "11111111111111";
			data_q <= "00000000000000";
			next_state <= idle_state5;
		WHEN idle_state5 =>
			write <='1';
			data_i <= "11111111111111";
			data_q <= "00000000000000";
			next_state <= send_state1;
		  WHEN send_state1 =>
			write <= '1';
			data_q <= "11111111111111";
			data_i <= "00000000000000";
			next_state <= send_state2;
			WHEN send_state2 =>
			write <= '1';
			data_q <= "11111111111111";
			data_i <= "00000000000000";
			next_state <= send_state3;
			WHEN send_state3 =>
			write <= '1';
			data_q <= "11111111111111";
			data_i <= "00000000000000";
			next_state <= send_state4;
			WHEN send_state4 =>
			write <= '1';
			data_q <= "11111111111111";
			data_i <= "00000000000000";
			next_state <= send_state5;
			WHEN send_state5 =>
			write <= '1';
			data_q <= "11111111111111";
			data_i <= "00000000000000";
			next_state <= idle_state1;
		END CASE;
	END PROCESS;

 -- Register with active-high clock & asynchronous clear
   
   -- FOR BOARD KEY/RESET MIGHT BE INVERTED...
	PROCESS (clk, reset)                      
	BEGIN
			 IF reset = '1' THEN
				 
				state <= idle_state1;
			
			 ELSIF rising_edge(clk) THEN
				state <= next_state;
				
				END IF;		  
	END PROCESS;

	
end arch;