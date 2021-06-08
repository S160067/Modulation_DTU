library ieee;
use ieee.std_logic_1164.all;


ENTITY buffer_tx_tb IS
END buffer_tx_tb;
 
ARCHITECTURE behavior OF buffer_tx_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
COMPONENT buffer_tx is
port (
	clk, reset, valid : in std_logic;
	bitstream, fifo_empty : in std_logic;
	read_en : out std_logic;
	data_out : out std_logic_vector(1 downto 0)
	);
end component;
 
signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal bitstream, fifo_empty : std_logic := '0';
signal read_en, valid : std_logic := '0';
signal data_out : std_logic_vector(1 downto 0);
 -- Clock period definitions
constant clock_period : time := 20 ns;

BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: buffer_tx PORT MAP (
   clk, reset, valid, bitstream, fifo_empty, read_en, data_out);
 

-- Clock process definitions
clock_process :process
begin
clk <= '0';
wait for clock_period/2;
clk <= '1';
wait for clock_period/2;
end process;
 
-- Stimulus process
stim_proc: process
begin
   reset <= '1';
 -- hold reset state for 100 ns. 
 wait for 20 ns;
   reset <= '0';
-- Test things
wait for 5 ns;
bitstream <= '1';
fifo_empty <='0';
wait for clock_period;
bitstream <='1';


wait for 50 ns;

end process;
 
END;
