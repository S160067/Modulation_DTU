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
      LEDR : out std_logic_vector(9 downto 0)
		);
end fpga_top;

architecture fpga_arch of fpga_top is

component modulation_top is
port (
	clk, reset			: in std_logic;
	
	-- Data interface from framing and encryption
	framing_tx_data 	: in std_logic_vector(7 downto 0);
	framing_rx_data   : out std_logic_vector(7 downto 0);
	
	-- Datout to GPIO
	GPIO_0 : inout std_logic_vector(35 downto 0);
	GPIO_1 : inout std_logic_vector(35 downto 0);
	
	status_modulation_data 		: out std_logic_vector(23 downto 0);
	status_modulation_wrreq		: out std_logic;
	status_modulation_full			: in std_logic;
		SW : in std_logic_vector(9 downto 0);
      LEDR : out std_logic_vector(9 downto 0)
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
	framing_tx_data => framing_modulation_tx,
	framing_rx_data => modulation_framing_rx,
	GPIO_0 => GPIO_0,
	GPIO_1 => GPIO_1,
	status_modulation_data => status_modulation_wr_data,
	status_modulation_wrreq	=> status_modulation_wrreq,
	status_modulation_full	=> status_modulation_full,
		SW => SW,
      LEDR => LEDR
	);
	
	
	
		
end fpga_arch;


