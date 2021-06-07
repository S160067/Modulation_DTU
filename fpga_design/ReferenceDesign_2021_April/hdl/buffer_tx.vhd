library ieee;
use ieee.std_logic_1164.all;

-- Buffer on transmitter side
-- read_en, fifo_empty, read_en : FIFO signals
-- data_mod : data bits to modulate
-- ready: high when modulator can recieve data

entity buffer_tx is
port (
	clk, reset, ready : in std_logic;
	bitstream, fifo_empty : in std_logic;
	read_en : out std_logic;
	data_out : out std_logic_vector(1 downto 0)
	);
end buffer_tx;

architecture arch of buffer is 


begin


end arch;