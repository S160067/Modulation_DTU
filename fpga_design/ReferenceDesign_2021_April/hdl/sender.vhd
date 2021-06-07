library ieee;
use ieee.std_logic_1164.all;

entity sender is
port (
	clk, reset, valid : in std_logic;
	data_i, data_q : in std_logic_vector(13 downto 0);
	write : out std_logic:
	data_out_i, data_out_q : out std_logic_vector(13 downto 0)
	);
end sender;

architecture loopback_arch of sender is 

	TYPE STATE_TYPE IS (wait_state,send_state);
	signal state, next_state : STATE_TYPE := wait_state;
	signal reg, next_reg : std_logic_vector(13 downto 0);
begin
	data_out <= reg;
	-- FSM process
	PROCESS (state,next_state,valid,data_in)
	BEGIN
	next_reg <= ( others => '0');
	next_state <= wait_state;
		CASE state IS
		  	WHEN wait_state =>
				if(valid = '1') THEN
					next_reg <= data_in;
					write <= '1';
					next_state <= send_state;
			end if;

		    WHEN send_state =>
				if(valid = '1') THEN
					next_reg <= data_in;
					next_state <= send_state;
				end if;
		END CASE;
	END PROCESS;
   
   -- Register with active-high clock & asynchronous clear
   
   -- FOR BOARD KEY/RESET MIGHT BE INVERTED...
	PROCESS (clk,reset)                      
	BEGIN
			 IF reset = '1' THEN
				 state <= wait_state;
				 reg <= ( others => '0');

			 ELSIF clk'EVENT AND clk = '1' THEN
				 state <= next_state;
				 reg <= next_reg;		 
			END IF;
		  
	END PROCESS;
end loopback_arch;