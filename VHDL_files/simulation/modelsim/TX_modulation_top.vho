-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "05/29/2021 18:38:32"

-- 
-- Device: Altera 5CEBA2F17A7 Package FBGA256
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	TX_modulation_top IS
    PORT (
	data_i : IN std_logic_vector(1 DOWNTO 0);
	clk_i : IN std_logic;
	reset_i : IN std_logic;
	ctrl_o : BUFFER std_logic_vector(15 DOWNTO 0);
	sample : BUFFER std_logic_vector(13 DOWNTO 0)
	);
END TX_modulation_top;

-- Design Ports Information
-- data_i[0]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_i[1]	=>  Location: PIN_D14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk_i	=>  Location: PIN_K15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset_i	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[0]	=>  Location: PIN_T3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[1]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[2]	=>  Location: PIN_F7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[3]	=>  Location: PIN_P2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[4]	=>  Location: PIN_B16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[5]	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[6]	=>  Location: PIN_N1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[7]	=>  Location: PIN_J2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[8]	=>  Location: PIN_G16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[9]	=>  Location: PIN_M11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[10]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[11]	=>  Location: PIN_G15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[12]	=>  Location: PIN_P13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[13]	=>  Location: PIN_N3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[14]	=>  Location: PIN_R7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ctrl_o[15]	=>  Location: PIN_G1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[0]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[1]	=>  Location: PIN_P9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[2]	=>  Location: PIN_M12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[3]	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[4]	=>  Location: PIN_G13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[5]	=>  Location: PIN_L14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[6]	=>  Location: PIN_R14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[7]	=>  Location: PIN_J12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[8]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[9]	=>  Location: PIN_J16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[10]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[11]	=>  Location: PIN_T5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[12]	=>  Location: PIN_T4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sample[13]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF TX_modulation_top IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_data_i : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_clk_i : std_logic;
SIGNAL ww_reset_i : std_logic;
SIGNAL ww_ctrl_o : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_sample : std_logic_vector(13 DOWNTO 0);
SIGNAL \data_i[0]~input_o\ : std_logic;
SIGNAL \data_i[1]~input_o\ : std_logic;
SIGNAL \clk_i~input_o\ : std_logic;
SIGNAL \reset_i~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;

BEGIN

ww_data_i <= data_i;
ww_clk_i <= clk_i;
ww_reset_i <= reset_i;
ctrl_o <= ww_ctrl_o;
sample <= ww_sample;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X14_Y0_N53
\ctrl_o[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(0));

-- Location: IOOBUF_X34_Y45_N36
\ctrl_o[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(1));

-- Location: IOOBUF_X22_Y45_N19
\ctrl_o[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(2));

-- Location: IOOBUF_X11_Y0_N36
\ctrl_o[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(3));

-- Location: IOOBUF_X54_Y19_N39
\ctrl_o[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(4));

-- Location: IOOBUF_X24_Y0_N19
\ctrl_o[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(5));

-- Location: IOOBUF_X10_Y0_N93
\ctrl_o[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(6));

-- Location: IOOBUF_X0_Y19_N22
\ctrl_o[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(7));

-- Location: IOOBUF_X54_Y16_N56
\ctrl_o[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(8));

-- Location: IOOBUF_X36_Y0_N2
\ctrl_o[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(9));

-- Location: IOOBUF_X20_Y45_N36
\ctrl_o[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(10));

-- Location: IOOBUF_X54_Y16_N39
\ctrl_o[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(11));

-- Location: IOOBUF_X36_Y0_N36
\ctrl_o[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(12));

-- Location: IOOBUF_X12_Y0_N2
\ctrl_o[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(13));

-- Location: IOOBUF_X23_Y0_N59
\ctrl_o[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(14));

-- Location: IOOBUF_X0_Y19_N56
\ctrl_o[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_ctrl_o(15));

-- Location: IOOBUF_X22_Y45_N36
\sample[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(0));

-- Location: IOOBUF_X29_Y0_N2
\sample[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(1));

-- Location: IOOBUF_X36_Y0_N19
\sample[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(2));

-- Location: IOOBUF_X34_Y45_N19
\sample[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(3));

-- Location: IOOBUF_X54_Y20_N22
\sample[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(4));

-- Location: IOOBUF_X54_Y15_N5
\sample[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(5));

-- Location: IOOBUF_X38_Y0_N36
\sample[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(6));

-- Location: IOOBUF_X54_Y16_N22
\sample[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(7));

-- Location: IOOBUF_X34_Y45_N53
\sample[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(8));

-- Location: IOOBUF_X54_Y15_N56
\sample[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(9));

-- Location: IOOBUF_X54_Y21_N56
\sample[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(10));

-- Location: IOOBUF_X23_Y0_N93
\sample[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(11));

-- Location: IOOBUF_X23_Y0_N76
\sample[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(12));

-- Location: IOOBUF_X34_Y45_N2
\sample[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_sample(13));

-- Location: IOIBUF_X36_Y45_N52
\data_i[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_data_i(0),
	o => \data_i[0]~input_o\);

-- Location: IOIBUF_X54_Y21_N38
\data_i[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_data_i(1),
	o => \data_i[1]~input_o\);

-- Location: IOIBUF_X54_Y17_N4
\clk_i~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk_i,
	o => \clk_i~input_o\);

-- Location: IOIBUF_X36_Y45_N18
\reset_i~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset_i,
	o => \reset_i~input_o\);

-- Location: MLABCELL_X18_Y43_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


