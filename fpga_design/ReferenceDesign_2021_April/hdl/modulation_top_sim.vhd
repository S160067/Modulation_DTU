library ieee;
use ieee.std_logic_1164.all;

entity modulation_top_sim is
	port (
		clk, reset			: in std_logic;
		-- Datout to GPIO
		GPIO_0 : inout std_logic_vector(35 downto 0);
		GPIO_1 : inout std_logic_vector(35 downto 0);
		-- FIFO SIGNALS
		fifo_bitstream_in, fifo_empty, fifo_full : in std_logic;
		modulation_scheme_select : in std_logic;
		fifo_bitstream_out, fifo_wr, fifo_read_en : out std_logic
	);
end modulation_top_sim;

architecture loopback_arch of modulation_top_sim is 

	component sender_top is
		port (
			clk, reset : in std_logic;
			fifo_bitstream, fifo_empty : in std_logic;
			write, read_en : out std_logic;
			data_i, data_q : out std_logic_vector(13 downto 0);
			modulation_scheme_select : in std_logic
			);
	end component;

	component reciever_top is
		port (
			clk, reset : in std_logic;
			data_i, data_q  : in std_logic_vector(13 downto 0);
			fifo_full : in std_logic;
			bitstream, fifo_wr : out std_logic
		);
	end component;

	signal data_AD_a, data_AD_b, data_DA_a, data_DA_b, test_i, test_q : std_logic_vector(13 downto 0);
	signal pll_clk_125, pll_clk_125_skew, pll_clk_65 : std_logic;
	signal sender_write : std_logic;
	
	signal rst_inv : std_logic;
	
begin
	rst_inv <= not reset;
	
	sender_inst : component sender_top port map(
		clk => clk, 
		reset => rst_inv, 
		fifo_bitstream => fifo_bitstream_in, fifo_empty => fifo_empty, 
		write => sender_write , 
		read_en => fifo_read_en, 
		data_i => test_i, 
		data_q => test_q,
		modulation_scheme_select => modulation_scheme_select
	);
	reciever_inst : component reciever_top port map(
		clk => clk, 
		reset => rst_inv, 
		data_i => test_i, 
		data_q => test_q, 
		fifo_full => fifo_full, 
		bitstream => fifo_bitstream_out, 
		fifo_wr => fifo_wr
	);
	
	
end loopback_arch;