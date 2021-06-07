library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod_shaper_tb is 

generic (
		constant G_SHIFTREG_SIZE 			: positive := 16;
		constant G_MANTISSA_SIZE			: positive := 13
		);

end mod_shaper_tb;

architecture test of mod_shaper_tb is

signal tb_s_rst			: std_logic := '1';
signal tb_s_clk 			: std_logic := '0';
signal tb_s_data_valid	: std_logic := '1';
signal tb_s_symbol		: std_logic := '0';
signal tb_s_count			: std_logic := '0';


component mod_shaper is 
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

end component;	

begin 

inst: mod_shaper 
port map (
		i_rst 			=> tb_s_rst,
		i_clk				=> tb_s_clk,
		i_data_valid 	=> tb_s_data_valid,
		i_symbol 		=> tb_s_symbol,
		o_result			=> open,
		o_valid			=> open
		);


daclock: process is
	begin 
		wait for 8 ns; 
		tb_s_clk <= not tb_s_clk;
end process daclock;

tb_s_rst <= '1', '0' after 64 ns;

tb: process(tb_s_clk) is
	begin 
	if tb_s_clk'event and tb_s_clk='1' then
			tb_s_symbol <= not tb_s_symbol;
	end if;
	
	if tb_s_rst = '1' then
		tb_s_data_valid <= '1';
		tb_s_symbol <= '0';
		tb_s_count <= '0';
	end if;
	
end process;
end architecture; 