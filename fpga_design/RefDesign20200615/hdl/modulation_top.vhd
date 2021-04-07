library ieee;
use ieee.std_logic_1164.all;

entity modulation_top is
port (
	clk, reset			: in std_logic;
	
	-- Data interface from framing and encryption
	framing_tx_data 	: in std_logic_vector(7 downto 0);
	framing_rx_data   : out std_logic_vector(7 downto 0);
	
	-- Datout to GPIO
	GPIO_0 : out std_logic_vector(35 downto 0);
	GPIO_1 : in std_logic_vector(35 downto 0);
	status_modulation_data 		: out std_logic_vector(23 downto 0) := x"000000";
	status_modulation_wrreq		: out std_logic := '0';
	status_modulation_full			: in std_logic
	);
end modulation_top;

architecture loopback_arch of modulation_top is 
begin

	framing_rx_data <= framing_tx_data;
	--GPIO_0(7 downto 0) <= framing_tx_data;
	--framing_rx_data <= GPIO_1(7 downto 0);
end loopback_arch;