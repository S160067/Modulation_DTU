library ieee;
use ieee.std_logic_1164.all;

entity reciever_top is
port (
	clk, reset : in std_logic;
	data_i, data_q  : in std_logic_vector(13 downto 0);
	fifo_full : in std_logic;
	bitstream, fifo_wr : out std_logic;
	debug_data_mod : out std_logic_vector(1 downto 0);
	debug_valid : out std_logic
);
end reciever_top;

architecture loopback_arch of reciever_top is 
--COMPOENENT DECLARATION

component buffer_rx is
	port(
		clk, reset : in std_logic;
		data_mod : in std_logic_vector(1 downto 0);
		fifo_full, valid : in std_logic;
		bitstream, fifo_wr : out std_logic
		);
end component;

component demodulator is
	port (
		clk, reset, valid_sync : in std_logic;
		data_i, data_q : in std_logic_vector(13 downto 0);
		valid : out std_logic;
		data_out : out std_logic_vector(1 downto 0)
		);
end component;

component sync is
	port (
		clk, reset,valid_i : in std_logic;
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
	signal data_from_sync_i,data_from_sync_q, data_from_reciever_i, data_from_reciever_q : std_logic_vector(13 downto 0);
	signal data_from_mod : std_logic_vector(1 downto 0);
	signal demod_valid, sync_valid, reciev_valid : std_logic;
begin

	debug_data_mod <= data_from_mod;
	debug_valid <= reciev_valid;
	
	buff_inst : component buffer_rx port map(
		clk => clk, 
		reset => reset, 
		data_mod => data_from_mod, 
		fifo_full => fifo_full, 
		valid => demod_valid, 
		bitstream => bitstream, 
		fifo_wr => fifo_wr
	);
	demod_inst : component demodulator port map(
		clk => clk, 
		reset => reset, 
		valid_sync => sync_valid, 
		data_i => data_from_sync_i, 
		data_q => data_from_sync_q, 
		valid => demod_valid, 
		data_out => data_from_mod
	);
	sync_inst : component sync port map(
		clk, reset, reciev_valid, data_from_reciever_i, data_from_reciever_q, sync_valid, data_from_sync_i, data_from_sync_q
	);
	receiv_ins : component reciever port map(
		clk, reset, data_i, data_q, data_from_reciever_i, data_from_reciever_q, reciev_valid
	);

end loopback_arch;