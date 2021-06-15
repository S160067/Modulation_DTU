

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RX_modulation_top IS
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

END ENTITY;

ARCHITECTURE rtl OF RX_modulation_top IS
component mod_deconv is 
		port(
		i_rst									: in std_logic;
		i_clk 									: in std_logic;
		i_data_valid							: in std_logic;
		i_sample								: in std_logic_vector(DAC_data_width-1 downto 0);
		o_symbol								: out std_logic;
		o_valid									: out std_logic
		);	

end component;	
component Mod_interface_RX is
   port (
   	clk 			: in std_logic;
   	reset			: in std_logic;
   	data_o 			: out std_logic_vector(1 downto 0);
   	valid_o 		: out std_logic;
   	re_i			: in std_logic;
   	im_i 			: in std_logic;
		im_valid_i  : in std_logic;
		re_valid_i	: in std_logic		--note: 	 is  re_valid && im_valid	
    );
end component;

component mod_conv_rx_new is 
port(
i_rst						    : in std_logic;
i_clk 						  	: in std_logic;
i_data_valid				  	: in std_logic;
i_element				    	: in signed(G_MANTISSA_SIZE downto 0);
o_result					    : out signed(G_MANTISSA_SIZE downto 0);
o_valid						  	: out std_logic
);
END component;
signal re, im : std_logic;
signal im_valid, re_valid : std_logic;
BEGIN
--assigns
-----------------------------------------
--port maps
entity mod_conv_rx_new is 
generic (
constant G_SHIFTREG_SIZE 	    : positive := 16;
constant G_MANTISSA_SIZE	    : positive := 13
);
re_deconv : mod_conv_rx_new PORT MAP (
	 i_rst => reset_i,
	 i_clk => clk_i,
	 i_data_valid => re_data_valid,
	 i_element => re_sample_i,
	 o_result => re_sample_conv,
	 o_valid => re_valid_conv
);
im_deconv : mod_conv_rx_new PORT MAP (
	 i_rst => reset_i,
	 i_clk => clk_i,
	 i_data_valid => im_data_valid,
	 i_element => im_sample_i,
	 o_result => im_sample_conv,
	 o_valid => im_valid_conv
);

re_deshaper : mod_deconv PORT MAP (
	 i_rst => reset_i,
	 i_clk => clk_i,
	 i_data_valid => re_data_valid,
	 i_sample => re_sample_i,
	 o_symbol => re,
	 o_valid => re_valid
);
im_deshaper : mod_deconv PORT MAP (
	 i_rst => reset_i,
	 i_clk => clk_i,
	 i_data_valid => im_data_valid,
	 i_sample => im_sample_i,
	 o_symbol => im,
	 o_valid => im_valid
);

u_mod_interface : Mod_interface_RX port MAP(
	clk		  => 	clk_i,
	reset 	  => 	reset_i,
	re_i 		=>	 re,
	im_i 	=>	 im,
	re_valid_i => re_valid,
	im_valid_i => im_valid,
	data_o 	=> data_o,
	valid_o	 => valid_o);
----------------------------------------------------
ctrl_o <= (others=>'0');

END rtl;