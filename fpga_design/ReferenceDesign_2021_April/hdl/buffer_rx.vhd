library ieee;
use ieee.std_logic_1164.all;

-- Buffer on reciever side
-- fifo_full, bitstream, fifo_wr : FIFO signals
-- data_mod : demodulated data bits
-- valid: high when data is ready from demodulator

entity buffer_rx is
port (
	clk, reset : in std_logic;
	data_mod : in std_logic_vector(1 downto 0);
	fifo_full, valid : in std_logic;
	bitstream, fifo_wr : out std_logic
	);
end buffer_rx;

architecture arch of buffer is 


begin

	bitstream <= data_mod(0);

end arch;
