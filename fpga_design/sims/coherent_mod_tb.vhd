-- Quartus Prime aVHDL Template
-- Basic Shift Register
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;

ENTITY TXRX_mod_tb IS
	GENERIC (
		DAC_data_width : NATURAL := 14;
		pulse_width : NATURAL := 17
	);

END ENTITY;

ARCHITECTURE TB OF TXRX_mod_tb IS
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
component RX_modulation_top IS
	GENERIC (
		DAC_data_width : NATURAL := 14;
		pulse_width : NATURAL := 17
	);
	PORT (
		clk_i 			 : IN std_logic;
		reset_i          : IN std_logic;
		valid_o 		 : out std_logic;	
		data_o 			 : out std_logic_vector(1 downto 0);
		ctrl_o 			 : out std_logic_vector(15 downto 0);
		im_data_valid	 : in std_logic;
		re_data_valid	 : in std_logic;
		im_sample_i 	 : in std_logic_vector(DAC_data_width - 1 DOWNTO 0);
		re_sample_i 	 : in std_logic_vector(DAC_data_width - 1 DOWNTO 0)
		);
end component;
signal re_sample_o, im_sample_o :  std_logic_vector(DAC_data_width - 1 DOWNTO 0);
signal clk,reset_i,buffer_valid_i,buffer_ready_o,im_valid_o,re_valid_o :std_logic;
signal ctrl_o : std_logic_vector(15 downto 0);
signal data_i,test_vector : std_logic_vector(1 downto 0);
signal data_o : std_logic_vector(1 downto 0);
signal valid_o : std_logic;
signal test_valid : std_logic;
signal cnt : std_logic_vector(7 downto 0);
BEGIN

DUT_TX : TX_modulation_top port MAP(
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
DUT_RX : RX_modulation_top port MAP(
	data_o =>data_o,
	clk_i => clk,
	reset_i => reset_i,
	valid_o => valid_o,
	ctrl_o => ctrl_o,
	im_data_valid => im_valid_o,
	re_data_valid => re_valid_o,
	im_sample_i => im_sample_o,
	re_sample_i => re_sample_o

	);

test_valid <= not reset_i;
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
test_vector <= "10";
cnt <= (others=>'0');
wait for 40 ns;
reset_i <= '0';
wait for 30 ns;
wait until CLK='1';
stim_loop : for k in 0 to 500 loop
	
	wait until CLK='1';
	buffer_valid_i <= '1';
	data_i <= test_vector;
	cnt <= cnt+1;
	if(cnt = 6) then
			cnt <= (others=>'0');
			test_vector <= not test_vector;
	end if;
	wait until buffer_ready_o='1';
end loop stim_loop;
wait;
end process;





END TB;