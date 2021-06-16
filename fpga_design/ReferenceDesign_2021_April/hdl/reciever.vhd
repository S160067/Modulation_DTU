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

	valid <= data_i(13) OR data_i(12) OR data_i(11) OR data_i(10) OR data_i(9) OR data_i(8) OR data_i(7) OR data_q(13) OR data_q(12) OR data_q(11) OR data_q(10) OR data_q(9) OR data_q(8) OR data_q(7) ; 
	--valid <= '1';
	data_sync_i <= data_i;
	data_sync_q <= data_q;

end loopback_arch;