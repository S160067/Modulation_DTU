library ieee;
use ieee.std_logic_1164.all;

entity modulation_top is
port (
	clk, reset, en	: in std_logic;
	data_in : in std_logic_vector(13 downto 0);
	data_out : out std_logic_vector(13 downto 0);
	data_write, data_read : in std_logic
	);
end modulation_top;

architecture loopback_arch of modulation_top is 

	signal sender_output : std_logic_vector(13 downto 0);
	
	component reciever is
		port (
			clk, reset : in std_logic;
			pll_clk_ad, en : in std_logic;
			data_in : in std_logic_vector(13 downto 0);
			data_out : out std_logic_vector(13 downto 0)
			);
	end component;

	component sender is
		port (
			clk, reset : in std_logic;
			pll_clk_da, en : in std_logic;
			data_in : in std_logic_vector(13 downto 0);
			data_out : out std_logic_vector(13 downto 0)
			);
		end component;
	
	
begin

	reciever_inst : component reciever
	port map (
		clk => clk, reset => reset,
		pll_clk_ad => data_write, en => en,
		data_in => sender_output,
		data_out => data_out
	);
	
	sender_inst : component sender
	port map (
		clk => clk, reset => reset,
		pll_clk_da => data_read, en => en,
		data_in => data_in ,
		data_out => sender_output
	);
		
end loopback_arch;