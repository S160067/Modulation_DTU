library ieee;
use ieee.std_logic_1164.all;

entity DE1_SoC_ReferenceTop is
    port(
        -- ADC
     -- ADC_CS_n         : out   std_logic;
     -- ADC_DIN          : out   std_logic;
     -- ADC_DOUT         : in    std_logic;
     -- ADC_SCLK         : out   std_logic;

        -- Audio
     -- AUD_ADCDAT       : in    std_logic;
     -- AUD_ADCLRCK      : inout std_logic;
     -- AUD_BCLK         : inout std_logic;
     -- AUD_DACDAT       : out   std_logic;
     -- AUD_DACLRCK      : inout std_logic;
     -- AUD_XCK          : out   std_logic;

        -- CLOCK
        CLOCK_50 : in std_logic;
     -- CLOCK2_50        : in    std_logic;
     -- CLOCK3_50        : in    std_logic;
     -- CLOCK4_50        : in    std_logic;

        -- SDRAM
        DRAM_ADDR  : out   std_logic_vector(12 downto 0);
        DRAM_BA    : out   std_logic_vector(1 downto 0);
        DRAM_CAS_N : out   std_logic;
        DRAM_CKE   : out   std_logic;
        DRAM_CLK   : out   std_logic;
        DRAM_CS_N  : out   std_logic;
        DRAM_DQ    : inout std_logic_vector(15 downto 0);
        DRAM_LDQM  : out   std_logic;
        DRAM_RAS_N : out   std_logic;
        DRAM_UDQM  : out   std_logic;
        DRAM_WE_N  : out   std_logic;

        -- SEG7
   --   HEX0_N           : out   std_logic_vector(6 downto 0);
    --  HEX1_N           : out   std_logic_vector(6 downto 0);
     -- HEX2_N           : out   std_logic_vector(6 downto 0);
--      HEX3_N           : out   std_logic_vector(6 downto 0);
 ---     HEX4_N           : out   std_logic_vector(6 downto 0);
  --    HEX5_N           : out   std_logic_vector(6 downto 0);

        -- IR
     -- IRDA_RXD         : in    std_logic;
     -- IRDA_TXD         : out   std_logic;

        -- KEY_N
        KEY_N : in std_logic_vector(3 downto 0);

        -- LED
        LEDR : out std_logic_vector(9 downto 0);

        -- SW
      SW : in std_logic_vector(9 downto 0);


        -- GPIO_0
		  GPIO_0           : inout std_logic_vector(35 downto 0);

        -- GPIO_1
        GPIO_1           : inout std_logic_vector(35 downto 0)
    );
end entity DE1_SoC_ReferenceTop;



architecture reference_arch of DE1_SoC_ReferenceTop is
	
	component fpga_top is
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
		
				-- loopback tx
		GPIO_0				: inout std_logic_vector(35 downto 0);
		GPIO_1				: inout std_logic_vector(35 downto 0)
		);
	end component fpga_top;
	
		
		
signal ctrl_tx_data: std_logic_vector(7 downto 0);
signal ctrl_rx_data: std_logic_vector(31 downto 0);			
signal tx_video_data, rx_video_data			: std_logic_vector(7 downto 0);
signal tx_video_flags, rx_video_flags, ctrl_tx_flags, ctrl_rx_flags 	: std_logic_vector(31 downto 0);
signal tx_video_rdreq, ctrl_tx_rdreq 		: std_logic;
signal rx_video_wrreq, ctrl_rx_wrreq 		: std_logic;
signal CLOCK_1 : std_logic;

begin

	--LEDR <= "1010101010";
	 
	fpga_top_inst : component fpga_top
	port map (
		clk						=> CLOCK_1,
		reset						=> KEY_N(0),
		
		-- tx video
		tx_video_data 			=> tx_video_data,
		tx_video_rdreq			=> tx_video_rdreq,
		tx_video_empty			=> tx_video_flags(1),
		
		-- tx video
		rx_video_data 			=> rx_video_data,
		rx_video_wrreq			=> rx_video_wrreq,
		rx_video_full			=> rx_video_flags(0),

		
		
		-- ctrl tx
		ctrl_tx_data 			=> ctrl_tx_data,
		ctrl_tx_rdreq			=> ctrl_tx_rdreq,
		ctrl_tx_empty			=> ctrl_tx_flags(1),
		
		-- ctrl tx
		ctrl_rx_data 			=> ctrl_rx_data,
		ctrl_rx_wrreq			=> ctrl_rx_wrreq,
		ctrl_rx_full			=> ctrl_rx_flags(0),
		
		-- GPIO Interface to DA AD board
		GPIO_0					=> GPIO_0,
		GPIO_1					=> GPIO_1
		
	);
	

	
end;