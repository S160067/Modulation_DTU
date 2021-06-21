library ieee;
use ieee.std_logic_1164.all;

entity sender_top is
port (
	clk, reset : in std_logic;
	fifo_bitstream, fifo_empty : in std_logic;
	write, read_en : out std_logic;
	data_i, data_q : out std_logic_vector(13 downto 0);
	modulation_scheme_select : in std_logic;
	debug_select : in std_logic
	);
end sender_top;

architecture arch of sender_top is 

-- COMPONENT DECLARATION
component buffer_tx is
	port (
		clk, reset, ready : in std_logic;
		bitstream, fifo_empty : in std_logic;
		read_en, valid : out std_logic;
		data_out : out std_logic_vector(1 downto 0)
		);
end component;

component modulator is
	port (
		clk, reset, buf_valid : in std_logic;
		data_in : in std_logic_vector(1 downto 0);
		data_i, data_q : out std_logic_vector(13 downto 0);
		valid, mod_rdy : out std_logic
	);
end component;

COMPONENT sin_gen IS
	GENERIC (
		data_width : NATURAL := 14;
		pulse_width : NATURAL := 17;
		phase_width : NATURAL := 5
	);
	PORT (
		clk_i 	: std_logic;
		reset_i : std_logic;
		--phase_i : IN std_logic(phase_width - 1 DOWNTO 0);
		sin_o : OUT std_logic_vector(data_width - 1 DOWNTO 0)
	);
END COMPONENT;
COMPONENT cos_gen IS
	GENERIC (
		data_width : NATURAL := 14;
		pulse_width : NATURAL := 17;
		phase_width : NATURAL := 5
	);
	PORT (
		clk_i 	: std_logic;
		reset_i : std_logic;
		--phase_i : IN std_logic(phase_width - 1 DOWNTO 0);
		cos_o : OUT std_logic_vector(data_width - 1 DOWNTO 0)
	);
END COMPONENT;

component debug_mod_input is
	port (
		clk, reset, ready : in std_logic;
		bitstream : out std_logic_vector(1 downto 0); 
		valid : out std_logic
	);
end component;
	
-- SIGNAL DECLARATION
	signal mod_ready, mod_valid, buf_valid : std_logic;
	signal buff_data, mux_out : std_logic_vector(1 downto 0);
	signal data_mod_i, data_mod_q, data_sin_i, data_cos_q : std_logic_vector(13 downto 0);
	signal debug_data_out : std_logic_vector(1 downto 0);
	signal debug_data_valid, mux_val : std_logic;
	
begin

	write <= mod_valid;

	data_i <= data_mod_i when modulation_scheme_select = '0' else data_sin_i;
	data_q <= data_mod_q when modulation_scheme_select = '0' else data_cos_q;

	mux_val <= buf_valid when debug_select = '0' else debug_data_valid;
	mux_out <= buff_data when debug_select = '0' else debug_data_out;

	buff_inst : component buffer_tx port map(
		clk => clk,
		reset => reset,
		ready =>  mod_ready,
		bitstream => fifo_bitstream, 
		fifo_empty => fifo_empty, 
		read_en => read_en, 
		valid => buf_valid,
		data_out => buff_data 
	);
	mod_inst : component modulator port map(
		clk => clk, 
		reset => reset, 
		buf_valid => mux_val,
		data_in => mux_out, 
		data_i => data_mod_i, 
		data_q => data_mod_q, 
		valid => mod_valid,
		mod_rdy => mod_ready
	);

	sin_inst : component sin_gen port map(
		clk_i => clk,
		reset_i => reset,
		sin_o => data_sin_i
	);
	cos_inst : component cos_gen port map(
		clk_i => clk,
		reset_i => reset,
		cos_o => data_cos_q
	);

	debug_inst : component debug_mod_input port map(
		clk => clk,
		reset => reset,
		ready => mod_ready,
		bitstream => debug_data_out,
		valid => debug_data_valid
	);


	
end arch;