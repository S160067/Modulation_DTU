library ieee;
use ieee.std_logic_1164.all;

entity sender_top is
port (
	clk, reset : in std_logic;
	fifo_bitstream, fifo_empty : in std_logic;
	write, read_en : out std_logic;
	data_i, data_q : out std_logic_vector(13 downto 0)
	);
end sender_top;

architecture arch of sender_top is 

-- COMPONENT DECLARATION

component buffer_tx is
	port (
		clk, reset, valid : in std_logic;
		bitstream, fifo_empty : in std_logic;
		read_en : out std_logic;
		data_out : out std_logic_vector(1 downto 0)
		);
end component;

component modulator is
	port (
		clk, reset : in std_logic;
		data_in : in std_logic_vector(1 downto 0);
		data_i, data_q : out std_logic_vector(13 downto 0);
		valid : out std_logic
	);
end component;

component sender is
	port (
		clk, reset, valid : in std_logic;
		data_i, data_q : in std_logic_vector(13 downto 0);
		write : out std_logic;
		data_out_i, data_out_q : out std_logic_vector(13 downto 0)
		);
end component;

-- SIGNAL DECLARATION
	signal mod_ready, mod_valid : std_logic;
	signal buff_data : std_logic_vector(1 downto 0);
	signal data_mod_i, data_mod_q : std_logic_vector(13 downto 0);

begin

	buff_inst : component buffer_tx port map(clk,reset, fifo_bitstream, fifo_empty, read_en, buff_data );
	mod_inst : component modulator port map(clk, reset, buff_data, data_mod_i, data_mod_q, mod_valid);

	sender_inst : component sender port map(clk, reset, mod_valid, data_mod_i, data_mod_q, write, data_i, data_q);


	
end arch;