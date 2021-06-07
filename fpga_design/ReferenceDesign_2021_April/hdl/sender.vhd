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

begin
	write <= valid;
	data_out_i <= data_i
	data_out_q <= data_q
end loopback_arch;