library ieee;
use ieee.std_logic_1164.all;

entity modulation_top is
	port (
		clk, reset			: in std_logic;
		-- Datout to GPIO
		GPIO_0 : inout std_logic_vector(35 downto 0);
		GPIO_1 : inout std_logic_vector(35 downto 0);
		-- FIFO SIGNALS
		fifo_bitstream_in, fifo_empty, fifo_full : in std_logic;
		fifo_bitstream_out, fifo_wr, fifo_read_en : out std_logic
	);
end modulation_top;

architecture loopback_arch of modulation_top is 

	component ip_pll is
	port (
		refclk   : in  std_logic := '0'; --  refclk.clk
		rst      : in  std_logic := '0'; --   reset.reset
		outclk_0 : out std_logic;        -- outclk0.clk
		outclk_1 : out std_logic;        -- outclk1.clk
		outclk_2 : out std_logic         -- outclk2.clk
	);
	end component;
	component sender_top is
		port (
		clk, reset : in std_logic;
		fifo_bitstream, fifo_empty : in std_logic;
		write, read_en : out std_logic;
		data_i, data_q : out std_logic_vector(13 downto 0)
		);
	end component;

			--COMPONENT cos_gen IS
			--	GENERIC (
			--		data_width : NATURAL := 14;
			--		pulse_width : NATURAL := 17;
			--		phase_width : NATURAL := 5
			--	);
			--	PORT (
			--		clk_i 	: std_logic;
			--		reset_i : std_logic;
			--		--phase_i : IN std_logic(phase_width - 1 DOWNTO 0);
			--		cos_o : OUT std_logic_vector(data_width - 1 DOWNTO 0)
			--	);
			--END COMPONENT;
			--COMPONENT sin_gen IS
			--	GENERIC (
			--		data_width : NATURAL := 14;
			--		pulse_width : NATURAL := 17;
			--		phase_width : NATURAL := 5
			--	);
			--	PORT (
			--		clk_i 	: std_logic;
			--		reset_i : std_logic;
			--		--phase_i : IN std_logic(phase_width - 1 DOWNTO 0);
			--		sin_o : OUT std_logic_vector(data_width - 1 DOWNTO 0)
			--	);
			--END COMPONENT;

	signal data_AD_a, data_AD_b, data_DA_a, data_DA_b : std_logic_vector(13 downto 0);
	signal pll_clk_125, pll_clk_125_skew, pll_clk_65, rst_inv : std_logic;
	signal test_i, test_q : std_logic_vector(13 downto 0);
	signal write : std_logic;
begin
	rst_inv <= not reset;
	pll_inst : component ip_pll
		port map (
			refclk  	=> clk, --  refclk.clk
			rst 		=> rst_inv, --   reset.reset
			outclk_0 => pll_clk_125,        -- outclk0.clk
			outclk_1 => pll_clk_125_skew,        -- outclk1.clk
			outclk_2 => pll_clk_65
			);
	sender_inst : component sender_top port map(
		clk, rst_inv, fifo_bitstream_in, fifo_empty, write, fifo_read_en, test_i, test_q
	);	
	--sin_inst : component sin_gen port map(
	--	clk, rst_inv, test_q
	--);
	--cos_inst : component cos_gen port map(
	--	clk, rst_inv, test_i
	--);

	--data_DA_a <= test_i;
	--data_DA_b <= test_q;

	data_AD_a <= GPIO_0(31) & GPIO_0(29) & GPIO_0(30) & GPIO_0(28) & GPIO_0(27) & GPIO_0(25) & GPIO_0(26) & GPIO_0(24) & GPIO_0(23) & GPIO_0(21) & GPIO_0(22) & GPIO_0(20) & GPIO_0(19) & GPIO_0(17) ;
					  
	data_AD_b <= GPIO_0(15) & GPIO_0(13) & GPIO_0(14) & GPIO_0(12) & GPIO_0(11) & GPIO_0(9) & GPIO_0(10) & GPIO_0(8) & GPIO_0(7) & GPIO_0(5) & GPIO_0(6) & GPIO_0(4) & GPIO_0(3) & GPIO_0(1);
					  
	GPIO_1 (19 ) <= test_q(13); 
	GPIO_1 (21 ) <= test_q(12);
	GPIO_1 (22 ) <= test_q(11);
	GPIO_1 (24 ) <= test_q(10);
	GPIO_1 (23 ) <= test_q(9); 
	GPIO_1 (25 ) <= test_q(8);
	GPIO_1 (27 ) <= test_q(7);
	GPIO_1 (29 ) <= test_q(6);
	GPIO_1 (26 ) <= test_q(5);
	GPIO_1 (28 ) <= test_q(4);
	GPIO_1 (31 ) <= test_q(3);
	GPIO_1 (33 ) <= test_q(2);
	GPIO_1 (30 ) <= test_q(1);
	GPIO_1 (32 ) <= test_q(0);
	--data_DA_b <= GPIO_1 (19 ) & GPIO_1 (21 ) & GPIO_1 (22 ) & GPIO_1 (24 ) & GPIO_1 (23 ) & GPIO_1 (25 ) & GPIO_1 (27 ) & GPIO_1 (29 ) & GPIO_1 (26 ) & GPIO_1 (28 ) & GPIO_1 (31 ) & GPIO_1 (33 ) & GPIO_1 (30 ) & GPIO_1 (32 );

	--data_DA_a <= GPIO_1 (1 ) & GPIO_1 (3 ) & GPIO_1 (4 ) & GPIO_1 (6 ) & GPIO_1 (5 ) & GPIO_1 (7 ) & GPIO_1 (8 ) & GPIO_1 (10 ) & GPIO_1 (9 ) & GPIO_1 (11 ) & GPIO_1 (12 ) & GPIO_1 (14 ) & GPIO_1 (13 ) & GPIO_1 (15 );

	GPIO_1 (1 ) <= test_i(13); 
	GPIO_1 (3 ) <= test_i(12); 
	GPIO_1 (4 ) <= test_i(11); 
	GPIO_1 (6 ) <= test_i(10); 
	GPIO_1 (5 ) <= test_i(9); 
	GPIO_1 (7 ) <= test_i(8); 
	GPIO_1 (8 ) <= test_i(7); 
	GPIO_1 (10 ) <= test_i(6); 
	GPIO_1 (9 ) <= test_i(5); 
	GPIO_1 (11 )<= test_i(4);
	GPIO_1 (12 ) <= test_i(3); 
	GPIO_1 (14 ) <= test_i(2); 
	GPIO_1 (13 ) <= test_i(1); 
	GPIO_1 (15 ) <= test_i(0);	

	GPIO_0(33) <= '0'; --Enable B
	GPIO_0(35) <= '0'; --Enable A

   GPIO_0(18) <= pll_clk_65; --PLL Clock to ADC_B
   GPIO_0(16) <= pll_clk_65; --PLL Clock to ADC_A


  GPIO_0(32) <= '1'; --POWER ON
  GPIO_1(35) <= '1'; --Mode Select. 1 = dual port &  0 = interleaved.

  GPIO_1(18) <= pll_clk_125; --PLL Clock to DAC_B
  GPIO_1(16) <= pll_clk_125; --PLL Clock to DAC_A
  --GPIO_1(18) <= clk; --PLL Clock to DAC_B
  --GPIO_1(16) <= clk; --PLL Clock to DAC_A

  GPIO_1(34) <= pll_clk_125_skew; --Input write signal for PORT B
  GPIO_1(17) <= pll_clk_125_skew; --Input write signal for PORT A
  --GPIO_1(34) <= clk; --Input write signal for PORT B
  --GPIO_1(17) <= clk; --Input write signal for PORT A
	
end loopback_arch;