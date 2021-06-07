library ieee;
use ieee.std_logic_1164.all;

entity demodulator is
	port (
		clk, reset, valid_sync : in std_logic
		data_i, data_q : in std_logic_vector(13 downto 0);
		valid : out std_logic;
		data_out : out std_logic_vector(1 downto 0)
		);
	end demodulator;
architecture arch of demodulator is 
	

begin

	data_out <= data_i(0) & data_q(0);

end arch;