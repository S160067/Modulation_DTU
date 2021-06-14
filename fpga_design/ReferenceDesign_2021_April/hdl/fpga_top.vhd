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
			modulation_scheme_select : in std_logic;
			fifo_bitstream_out, fifo_wr, fifo_read_en : out std_logic
		);
end component modulation_top;



signal framing_modulation_tx, modulation_framing_rx : std_logic_vector(7 downto 0);
signal GPIO_loopback : std_logic_vector(35 downto 0);

signal status_modulation_wr_data, status_modulation_rd_data						 	: std_logic_vector(23 downto 0);
signal status_modulation_wrreq, status_modulation_full, status_modulation_rdreq, status_modulation_empty : std_logic;



begin
	

modulation_inst : component modulation_top
port map (
	clk => clk, reset => reset,
	GPIO_0 => GPIO_0,
	GPIO_1 => GPIO_1,

	fifo_bitstream_in => SW(0), fifo_empty => SW(1), fifo_full => SW(2),
	modulation_scheme_select => SW(9),
	fifo_bitstream_out => LEDR(0), fifo_wr => LEDR(1), fifo_read_en => LEDR(2)
	
	);
	
	
	
		
end fpga_arch;

