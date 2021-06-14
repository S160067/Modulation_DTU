library ieee;
use ieee.std_logic_1164.all;

entity modulator is
port (
	clk, reset, buf_valid : in std_logic;
	data_in : in std_logic_vector(1 downto 0);
	data_i, data_q : out std_logic_vector(13 downto 0);
	valid, mod_rdy : out std_logic
	);
end modulator;

architecture arch of modulator is 

COMPONENT TX_modulation_top IS
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
	END COMPONENT;
	signal ctrl : std_logic_vector(15 downto 0);
	signal val_mod_re, val_mod_im : std_logic;
	
	begin
	
	valid <= val_mod_re OR val_mod_im;
	tx_mod_inst : component TX_modulation_top port map(
		data_i => data_in, 
		clk_i => clk, 
		reset_i => reset, 
		buffer_valid_i => buf_valid, 
		buffer_ready_o => mod_rdy,
		ctrl_o => ctrl,
		im_valid_o => val_mod_im,
		im_sample_o => data_i,
		re_valid_o => val_mod_re,
		re_sample_o => data_q
	);
end arch;