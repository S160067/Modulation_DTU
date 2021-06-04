-- Quartus Prime VHDL Template
-- Basic Shift Register

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TX_modulation_top IS
	GENERIC (
		DAC_data_width : NATURAL := 14;
		pulse_width : NATURAL := 17
	);

	PORT (
		data_i : IN std_logic_vector(1 DOWNTO 0);
		clk_i : IN std_logic;
		reset_i  : IN std_logic;
		ctrl_o : out std_logic_vector(15 downto 0);
		sample_o : OUT std_logic_vector(DAC_data_width - 1 DOWNTO 0)
	);

END ENTITY;

ARCHITECTURE rtl OF TX_modulation_top IS
component sin_gen is
	port(	
		clk_i 	: std_logic;
		reset_i : std_logic;
		sin_o : OUT std_logic_vector(DAC_data_width - 1 DOWNTO 0));
end component;
component cos_gen is
	port(	
		clk_i 	: std_logic;
		reset_i : std_logic;
		cos_o : OUT std_logic_vector(DAC_data_width - 1 DOWNTO 0));
end component;

component sum IS
	PORT (
      clk : In std_logic;
		signal_re : IN std_logic_vector(DAC_data_width - 1 DOWNTO 0);
      signal_im : IN std_logic_vector(DAC_data_width - 1 DOWNTO 0);
		signal_out : OUT std_logic_vector(DAC_data_width - 1 DOWNTO 0)); 
END component;
component mix_mult IS
	PORT (
      clk : In std_logic;
      mod_enable : std_logic;
		modded_signal : IN std_logic_vector(DAC_data_width - 1 DOWNTO 0);
      carrier_wave : IN std_logic_vector(DAC_data_width - 1 DOWNTO 0);
		data_out : OUT std_logic_vector(DAC_data_width - 1 DOWNTO 0)); 
END component;

signal sin,cos, re, im : std_logic_vector(DAC_data_width - 1 downto 0);
signal zero_vector : std_logic_vector(DAC_data_width -1 downto 0);

BEGIN

u_sin_gen: sin_gen PORT MAP (
	 clk_i => clk_i,
	 reset_i => reset_i,
	 sin_o => sin
);
u_cos_gen: cos_gen PORT MAP (
	 clk_i => clk_i,
	 reset_i => reset_i,
	 cos_o => cos
);
u_re_mult : mix_mult port map (
	clk => clk_i,
	mod_enable => '0',
	modded_signal => zero_vector,
	carrier_wave => sin,
	data_out => re
	);
u_im_mult : mix_mult port map (
	clk => clk_i,
	mod_enable => '0',
	modded_signal => zero_vector,
	carrier_wave => cos,
	data_out => im
	);
u_sum : sum port map
(
   clk => clk_i,
	signal_re => re,
   signal_im => im,
	signal_out => sample_o
);

 
ctrl_o <= (others=>'0');
zero_vector <= (others=>'0');



END rtl;