library ieee;
use ieee.std_logic_1164.all;

	entity modulation_top is
port (
	clk, reset			: in std_logic;
	
	-- Datout to GPIO
	GPIO_0 : inout std_logic_vector(35 downto 0);
	GPIO_1 : inout std_logic_vector(35 downto 0)
	-- FIFO SIGNALS
	fifo_data_in : in std_logic:
	fifo_data_out : out std_logic:
	
	);
end modulation_top;

architecture loopback_arch of modulation_top is 

	component ip_pll is
	port (
		refclk   : in  std_logic := '0'; --  refclk.clk
		rst      : in  std_logic := '0'; --   reset.reset
		outclk_0 : out std_logic;        -- outclk0.clk
		outclk_1 : out std_logic         -- outclk1.clk
	);
	end component;

	signal data_out_a, data_out_b, data_in_a, data_in_b : std_logic_vector(13 downto 0);
	signal pll_clk, pll_clk_skew : std_logic;
	


begin
	
	pll_inst : component ip_pll
		port map (
			refclk  	=> clk, --  refclk.clk
			rst 		=> reset, --   reset.reset
			outclk_0 => pll_clk,        -- outclk0.clk
			outclk_1 => pll_clk_skew        -- outclk1.clk
			);

	data_AD_a <= GPIO_0(31) & GPIO_0(29) & GPIO_0(30) & GPIO_0(28) & GPIO_0(27) & GPIO_0(25) & 
						GPIO_0(26) & GPIO_0(24) & GPIO_0(23) & GPIO_0(21) & GPIO_0(22) & GPIO_0(20) & 
						GPIO_0(19) & GPIO_0(17) ;
					  
	data_AD_b <= GPIO_0(15) & GPIO_0(3) & GPIO_0(14) & GPIO_0(12) & GPIO_0(11) & GPIO_0(9) & GPIO_0(10) & 
					  GPIO_0(8) & GPIO_0(7) & GPIO_0(5) & GPIO_0(6) & GPIO_0(4) & GPIO_0(3) & GPIO_0(1);
					  
	
	data_DA_b <= GPIO_1 (19 ) & GPIO_1 (21 ) & GPIO_1 (22 ) & GPIO_1 (24 ) & GPIO_1 (23 ) & GPIO_1 (25 ) & 
						GPIO_1 (27 ) & GPIO_1 (29 ) & GPIO_1 (26 ) & GPIO_1 (28 ) & GPIO_1 (31 ) & GPIO_1 (33 ) & 
						GPIO_1 (30 ) & GPIO_1 (32 );

	data_DA_a <= GPIO_1 (1 ) & GPIO_1 (3 ) & GPIO_1 (4 ) & GPIO_1 (6 ) & GPIO_1 (5 ) & GPIO_1 (7 ) & 
						GPIO_1 (8 ) & GPIO_1 (10 ) & GPIO_1 (9 ) & GPIO_1 (11 ) & GPIO_1 (12 ) & GPIO_1 (14 ) & 
						GPIO_1 (13 ) & GPIO_1 (15 );

	GPIO_0(33) <= SW(0); --Enable B
	GPIO_0(35) <= SW(1); --Enable A

   GPIO_0(18) <= clk; --PLL Clock to ADC_B
   GPIO_0(16) <= clk; --PLL Clock to ADC_A


  GPIO_0(32) <= '1'; --POWER ON
  GPIO_1(35) <= '1'; --Mode Select. 1 = dual port &  0 = interleaved.

  GPIO_1(18) <= pll_clk; --PLL Clock to DAC_B
  GPIO_1(16) <= pll_clk; --PLL Clock to DAC_A

  GPIO_1(34) <= pll_clk_skew; --Input write signal for PORT B
  GPIO_1(17) <= pll_clk_skew; --Input write signal for PORT A
  
	
end loopback_arch;