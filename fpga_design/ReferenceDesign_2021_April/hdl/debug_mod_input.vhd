library ieee;
use ieee.std_logic_1164.all;

-- Buffer on transmitter side
-- read_en, fifo_empty, read_en : FIFO signals
-- data_mod : data bits to modulate
-- ready: high when modulator can recieve data

entity debug_mod_input is
port (
	clk, reset, ready : in std_logic;
	bitstream : out std_logic_vector(1 downto 0); 
	valid : out std_logic
	);
end debug_mod_input;

architecture arch of debug_mod_input is 

TYPE STATE_TYPE IS (idle_state,valid_state);
signal state, next_state : STATE_TYPE ;

begin

--FSM process
PROCESS (ready,state, next_state)
	BEGIN
		valid <= '0';
		next_state <= idle_state;
	   CASE state IS
		  WHEN idle_state =>
			  valid <='1';	
			  bitstream <= "00";
			  if(ready = '1') then			 
				next_state <= valid_state;
			else 
				next_state <= idle_state;
			end if;
		  WHEN valid_state =>
				valid <='1';
				bitstream <= "11";
				if(ready = '1') then
					next_state <= idle_state;
				else 
					next_state <= valid_state;
				end if;
		END CASE;
	END PROCESS;

 -- Register with active-high clock & asynchronous clear
   
   -- FOR BOARD KEY/RESET MIGHT BE INVERTED...
	PROCESS (clk, reset)                      
	BEGIN
			 IF reset = '1' THEN
				 
				state <= idle_state;
				
			 ELSIF rising_edge(clk) THEN
				state <= next_state;
				
			END IF;		  
	END PROCESS;

	
end arch;
