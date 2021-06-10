library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod_conv_tb is 

generic (
		constant G_SHIFTREG_SIZE 			: positive := 16;
		constant G_MANTISSA_SIZE			: positive := 13
		);

end mod_conv_tb;

architecture test of mod_conv_tb is

signal s_RESET				: std_logic := '1';
signal s_CLK 				: std_logic := '0';
signal s_data_valid		: std_logic := '1';
signal s_symbol			: std_logic := '1';
signal s_count				: unsigned(1 downto 0) := "00";


component mod_convolution is 
	generic (
		constant G_SHIFTREG_SIZE 			: positive := 16;
		constant G_MANTISSA_SIZE			: positive := 13
		);
		
	port(
		i_rst										: in std_logic;
		i_clk 									: in std_logic;
		i_data_valid							: in std_logic;
		i_symbol									: in std_logic;
		o_result									: out signed(G_MANTISSA_SIZE downto 0);
		o_valid									: out std_logic
		);
end component mod_convolution;


begin 

inst: mod_convolution 
port map (
		i_rst 	=> s_RESET,
		i_clk		=> s_CLK,
		i_data_valid		=> s_data_valid,
		i_symbol   => s_symbol,
		o_result		=> open,
		o_valid		=> open
		);


daclock: process is
	begin 
		wait for 8 ns; 
		s_CLK <= not s_CLK;
end process daclock;

s_RESET <= '1', '0' after 64 ns;

tb: process(s_CLK) is
	begin 
	if s_CLK'event and s_CLK='1' then
		if s_count = "00" then
			s_symbol <= '1';
			s_data_valid <= '1';
			s_count <= s_count + 1;
		else
	      s_data_valid <= '0';
			s_count <= s_count +1;
		end if;
	end if;
	
	if s_RESET = '1' then
		s_data_valid <= '0';
		s_symbol	<= '0';
		s_count <= (others=> '0');
	end if;
	
end process;
end architecture; 