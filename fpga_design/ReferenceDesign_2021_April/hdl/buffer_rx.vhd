library ieee;
use ieee.std_logic_1164.all;

-- Buffer on reciever side
-- fifo_full, bitstream, fifo_wr : FIFO signals
-- data_mod : demodulated data bits
-- valid: high when data is ready from demodulator

entity buffer_rx is
port (
	clk, reset : in std_logic;
	data_mod : in std_logic_vector(1 downto 0);
	fifo_full, valid : in std_logic;
	bitstream, fifo_wr : out std_logic
	);
end buffer_rx;

architecture arch of buffer_rx is 

signal data_sel, shift1, shift1_next, shift2,shift2_next, shift1_en,shift2_en, reg_in_en : std_logic;
signal reg_in, reg_in_next : std_logic_vector(1 downto 0);

TYPE STATE_TYPE IS (idle_state,loadfirst_state,loadsecond_state,shift_state, end_state);
signal state, next_state : STATE_TYPE ;

begin
	reg_in_next <= data_mod;
	shift1_next <= reg_in(0) when data_sel = '0' else reg_in(1);
	shift2_next <= shift1;
	bitstream <= shift2;

--FSM process
PROCESS (fifo_full, state, next_state, valid)
BEGIN
	shift1_en <= '0';
	shift2_en <= '0';
	reg_in_en <= '0';
	data_sel <= '0';
	fifo_wr <= '0';
	next_state <= idle_state;
   	CASE state IS
	  WHEN idle_state =>
	  	if(fifo_full = '0') then
			if(valid = '1') THEN
				reg_in_en <='1';				
				next_state <= loadfirst_state;
			else 
				next_state <= idle_state;
			end if;
		end if;
	  WHEN loadfirst_state =>
		  if(fifo_full = '0') then
	  		data_sel <= '0';
			shift1_en <='1';
			reg_in_en <= '1';
			next_state <= loadsecond_state;
		end if;

		WHEN loadsecond_state =>
		if(fifo_full = '0') then
			data_sel <= '1';
			shift2_en <= '1';
			shift1_en <= '1';
				next_state <= shift_state;
		end if;
	  WHEN shift_state =>
		  if(fifo_full = '0') then
			fifo_wr <='1';
			shift2_en <= '1';
			
			data_sel <= '1';
			next_state <= end_state;
		end if;
	WHEN end_state =>
		if(fifo_full = '0') then
			fifo_wr <= '1';
		end if;
	END CASE;
END PROCESS;

 -- Register with active-high clock & asynchronous clear
   
   -- FOR BOARD KEY/RESET MIGHT BE INVERTED...
   PROCESS (clk, reset)                      
   BEGIN
			IF reset = '1' THEN
				
			   state <= idle_state;
			   shift1 <= '0';
			   shift2 <= '0';
			   
			ELSIF rising_edge(clk) THEN
			   state <= next_state;
			   if reg_in_en = '1' then
					reg_in <= reg_in_next;
				end if;
			   if shift1_en ='1' then
				   shift1 <= shift1_next;
			   end if;
			   if shift2_en ='1' then
				   shift2 <= shift2_next;
			   end if;
			END IF;		  
   END PROCESS;
   
	

end arch;