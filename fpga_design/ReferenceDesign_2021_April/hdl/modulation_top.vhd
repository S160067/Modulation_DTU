library ieee;
use ieee.std_logic_1164.all;

entity modulation_top is
port (
	clk, reset			: in std_logic;
	
	-- Data interface from framing and encryption
	framing_tx_data 	: in std_logic_vector(7 downto 0);
	framing_rx_data   : out std_logic_vector(7 downto 0);
	
	-- Datout to GPIO
	GPIO_0 : inout std_logic_vector(35 downto 0);
	GPIO_1 : inout std_logic_vector(35 downto 0);
	status_modulation_data 		: out std_logic_vector(23 downto 0) := x"000000";
	status_modulation_wrreq		: out std_logic := '0';
	status_modulation_full			: in std_logic;
	SW : in std_logic_vector(9 downto 0);
   LEDR : out std_logic_vector(9 downto 0);
	KEY_N : in std_logic_vector(3 downto 0)
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
	signal q,d : std_logic_vector(9 downto 0);
	signal en : std_logic;
	signal pll_clk, pll_clk_skew : std_logic;
	
	TYPE STATE_TYPE IS (s0, s1);
   SIGNAL state,next_state : STATE_TYPE;
begin
	
	pll_inst : component ip_pll
		port map (
			refclk  	=> clk, --  refclk.clk
			rst 		=> reset, --   reset.reset
			outclk_0 => pll_clk,        -- outclk0.clk
			outclk_1 => pll_clk_skew        -- outclk1.clk
			);

	data_out_a <= GPIO_0(31) & GPIO_0(29) & GPIO_0(30) & GPIO_0(28) & GPIO_0(27) & GPIO_0(25) & 
						GPIO_0(26) & GPIO_0(24) & GPIO_0(23) & GPIO_0(21) & GPIO_0(22) & GPIO_0(20) & 
						GPIO_0(19) & GPIO_0(17) ;
					  
	data_out_b <= GPIO_0(15) & GPIO_0(3) & GPIO_0(14) & GPIO_0(12) & GPIO_0(11) & GPIO_0(9) & GPIO_0(10) & 
					  GPIO_0(8) & GPIO_0(7) & GPIO_0(5) & GPIO_0(6) & GPIO_0(4) & GPIO_0(3) & GPIO_0(1);
					  
	
	data_in_b <= GPIO_1 (19 ) & GPIO_1 (21 ) & GPIO_1 (22 ) & GPIO_1 (24 ) & GPIO_1 (23 ) & GPIO_1 (25 ) & 
						GPIO_1 (27 ) & GPIO_1 (29 ) & GPIO_1 (26 ) & GPIO_1 (28 ) & GPIO_1 (31 ) & GPIO_1 (33 ) & 
						GPIO_1 (30 ) & GPIO_1 (32 );

	data_in_a <= GPIO_1 (1 ) & GPIO_1 (3 ) & GPIO_1 (4 ) & GPIO_1 (6 ) & GPIO_1 (5 ) & GPIO_1 (7 ) & 
						GPIO_1 (8 ) & GPIO_1 (10 ) & GPIO_1 (9 ) & GPIO_1 (11 ) & GPIO_1 (12 ) & GPIO_1 (14 ) & 
						GPIO_1 (13 ) & GPIO_1 (15 );

	d <= data_out_b(9 downto 0);
	LEDR <= q;

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
  
  -- FSM process
   PROCESS (state,next_state)
   BEGIN
      CASE state IS
         WHEN s0 =>
				next_state <= s1;	
				data_in_b <= "11100000110011";
				data_in_a <= "11100000110011";
         WHEN s1 =>
				next_state <= s0;
				data_in_b <= "00111110001100";
				data_in_a <= "00111110001100";
			END CASE;
   END PROCESS;
  
  -- Register with active-high clock & asynchronous clear
   en <= KEY_N(1);
   PROCESS (clk, en,reset)                      
   BEGIN
			IF reset = '0' THEN
				-- Reset
				q <= ( others => '0');
				next_state <= s0;
			ELSIF clk'EVENT AND clk = '1' THEN
				state <= next_state;
			IF en = '0' THEN    
					-- enable and clock
					q <= d;
					
				END IF;
			END IF;
		 
   END PROCESS;
	
end loopback_arch;