-- Quartus Prime aVHDL Template
-- Basic Shift Register

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RX_modulation_top IS
	GENERIC (
		DAC_data_width : NATURAL := 14;
		pulse_width : NATURAL := 17
	);

	PORT (
		data_i : IN std_logic;
		clk_i : IN std_logic;
		reset_i  : IN std_logic;
		fifo_full_i : in std_logic;
		fifo_read_o : out std_logic;
	
		ctrl_o : out std_logic_vector(15 downto 0);
		im_valid_o : out std_logic;
		im_sample_o : OUT std_logic_vector(DAC_data_width - 1 DOWNTO 0)
		re_valid_o : out std_logic;
		re_sample_o : OUT std_logic_vector(DAC_data_width - 1 DOWNTO 0)
	);

END ENTITY;

ARCHITECTURE rtl OF RX_modulation_top IS
component mod_deshaper is 

		port(
		i_rst									: in std_logic;
		i_clk 									: in std_logic;
		i_data_valid							: in std_logic;
		i_symbol								: in std_logic;
		o_result								: out signed(DAC_data_width-1 downto 0);
		o_valid									: out std_logic
		);	

end component;	
component Mod_interface_RX is
   port (
   	clk 			: in std_logic;
   	reset			: in std_logic;
   	data_i 		: in std_logic;
   	fifo_full : in std_logic;
   	fifo_read : out std_logic;


   	re_o			: out std_logic;
   	im_o 			: out std_logic;
    enable_o	: out std_logic	
    );
end component;

signal io_im_o, io_re_o : std_logic;
signal io_valid_o : std_logic;
BEGIN

re_shaper : mod_deshaper PORT MAP (
	 i_rst => i_rst,
	 i_clk => clk_i,
	 i_data_valid => io_valid_o,
	 i_symbol => io_re_o,
	 o_result => mod_re_o,
	 o_valid => re_valid_o
);
im_shaper : mod_deshaper PORT MAP (
	 i_rst => ,
	 i_clk => clk_i,
	 i_data_valid => io_valid_o,
	 i_symbol => io_im_o,
	 o_result => mod_im_o,
	 o_valid => im_valid_o
);
u_mod_interface : Mod_interface_RX port MAP(
	data_i =>data_i,
	clk_i => clk_i,
	reset_i => reset_i,
	fifo_full_i => fifo_full_i,
	fifo_read_o => fifo_read_o,
	re_o => io_re_o,
	im_o => io_im_o,
	enable_o => io_valid_o
	);

ctrl_o <= (others=>'0');


END rtl;