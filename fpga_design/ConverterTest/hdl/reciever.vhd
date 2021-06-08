library ieee;
use ieee.std_logic_1164.all;

entity reciever is
port (
	clk, reset : in std_logic;
	data_i, data_q : in std_logic_vector(13 downto 0);
	data_sync_i, data_sync_q : out std_logic_vector(13 downto 0);
	valid : out std_logic
	);
end reciever;

architecture loopback_arch of reciever is 

begin
	data_sync_i <= data_i;
	data_sync_q <= data_q;

end loopback_arch;