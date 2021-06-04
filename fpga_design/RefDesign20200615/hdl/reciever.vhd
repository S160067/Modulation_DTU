library ieee;
use ieee.std_logic_1164.all;

entity reciever is
port (
	clk, reset : in std_logic;
	pll_clk_ad, en : in std_logic;
	data_in : in std_logic_vector(13 downto 0);
	data_out : out std_logic_vector(13 downto 0)
	);
end reciever;

architecture loopback_arch of reciever is 

TYPE STATE_TYPE IS (wait_state,read_state);
signal state,next_state : STATE_TYPE;
signal reg, next_reg : std_logic_vector(13 downto 0);

begin
	data_out <= reg;
-- FSM process
PROCESS (state,next_state,en,pll_clk_ad,data_in)
BEGIN
	next_state <= wait_state;
	next_reg <= ( others => '0');
	CASE state IS
	  WHEN wait_state =>
			if(en = '1') THEN
				if(pll_clk_ad = '1') then
					next_state <= read_state;
			end if;
		end if;

	  WHEN read_state =>
		next_reg <= data_in;
			if(en = '1') THEN
				if(pll_clk_ad = '1') then
					next_state <= read_state;
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
			 reg <= ( others => '0');
		 ELSIF clk'EVENT AND clk = '1' THEN
			 state <= next_state;	
			 reg <= next_reg;
		END IF;
	  
END PROCESS;
end loopback_arch;