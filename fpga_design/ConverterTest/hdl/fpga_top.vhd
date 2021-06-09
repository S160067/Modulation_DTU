library ieee;
use ieee.std_logic_1164.all;

entity fpga_top is
port (
		clk						: in std_logic;
		reset						: in std_logic;
		
		
		-- GPIO INterface to modulation
		GPIO_0					: inout std_logic_vector(35 downto 0);
		GPIO_1					: inout std_logic_vector(35 downto 0);
		SW : in std_logic_vector(9 downto 0);
      	LEDR : out std_logic_vector(9 downto 0);
		KEY_N : in std_logic_vector(3 downto 0)
		);
end fpga_top;

architecture fpga_arch of fpga_top is

component modulation_top is
port (
	clk, reset			: in std_logic;
	-- Datout to GPIO
	GPIO_0 : inout std_logic_vector(35 downto 0);
	GPIO_1 : inout std_logic_vector(35 downto 0);
	-- FIFO SIGNALS
	fifo_bitstream_in, fifo_empty, fifo_full : in std_logic;
	fifo_bitstream_out, fifo_wr, fifo_read_en : out std_logic
	);
	end component modulation_top;
	
	

signal framing_modulation_tx, modulation_framing_rx : std_logic_vector(7 downto 0);
signal GPIO_loopback : std_logic_vector(35 downto 0);

signal status_modulation_wr_data, status_modulation_rd_data						 	: std_logic_vector(23 downto 0);
signal status_modulation_wrreq, status_modulation_full, status_modulation_rdreq, status_modulation_empty : std_logic;

signal sw_in, LEDR_in : std_logic_vector(9 downto 0);
signal key_in : std_logic_vector(3 downto 0);

begin
	sw_in <= SW;
	LEDR_in <= LEDR;
	LEDR <= SW; 
	
modulation_inst : component modulation_top
port map (
	clk => clk, reset => reset,
	GPIO_0 => GPIO_0,
	GPIO_1 => GPIO_1,

	fifo_bitstream_in => sw_in(0), fifo_empty => sw_in(1), fifo_full => sw_in(2),
	fifo_bitstream_out => LEDR_in(0), fifo_wr => LEDR_in(1), fifo_read_en => LEDR_in(2)
	
	);
	
	
	
		
end fpga_arch;

