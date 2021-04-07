library ieee;
use ieee.std_logic_1164.all;

entity fpga_top is
port (
		clk						: in std_logic;
		reset						: in std_logic;
		
		-- tx video
		tx_video_data 			: in std_logic_vector(7 downto 0);
		tx_video_rdreq			: out std_logic;
		tx_video_empty			: in std_logic;
		
		-- rx video
		rx_video_data 			: out std_logic_vector(7 downto 0);
		rx_video_wrreq			: out std_logic;
		rx_video_full			: in std_logic;

		
		-- ctrl tx
		ctrl_tx_data 			: in std_logic_vector(7 downto 0);
		ctrl_tx_rdreq			: out std_logic;
		ctrl_tx_empty			: in std_logic;
		
		-- ctrl tx
		ctrl_rx_data 			: out std_logic_vector(31 downto 0);
		ctrl_rx_wrreq			: out std_logic;
		ctrl_rx_full			: in std_logic;
		
		-- GPIO INterface to modulation
		GPIO_0					: inout std_logic_vector(35 downto 0);
		GPIO_1					: inout std_logic_vector(35 downto 0)
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
	status_modulation_full			: in std_logic
	);
end component modulation_top;

--component control_manager is
--port (

--);
--end component control_manager;
		

--framing: component framing_top
--port map (
--);	

signal video_fifo_tx_data, video_fifo_rx_data, video_fifo_tx_q, video_fifo_rx_q	: std_logic_vector(7 downto 0);
signal video_fifo_tx_wrreq, video_fifo_tx_full, video_fifo_tx_rdreq, video_fifo_tx_empty: std_logic;
signal video_fifo_rx_wrreq, video_fifo_rx_full, video_fifo_rx_rdreq, video_fifo_rx_empty: std_logic;



signal framing_modulation_tx, modulation_framing_rx : std_logic_vector(7 downto 0);
signal GPIO_loopback : std_logic_vector(35 downto 0);

signal command_wr_data, command_rd_data						 	: std_logic_vector(7 downto 0);
signal command_wrreq, command_full, command_rdreq, command_empty : std_logic;

signal status_wr_data, status_rd_data						 	: std_logic_vector(31 downto 0);
signal status_wrreq, status_full, status_rdreq, status_empty : std_logic;

signal status_encr_wr_data, status_encr_rd_data						 	: std_logic_vector(23 downto 0);
signal status_encr_wrreq, status_encr_full, status_encr_rdreq, status_encr_empty : std_logic;
signal status_error_wr_data, status_error_rd_data						 	: std_logic_vector(23 downto 0);
signal status_error_wrreq, status_error_full, status_error_rdreq, status_error_empty : std_logic;
signal status_modulation_wr_data, status_modulation_rd_data						 	: std_logic_vector(23 downto 0);
signal status_modulation_wrreq, status_modulation_full, status_modulation_rdreq, status_modulation_empty : std_logic;



begin
	

modulation_inst : component modulation_top
port map (
	clk => clk, reset => reset,
	framing_tx_data => framing_modulation_tx,
	framing_rx_data => modulation_framing_rx,
	GPIO_0 => GPIO_loopback,
	GPIO_1 => GPIO_loopback,
	status_modulation_data => status_modulation_wr_data,
	status_modulation_wrreq	=> status_modulation_wrreq,
	status_modulation_full	=> status_modulation_full
	);
	
	
	
		
end fpga_arch;


