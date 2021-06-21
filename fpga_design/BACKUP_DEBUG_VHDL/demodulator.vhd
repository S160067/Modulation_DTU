library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity demodulator is
	port (
		clk, reset, valid_sync : in std_logic;
		data_i, data_q : in std_logic_vector(13 downto 0);
		valid : out std_logic;
		data_out : out std_logic_vector(1 downto 0)
		);
end demodulator;
architecture arch of demodulator is 

signal ctrl : std_logic_vector(15 downto 0);

component RX_modulation_top IS
	GENERIC (
		DAC_data_width : integer := 14;
		pulse_width : integer := 17;
		msg_data_width : integer := 8
	);

	PORT (
		data_o : out std_logic_vector(1 downto 0);
		clk_i : IN std_logic;
		reset_i  : IN std_logic;
		valid_o : out std_logic;	
		ctrl_o : out std_logic_vector(15 downto 0);
		im_data_valid	 : in std_logic;
		re_data_valid	 : in std_logic;
		im_sample_i : in std_logic_vector(DAC_data_width - 1 DOWNTO 0);
		re_sample_i : in std_logic_vector(DAC_data_width - 1 DOWNTO 0)
	);
END component;

begin

	mod_inst : component RX_modulation_top port map(
		data_o => data_out,
		clk_i => clk,
		reset_i => reset,
		valid_o => valid,
		ctrl_o => ctrl,
		im_data_valid => valid_sync,
		re_data_valid => valid_sync,
		im_sample_i => data_i,
		re_sample_i => data_q
	);

end arch;