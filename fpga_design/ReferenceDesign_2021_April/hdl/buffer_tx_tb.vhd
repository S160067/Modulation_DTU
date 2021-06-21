library ieee;
use ieee.std_logic_1164.all;


ENTITY buffer_tx_tb IS
END buffer_tx_tb;
 
ARCHITECTURE behavior OF buffer_tx_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
COMPONENT buffer_tx is
port (
	clk, reset,ready : in std_logic;
	bitstream, fifo_empty : in std_logic;
	read_en, valid: out std_logic;
	data_out : out std_logic_vector(1 downto 0)
	);
end component;
 
signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal bitstream, fifo_empty : std_logic := '0';
signal read_en, valid,ready : std_logic;
signal data_out : std_logic_vector(1 downto 0);
 -- Clock period definitions
constant clock_period : time := 20 ns;

BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: component buffer_tx PORT MAP (
   clk, reset, ready, bitstream, fifo_empty, read_en,valid, data_out);
 

-- Clock process definitions
clock_process :process
begin
	clk <= '1';
	wait for clock_period/2;
	clk <= '0';
wait for clock_period/2;
end process;
 
modulator_ready :process
begin
	
	ready <= '1';
	wait for clock_period;
	wait for clock_period;
	wait for clock_period;
	wait for clock_period;
end process;

-- Stimulus process
stim_proc: process
begin
	reset <= '1';
	fifo_empty <= '1';	
	--ready <= '0';
	wait for 40 ns;
	
	reset <= '0';
	bitstream <= '0';
	fifo_empty <='0';
	
	-- 01
	wait until read_en = '1';
	wait for clock_period;
	bitstream <= '0';
	wait for clock_period;
	bitstream <= '1';
	
	--10
	wait until read_en = '1';
	wait for clock_period;
	bitstream <= '1';
	wait for clock_period;
	bitstream <= '0';

	-- 11
	wait until read_en = '1';
	wait for clock_period;
	bitstream <= '1';
	wait for clock_period;
	bitstream <= '1';

	--00
	wait until read_en = '1';
	wait for clock_period;
	bitstream <= '0';
	wait for clock_period;
	bitstream <= '0';

	wait;

end process;
 
END;