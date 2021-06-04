library ieee;
use ieee.std_logic_1164.all;

entity framing_top is
port (
		clk,reset						: in std_logic;
		
		-- tx video (read side of IP cores FIFO)
		tx_video_data 			: in std_logic_vector(7 downto 0);
		tx_video_rdreq			: out std_logic;
		tx_video_empty			: in std_logic;
		
			
		-- tx drone (read side of IP cores FIFO)
		tx_drone_data 			: in std_logic_vector(7 downto 0);
		tx_drone_rdreq			: out std_logic := '0';
		tx_drone_empty			: in std_logic;
		

		-- tx audio (read side of IP cores FIFO)
		tx_audio_data 			: in std_logic_vector(7 downto 0);
		tx_audio_rdreq			: out std_logic := '0';
		tx_audio_empty			: in std_logic;


		-- rx video (write side of IP cores FIFO)
		rx_video_data 			: out std_logic_vector(7 downto 0);
		rx_video_wrreq			: out std_logic;
		rx_video_full			: in std_logic;
		
			
		-- rx drone (write side of IP cores FIFO)
		rx_drone_data 			: out std_logic_vector(7 downto 0) := "00000000";
		rx_drone_wrreq			: out std_logic := '0';
		rx_drone_full			: in std_logic;

		-- rx audio (write side of IP cores FIFO)
		rx_audio_data 			: out std_logic_vector(7 downto 0) := "00000000";
		rx_audio_wrreq			: out std_logic := '0';
		rx_audio_full			: in std_logic;
		
		-- Interface to modulation block
		modulation_data_in	: in std_logic_vector(7 downto 0);
		modulation_data_out	: out std_logic_vector(7 downto 0);
		
	
		-- command encryption (read side of IP cores FIFO)
		command_encr_data 			: in std_logic_vector(7 downto 0);
		command_encr_rdreq			: out std_logic := '0';
		command_encr_empty			: in std_logic;
		
		-- status encryption (write side of IP core FIFO)
		status_encr_data 			: out std_logic_vector(23 downto 0) := x"000000";
		status_encr_wrreq			: out std_logic := '0';
		status_encr_full			: in std_logic ;
		
				
		-- status encryption (write side of IP core FIFO)
		status_error_data 		: out std_logic_vector(23 downto 0) :=x"000000";
		status_error_wrreq		: out std_logic :='0';
		status_error_full			: in std_logic 

		
		);
			
		
		
		
end framing_top;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture loopback_arch of framing_top is

begin

modulation_data_out <= tx_video_data;
rx_video_data <= modulation_data_in;

process(tx_video_empty, rx_video_full)--, reset)
begin
	if (tx_video_empty='0' and rx_video_full='0') then
		tx_video_rdreq <='1';
	else
		tx_video_rdreq <='0';
	end if;	
end process;

process(clk)
begin
	if rising_edge(clk) then 
		rx_video_wrreq <= tx_video_rdreq;
	end if;
end process;



end loopback_arch;


