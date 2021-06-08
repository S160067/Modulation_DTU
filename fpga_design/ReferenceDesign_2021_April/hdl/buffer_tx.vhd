library ieee;
use ieee.std_logic_1164.all;

-- Buffer on transmitter side
-- read_en, fifo_empty, read_en : FIFO signals
-- data_mod : data bits to modulate
-- ready: high when modulator can recieve data

entity buffer_tx is
port (
	clk, reset, ready : in std_logic;
	bitstream, fifo_empty : in std_logic;
	read_en, valid : out std_logic;
	data_out : out std_logic_vector(1 downto 0)
	);
end buffer_tx;

architecture arch of buffer_tx is 

signal reg1,reg2, reg1_next,reg2_next, reg1_en, reg2_en : std_logic;


TYPE STATE_TYPE IS (valid_state,idle_state,middle_state);
	signal state, next_state : STATE_TYPE := wait_state;
	signal reg, next_reg : std_logic_vector(13 downto 0);
begin

--FSM process
PROCESS (fifo_empty,valid,state,next_state,en,pll_clk_da,data_in)
	BEGIN
		next_state <= wait_state;
	   CASE state IS
		  WHEN idle_state =>
		  	valid <='0';
				if(fifo_empty = '0') THEN
					reg1_en <='1';
					read_en <='1';				
					next_state <= middle_state;
				elsif(fifo_empty ='1' THEN
					next_state <= idle_state;
				end if;

		  WHEN middle_state =>
				next_reg <= data_in;
				valid <='0';
				if(fifo_empty = '0') THEN
					read_en <='1';
					reg2_en <='1';
					next_state <= valid_state;
				elsif(fifo_empty ='1' THEN
					next_state <= middle_state;
					
					end if;
					
		  WHEN valid_state =>
				next_reg <= data_in;
				valid <='1';
			if(ready = '1') THEN
				next_state <= idle_state;
			elsif(ready ='0' THEN
				next_state <= valid_state;
					end if;
		END CASE;
	END PROCESS;

 -- Register with active-high clock & asynchronous clear
   
   -- FOR BOARD KEY/RESET MIGHT BE INVERTED...
	PROCESS (clk, en,reset)                      
	BEGIN
			 IF reset = '1' THEN
				 -- Reset
				 --data_out <= ( others => '0');
				 state <= wait_state;
				 --state <= wait_state;
				 	reg1 <= '0';
					reg2 <= '0';
	
			 ELSIF clk'EVENT AND clk = '1' THEN
				 state <= next_state;
				 reg <= next_reg;		 
				if reg1_en ='1' then
					reg1 <= reg1_next;
				end if;
		
				if reg2_en ='1' then
					reg2 <= reg2_next;
					
				end if;
				END IF;
		  
		  
	END PROCESS;
	
	
	
	



data_out <= reg1 & reg2;

reg1_next <= bitstream; 
reg2_next<= bitstream;





	
	
end arch;

