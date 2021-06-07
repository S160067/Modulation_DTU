library ieee;
use ieee.std_logic_1164.all;

entity sync is
port (
	clk, reset : in std_logic
	data_i, data_q : in std_logic_vector(13 downto 0);
	valid : out std_logic;
	data_i_mod, data_q_mod : out std_logic_vector(13 downto 0)
	);
end sync;

architecture arch of sync is 


begin


end arch;