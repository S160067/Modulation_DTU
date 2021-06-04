-- Quartus Prime VHDL Template
-- Basic Shift Register

library ieee;
use ieee.std_logic_1164.all;

entity Fifo_mux is

	port 
	(
		clk		: in std_logic;
		enable	: in std_logic;
		x	    : in std_logic(3 downto 0);
		y_o	: out std_logic_vector(3 downto 0)
	);

end entity;

architecture rtl of Fifo_mux is

	-- Build an array type for the shift register
	type sr_length is array ((NUM_STAGES-1) downto 0) of std_logic;

	-- Declare the shift register signal
	signal sr: sr_length;

begin

	process (clk)
	begin
		if (rising_edge(clk)) then

			if (enable = '1') then
				y_o <= y;
			end if;	
		end if;
	end process;

	-- Capture the data from the last stage, before it is lost
	case phase[31 downto 24] is
	when x"0000" =>  sinewave <= x"0000";
	

	endcase

end rtl;
