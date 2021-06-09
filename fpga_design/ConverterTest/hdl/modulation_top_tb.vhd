library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

ENTITY modulation_top_tb IS
END modulation_top_tb;
 
ARCHITECTURE behavior OF modulation_top_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
 component modulation_top is
	port (
		clk, reset			: in std_logic;
		-- Datout to GPIO
		GPIO_0 : inout std_logic_vector(35 downto 0);
		GPIO_1 : inout std_logic_vector(35 downto 0);
		-- FIFO SIGNALS
		fifo_bitstream_in, fifo_empty, fifo_full : in std_logic;
		fifo_bitstream_out, fifo_wr, fifo_read_en : out std_logic
	);
end component;

signal clk, reset : std_logic;
signal bitstream_in, bitstream_out, fifo_wr, fifo_full, fifo_read_en, fifo_empty : std_logic := '0';
signal data_i, data_q : std_logic_vector(13 downto 0);
signal GPIO_0, GPIO_1 : std_logic_vector(35 downto 0);
 -- Clock period definitions
constant clock_period : time := 20 ns;

 
BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: modulation_top PORT MAP (
   clk, reset, GPIO_0, GPIO_1, bitstream_in, fifo_empty, fifo_full, bitstream_out, fifo_wr, fifo_read_en);
 

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
   wait for 40 ns;
   reset <= '0';
   wait;

end process;
 
END;
