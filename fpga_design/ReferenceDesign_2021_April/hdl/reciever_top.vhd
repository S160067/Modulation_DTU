library ieee;
use ieee.std_logic_1164.all;

entity reciever_top is
port (
	clk, reset : in std_logic;
	data_i, data_q  : in std_logic_vector(13 downto 0);
	fifo_full : in std_logic;
	bitstream, fifo_wr : out std_logic
end reciever_top;

architecture loopback_arch of reciever_top is 
--COMPOENENT DECLARATION

component buffer_rx is
	port (
		clk, reset : in std_logic;
		data_mod : in std_logic_vector(1 downto 0);
		fifo_full, valid : in std_logic;
		bitstream, fifo_wr : out std_logic
		);
end component;

component demodulator is
	port (
		clk, reset, valid_sync : in std_logic
		data_i, data_q : in std_logic_vector(13 downto 0);
		valid, ready : out std_logic;
		data_out : out std_logic_vector(1 downto 0)
		);
end component;

component sync is
	port (
		clk, reset, ready : in std_logic
		data_i, data_q : in std_logic_vector(13 downto 0);
		valid : out std_logic;
		data_i_mod, data_q_mod : out std_logic_vector(13 downto 0)
		);
end component;

component reciever is
	port (
		clk, reset : in std_logic;
		data_i, data_q : in std_logic_vector(13 downto 0);
		data_sync_i, data_sync_q : out std_logic_vector(13 downto 0);
		valid : out std_logic
		);
end component;

-- SIGNALS
	signal data_out_mod : std_logic_vector(1 downto 0);
	signal mod_valid : std_logic;
begin
	buff_inst : component buffer_rx port map(
		clk, reset, data_out_mod, fifo_full, mod_valid, bitsream, fifo_wr
	);
	demod_inst : component sync port map(
		clk, reset, 
	)
end loopback_arch;