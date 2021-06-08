-- Quartus Prime aVHDL Template
-- Basic Shift Register
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TX_mod_tb IS
	GENERIC (
		DAC_data_width : NATURAL := 14;
		pulse_width : NATURAL := 17
	);

END ENTITY;

ARCHITECTURE TB OF TX_mod_tb IS
component TX_modulation_top IS
	GENERIC (
		DAC_data_width : NATURAL := 14;
		pulse_width : NATURAL := 17
	);

	PORT (
		data_i : IN std_logic_vector(1 downto 0);
		clk_i : IN std_logic;
		
		reset_i  : IN std_logic;
		-- 
		buffer_valid_i : in std_logic;
		buffer_ready_o : out std_logic;
		
		ctrl_o : out std_logic_vector(15 downto 0);
		--
		im_valid_o : out std_logic;
		im_sample_o : OUT std_logic_vector(DAC_data_width - 1 DOWNTO 0);
		re_valid_o : out std_logic;
		re_sample_o : OUT std_logic_vector(DAC_data_width - 1 DOWNTO 0)
	);
end component;
signal re_sample_o, im_sample_o :  std_logic_vector(DAC_data_width - 1 DOWNTO 0);
signal clk,reset_i,buffer_valid_i,buffer_ready_o,im_valid_o,re_valid_o :std_logic;
signal ctrl_o : std_logic_vector(15 downto 0);
signal data_i : std_logic_vector(1 downto 0);
BEGIN

DUT : TX_modulation_top port MAP(
	data_i =>data_i,
	clk_i => clk,
	reset_i => reset_i,
	buffer_valid_i => buffer_valid_i,
	buffer_ready_o => buffer_ready_o,
	ctrl_o=> ctrl_o,
	im_valid_o => im_valid_o,
	im_sample_o => im_sample_o,
	re_valid_o => re_valid_o,
	re_sample_o => re_sample_o
	);




process
BEGIN
wait for 5 ns;
clk <= '0';
wait for 5 ns;
clk <= '1';
end process;


stim: process
BEGIN
reset_i <= '1';
data_i <= (others=>'0');
buffer_valid_i <= '0';
wait for 40 ns;
reset_i <= '0';
wait for 30 ns;
--
wait until CLK='1';
buffer_valid_i <=  '1';
data_i <= b"00";
wait until CLK='1';
buffer_valid_i <=  '0';
wait until CLK='1';
--
wait until CLK='1';
buffer_valid_i <=  '1'; 
data_i <= b"01";
wait until buffer_ready_o='1';
wait until CLK='1';
buffer_valid_i <=  '0';
wait until CLK='1';
--
wait until CLK='1';
buffer_valid_i <=  '1';
data_i <= b"10";
wait until buffer_ready_o='1';
wait until CLK='1';

buffer_valid_i <=  '0';
wait until CLK='1';
--
wait until CLK='1';
buffer_valid_i <=  '1';
data_i <= b"11";
wait until buffer_ready_o='1';
wait until CLK='1';
buffer_valid_i <=  '0';
wait until CLK='1';
wait;
end process;



END TB;