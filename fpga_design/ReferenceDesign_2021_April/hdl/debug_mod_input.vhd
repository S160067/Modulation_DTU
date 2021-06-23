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
signal cnt :  integer range 0 to 4;
begin

--FSM process
PROCESS (ready,state, next_state,cnt)
	BEGIN
		valid <= '0';
		next_state <= idle_state;
	   CASE state IS
		  WHEN idle_state =>
			  valid <='1';	
			  bitstream <= "00";
			  if(ready = '1') then
				if(cnt = 3) then
					next_state <= valid_state;
				end if;		 
			else 
				next_state <= idle_state;
			end if;
		  WHEN valid_state =>
				valid <='1';
				bitstream <= "11";
				if(ready = '1') then
					if(cnt = 3) then
						next_state <= idle_state;
					else
						next_state <= valid_state;
					end if;
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
				 cnt <= 0;
				state <= idle_state;
				
			 ELSIF rising_edge(clk) THEN
				state <= next_state;
				if(cnt < 4) then
					cnt <= cnt + 1;
				else
					cnt <= 0;
				end if;
			END IF;		  
	END PROCESS;

	
end arch;
