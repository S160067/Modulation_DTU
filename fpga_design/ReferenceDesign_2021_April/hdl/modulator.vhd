library ieee;
use ieee.std_logic_1164.all;

entity modulator is
port (
	clk, reset : in std_logic
	data_in : in std_logic_vector(1 downto 0);
	data_i, data_q : out std_logic_vector(13 downto 0);
	valid, ready : out std_logic
	);
end modulator;

architecture arch of demodulator is 


begin


end arch;