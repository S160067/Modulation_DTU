library ieee;
use ieee.std_logic_1164.all;

entity sender_top is
port (
	clk, reset : in std_logic;
	pll_clk_skew : in std_logic;
	write : out std_logic;
	data_out : out std_logic_vector(13 downto 0);
	-- Should be FIFO signals here instead of data_in
	read_en, bitstream, empty : in std_logic
	);
end sender_top;

architecture arch of sender_top is 

	-- BUFFER
	signal buffer_out : std_logic_vector(1 downto 0);
	signal buffer_data_rdy : std_logic;

	signal pulse : std_logic_vector(13 downto 0);
	-- Modulation block
	signal valid : std_logic;
	signal pulse_I, pulse_Q : std_logic_vector(13 downto 0);

begin
	data_out <= reg;
	-- FSM process
	PROCESS (state,next_state,en,pll_clk_da,data_in)
	BEGIN
		next_state <= wait_state;
	   CASE state IS
		  WHEN wait_state =>
		  	next_reg <= ( others => '0');
				if(en = '1') THEN
					if(pll_clk_da = '1') then
						next_state <= send_state;
				end if;
			end if;

		  WHEN send_state =>
			next_reg <= data_in;
				if(en = '1') THEN
					if(pll_clk_da = '1') then
						next_state <= send_state;
					end if;
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
				 reg <= ( others => '0');

			 ELSIF clk'EVENT AND clk = '1' THEN
				 state <= next_state;
				 reg <= next_reg;		 
			END IF;
		  
	END PROCESS;
end arch;