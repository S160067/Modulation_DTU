	component soc_system is
		port (
			clk_clk                           : in    std_logic                     := 'X';             -- clk
			clk_1m_clk                        : out   std_logic;                                        -- clk
			ctrl_rx_reset_reset_n             : in    std_logic                     := 'X';             -- reset_n
			ctrl_rx_writeclk_clk              : in    std_logic                     := 'X';             -- clk
			ctrl_rx_writecsr_address          : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- address
			ctrl_rx_writecsr_read             : in    std_logic                     := 'X';             -- read
			ctrl_rx_writecsr_writedata        : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			ctrl_rx_writecsr_write            : in    std_logic                     := 'X';             -- write
			ctrl_rx_writecsr_readdata         : out   std_logic_vector(31 downto 0);                    -- readdata
			ctrl_rx_writedata_writedata       : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			ctrl_rx_writedata_write           : in    std_logic                     := 'X';             -- write
			ctrl_tx_readclk_clk               : in    std_logic                     := 'X';             -- clk
			ctrl_tx_readcsr_address           : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- address
			ctrl_tx_readcsr_read              : in    std_logic                     := 'X';             -- read
			ctrl_tx_readcsr_writedata         : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			ctrl_tx_readcsr_write             : in    std_logic                     := 'X';             -- write
			ctrl_tx_readcsr_readdata          : out   std_logic_vector(31 downto 0);                    -- readdata
			ctrl_tx_readdata_readdata         : out   std_logic_vector(7 downto 0);                     -- readdata
			ctrl_tx_readdata_read             : in    std_logic                     := 'X';             -- read
			ctrl_tx_reset_reset_n             : in    std_logic                     := 'X';             -- reset_n
			hps_0_ddr_mem_a                   : out   std_logic_vector(14 downto 0);                    -- mem_a
			hps_0_ddr_mem_ba                  : out   std_logic_vector(2 downto 0);                     -- mem_ba
			hps_0_ddr_mem_ck                  : out   std_logic;                                        -- mem_ck
			hps_0_ddr_mem_ck_n                : out   std_logic;                                        -- mem_ck_n
			hps_0_ddr_mem_cke                 : out   std_logic;                                        -- mem_cke
			hps_0_ddr_mem_cs_n                : out   std_logic;                                        -- mem_cs_n
			hps_0_ddr_mem_ras_n               : out   std_logic;                                        -- mem_ras_n
			hps_0_ddr_mem_cas_n               : out   std_logic;                                        -- mem_cas_n
			hps_0_ddr_mem_we_n                : out   std_logic;                                        -- mem_we_n
			hps_0_ddr_mem_reset_n             : out   std_logic;                                        -- mem_reset_n
			hps_0_ddr_mem_dq                  : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			hps_0_ddr_mem_dqs                 : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			hps_0_ddr_mem_dqs_n               : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			hps_0_ddr_mem_odt                 : out   std_logic;                                        -- mem_odt
			hps_0_ddr_mem_dm                  : out   std_logic_vector(3 downto 0);                     -- mem_dm
			hps_0_ddr_oct_rzqin               : in    std_logic                     := 'X';             -- oct_rzqin
			hps_0_io_hps_io_emac1_inst_TX_CLK : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
			hps_0_io_hps_io_emac1_inst_TXD0   : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
			hps_0_io_hps_io_emac1_inst_TXD1   : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
			hps_0_io_hps_io_emac1_inst_TXD2   : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
			hps_0_io_hps_io_emac1_inst_TXD3   : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
			hps_0_io_hps_io_emac1_inst_RXD0   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
			hps_0_io_hps_io_emac1_inst_MDIO   : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
			hps_0_io_hps_io_emac1_inst_MDC    : out   std_logic;                                        -- hps_io_emac1_inst_MDC
			hps_0_io_hps_io_emac1_inst_RX_CTL : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
			hps_0_io_hps_io_emac1_inst_TX_CTL : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
			hps_0_io_hps_io_emac1_inst_RX_CLK : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
			hps_0_io_hps_io_emac1_inst_RXD1   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
			hps_0_io_hps_io_emac1_inst_RXD2   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
			hps_0_io_hps_io_emac1_inst_RXD3   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
			hps_0_io_hps_io_qspi_inst_IO0     : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO0
			hps_0_io_hps_io_qspi_inst_IO1     : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO1
			hps_0_io_hps_io_qspi_inst_IO2     : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO2
			hps_0_io_hps_io_qspi_inst_IO3     : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO3
			hps_0_io_hps_io_qspi_inst_SS0     : out   std_logic;                                        -- hps_io_qspi_inst_SS0
			hps_0_io_hps_io_qspi_inst_CLK     : out   std_logic;                                        -- hps_io_qspi_inst_CLK
			hps_0_io_hps_io_sdio_inst_CMD     : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
			hps_0_io_hps_io_sdio_inst_D0      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
			hps_0_io_hps_io_sdio_inst_D1      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
			hps_0_io_hps_io_sdio_inst_CLK     : out   std_logic;                                        -- hps_io_sdio_inst_CLK
			hps_0_io_hps_io_sdio_inst_D2      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
			hps_0_io_hps_io_sdio_inst_D3      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
			hps_0_io_hps_io_usb1_inst_D0      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
			hps_0_io_hps_io_usb1_inst_D1      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
			hps_0_io_hps_io_usb1_inst_D2      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
			hps_0_io_hps_io_usb1_inst_D3      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
			hps_0_io_hps_io_usb1_inst_D4      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
			hps_0_io_hps_io_usb1_inst_D5      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
			hps_0_io_hps_io_usb1_inst_D6      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
			hps_0_io_hps_io_usb1_inst_D7      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
			hps_0_io_hps_io_usb1_inst_CLK     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
			hps_0_io_hps_io_usb1_inst_STP     : out   std_logic;                                        -- hps_io_usb1_inst_STP
			hps_0_io_hps_io_usb1_inst_DIR     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
			hps_0_io_hps_io_usb1_inst_NXT     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
			hps_0_io_hps_io_spim1_inst_CLK    : out   std_logic;                                        -- hps_io_spim1_inst_CLK
			hps_0_io_hps_io_spim1_inst_MOSI   : out   std_logic;                                        -- hps_io_spim1_inst_MOSI
			hps_0_io_hps_io_spim1_inst_MISO   : in    std_logic                     := 'X';             -- hps_io_spim1_inst_MISO
			hps_0_io_hps_io_spim1_inst_SS0    : out   std_logic;                                        -- hps_io_spim1_inst_SS0
			hps_0_io_hps_io_uart0_inst_RX     : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
			hps_0_io_hps_io_uart0_inst_TX     : out   std_logic;                                        -- hps_io_uart0_inst_TX
			hps_0_io_hps_io_i2c0_inst_SDA     : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SDA
			hps_0_io_hps_io_i2c0_inst_SCL     : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SCL
			hps_0_io_hps_io_i2c1_inst_SDA     : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SDA
			hps_0_io_hps_io_i2c1_inst_SCL     : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SCL
			hps_0_io_hps_io_gpio_inst_GPIO09  : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO09
			hps_0_io_hps_io_gpio_inst_GPIO35  : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO35
			hps_0_io_hps_io_gpio_inst_GPIO40  : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO40
			hps_0_io_hps_io_gpio_inst_GPIO48  : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO48
			hps_0_io_hps_io_gpio_inst_GPIO53  : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO53
			hps_0_io_hps_io_gpio_inst_GPIO54  : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO54
			hps_0_io_hps_io_gpio_inst_GPIO61  : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO61
			reset_reset_n                     : in    std_logic                     := 'X';             -- reset_n
			rx_video_reset_reset_n            : in    std_logic                     := 'X';             -- reset_n
			rx_video_writeclk_clk             : in    std_logic                     := 'X';             -- clk
			rx_video_writecsr_address         : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- address
			rx_video_writecsr_read            : in    std_logic                     := 'X';             -- read
			rx_video_writecsr_writedata       : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			rx_video_writecsr_write           : in    std_logic                     := 'X';             -- write
			rx_video_writecsr_readdata        : out   std_logic_vector(31 downto 0);                    -- readdata
			rx_video_writedata_writedata      : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- writedata
			rx_video_writedata_write          : in    std_logic                     := 'X';             -- write
			tx_video_readclk_clk              : in    std_logic                     := 'X';             -- clk
			tx_video_readcsr_address          : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- address
			tx_video_readcsr_read             : in    std_logic                     := 'X';             -- read
			tx_video_readcsr_writedata        : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			tx_video_readcsr_write            : in    std_logic                     := 'X';             -- write
			tx_video_readcsr_readdata         : out   std_logic_vector(31 downto 0);                    -- readdata
			tx_video_readdata_readdata        : out   std_logic_vector(7 downto 0);                     -- readdata
			tx_video_readdata_read            : in    std_logic                     := 'X';             -- read
			tx_video_reset_reset_n            : in    std_logic                     := 'X';             -- reset_n
			leds_out_export                   : out   std_logic_vector(9 downto 0);                     -- export
			switches_in_export                : in    std_logic_vector(9 downto 0)  := (others => 'X')  -- export
		);
	end component soc_system;

	u0 : component soc_system
		port map (
			clk_clk                           => CONNECTED_TO_clk_clk,                           --                clk.clk
			clk_1m_clk                        => CONNECTED_TO_clk_1m_clk,                        --             clk_1m.clk
			ctrl_rx_reset_reset_n             => CONNECTED_TO_ctrl_rx_reset_reset_n,             --      ctrl_rx_reset.reset_n
			ctrl_rx_writeclk_clk              => CONNECTED_TO_ctrl_rx_writeclk_clk,              --   ctrl_rx_writeclk.clk
			ctrl_rx_writecsr_address          => CONNECTED_TO_ctrl_rx_writecsr_address,          --   ctrl_rx_writecsr.address
			ctrl_rx_writecsr_read             => CONNECTED_TO_ctrl_rx_writecsr_read,             --                   .read
			ctrl_rx_writecsr_writedata        => CONNECTED_TO_ctrl_rx_writecsr_writedata,        --                   .writedata
			ctrl_rx_writecsr_write            => CONNECTED_TO_ctrl_rx_writecsr_write,            --                   .write
			ctrl_rx_writecsr_readdata         => CONNECTED_TO_ctrl_rx_writecsr_readdata,         --                   .readdata
			ctrl_rx_writedata_writedata       => CONNECTED_TO_ctrl_rx_writedata_writedata,       --  ctrl_rx_writedata.writedata
			ctrl_rx_writedata_write           => CONNECTED_TO_ctrl_rx_writedata_write,           --                   .write
			ctrl_tx_readclk_clk               => CONNECTED_TO_ctrl_tx_readclk_clk,               --    ctrl_tx_readclk.clk
			ctrl_tx_readcsr_address           => CONNECTED_TO_ctrl_tx_readcsr_address,           --    ctrl_tx_readcsr.address
			ctrl_tx_readcsr_read              => CONNECTED_TO_ctrl_tx_readcsr_read,              --                   .read
			ctrl_tx_readcsr_writedata         => CONNECTED_TO_ctrl_tx_readcsr_writedata,         --                   .writedata
			ctrl_tx_readcsr_write             => CONNECTED_TO_ctrl_tx_readcsr_write,             --                   .write
			ctrl_tx_readcsr_readdata          => CONNECTED_TO_ctrl_tx_readcsr_readdata,          --                   .readdata
			ctrl_tx_readdata_readdata         => CONNECTED_TO_ctrl_tx_readdata_readdata,         --   ctrl_tx_readdata.readdata
			ctrl_tx_readdata_read             => CONNECTED_TO_ctrl_tx_readdata_read,             --                   .read
			ctrl_tx_reset_reset_n             => CONNECTED_TO_ctrl_tx_reset_reset_n,             --      ctrl_tx_reset.reset_n
			hps_0_ddr_mem_a                   => CONNECTED_TO_hps_0_ddr_mem_a,                   --          hps_0_ddr.mem_a
			hps_0_ddr_mem_ba                  => CONNECTED_TO_hps_0_ddr_mem_ba,                  --                   .mem_ba
			hps_0_ddr_mem_ck                  => CONNECTED_TO_hps_0_ddr_mem_ck,                  --                   .mem_ck
			hps_0_ddr_mem_ck_n                => CONNECTED_TO_hps_0_ddr_mem_ck_n,                --                   .mem_ck_n
			hps_0_ddr_mem_cke                 => CONNECTED_TO_hps_0_ddr_mem_cke,                 --                   .mem_cke
			hps_0_ddr_mem_cs_n                => CONNECTED_TO_hps_0_ddr_mem_cs_n,                --                   .mem_cs_n
			hps_0_ddr_mem_ras_n               => CONNECTED_TO_hps_0_ddr_mem_ras_n,               --                   .mem_ras_n
			hps_0_ddr_mem_cas_n               => CONNECTED_TO_hps_0_ddr_mem_cas_n,               --                   .mem_cas_n
			hps_0_ddr_mem_we_n                => CONNECTED_TO_hps_0_ddr_mem_we_n,                --                   .mem_we_n
			hps_0_ddr_mem_reset_n             => CONNECTED_TO_hps_0_ddr_mem_reset_n,             --                   .mem_reset_n
			hps_0_ddr_mem_dq                  => CONNECTED_TO_hps_0_ddr_mem_dq,                  --                   .mem_dq
			hps_0_ddr_mem_dqs                 => CONNECTED_TO_hps_0_ddr_mem_dqs,                 --                   .mem_dqs
			hps_0_ddr_mem_dqs_n               => CONNECTED_TO_hps_0_ddr_mem_dqs_n,               --                   .mem_dqs_n
			hps_0_ddr_mem_odt                 => CONNECTED_TO_hps_0_ddr_mem_odt,                 --                   .mem_odt
			hps_0_ddr_mem_dm                  => CONNECTED_TO_hps_0_ddr_mem_dm,                  --                   .mem_dm
			hps_0_ddr_oct_rzqin               => CONNECTED_TO_hps_0_ddr_oct_rzqin,               --                   .oct_rzqin
			hps_0_io_hps_io_emac1_inst_TX_CLK => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_TX_CLK, --           hps_0_io.hps_io_emac1_inst_TX_CLK
			hps_0_io_hps_io_emac1_inst_TXD0   => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_TXD0,   --                   .hps_io_emac1_inst_TXD0
			hps_0_io_hps_io_emac1_inst_TXD1   => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_TXD1,   --                   .hps_io_emac1_inst_TXD1
			hps_0_io_hps_io_emac1_inst_TXD2   => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_TXD2,   --                   .hps_io_emac1_inst_TXD2
			hps_0_io_hps_io_emac1_inst_TXD3   => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_TXD3,   --                   .hps_io_emac1_inst_TXD3
			hps_0_io_hps_io_emac1_inst_RXD0   => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_RXD0,   --                   .hps_io_emac1_inst_RXD0
			hps_0_io_hps_io_emac1_inst_MDIO   => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_MDIO,   --                   .hps_io_emac1_inst_MDIO
			hps_0_io_hps_io_emac1_inst_MDC    => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_MDC,    --                   .hps_io_emac1_inst_MDC
			hps_0_io_hps_io_emac1_inst_RX_CTL => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_RX_CTL, --                   .hps_io_emac1_inst_RX_CTL
			hps_0_io_hps_io_emac1_inst_TX_CTL => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_TX_CTL, --                   .hps_io_emac1_inst_TX_CTL
			hps_0_io_hps_io_emac1_inst_RX_CLK => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_RX_CLK, --                   .hps_io_emac1_inst_RX_CLK
			hps_0_io_hps_io_emac1_inst_RXD1   => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_RXD1,   --                   .hps_io_emac1_inst_RXD1
			hps_0_io_hps_io_emac1_inst_RXD2   => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_RXD2,   --                   .hps_io_emac1_inst_RXD2
			hps_0_io_hps_io_emac1_inst_RXD3   => CONNECTED_TO_hps_0_io_hps_io_emac1_inst_RXD3,   --                   .hps_io_emac1_inst_RXD3
			hps_0_io_hps_io_qspi_inst_IO0     => CONNECTED_TO_hps_0_io_hps_io_qspi_inst_IO0,     --                   .hps_io_qspi_inst_IO0
			hps_0_io_hps_io_qspi_inst_IO1     => CONNECTED_TO_hps_0_io_hps_io_qspi_inst_IO1,     --                   .hps_io_qspi_inst_IO1
			hps_0_io_hps_io_qspi_inst_IO2     => CONNECTED_TO_hps_0_io_hps_io_qspi_inst_IO2,     --                   .hps_io_qspi_inst_IO2
			hps_0_io_hps_io_qspi_inst_IO3     => CONNECTED_TO_hps_0_io_hps_io_qspi_inst_IO3,     --                   .hps_io_qspi_inst_IO3
			hps_0_io_hps_io_qspi_inst_SS0     => CONNECTED_TO_hps_0_io_hps_io_qspi_inst_SS0,     --                   .hps_io_qspi_inst_SS0
			hps_0_io_hps_io_qspi_inst_CLK     => CONNECTED_TO_hps_0_io_hps_io_qspi_inst_CLK,     --                   .hps_io_qspi_inst_CLK
			hps_0_io_hps_io_sdio_inst_CMD     => CONNECTED_TO_hps_0_io_hps_io_sdio_inst_CMD,     --                   .hps_io_sdio_inst_CMD
			hps_0_io_hps_io_sdio_inst_D0      => CONNECTED_TO_hps_0_io_hps_io_sdio_inst_D0,      --                   .hps_io_sdio_inst_D0
			hps_0_io_hps_io_sdio_inst_D1      => CONNECTED_TO_hps_0_io_hps_io_sdio_inst_D1,      --                   .hps_io_sdio_inst_D1
			hps_0_io_hps_io_sdio_inst_CLK     => CONNECTED_TO_hps_0_io_hps_io_sdio_inst_CLK,     --                   .hps_io_sdio_inst_CLK
			hps_0_io_hps_io_sdio_inst_D2      => CONNECTED_TO_hps_0_io_hps_io_sdio_inst_D2,      --                   .hps_io_sdio_inst_D2
			hps_0_io_hps_io_sdio_inst_D3      => CONNECTED_TO_hps_0_io_hps_io_sdio_inst_D3,      --                   .hps_io_sdio_inst_D3
			hps_0_io_hps_io_usb1_inst_D0      => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_D0,      --                   .hps_io_usb1_inst_D0
			hps_0_io_hps_io_usb1_inst_D1      => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_D1,      --                   .hps_io_usb1_inst_D1
			hps_0_io_hps_io_usb1_inst_D2      => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_D2,      --                   .hps_io_usb1_inst_D2
			hps_0_io_hps_io_usb1_inst_D3      => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_D3,      --                   .hps_io_usb1_inst_D3
			hps_0_io_hps_io_usb1_inst_D4      => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_D4,      --                   .hps_io_usb1_inst_D4
			hps_0_io_hps_io_usb1_inst_D5      => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_D5,      --                   .hps_io_usb1_inst_D5
			hps_0_io_hps_io_usb1_inst_D6      => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_D6,      --                   .hps_io_usb1_inst_D6
			hps_0_io_hps_io_usb1_inst_D7      => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_D7,      --                   .hps_io_usb1_inst_D7
			hps_0_io_hps_io_usb1_inst_CLK     => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_CLK,     --                   .hps_io_usb1_inst_CLK
			hps_0_io_hps_io_usb1_inst_STP     => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_STP,     --                   .hps_io_usb1_inst_STP
			hps_0_io_hps_io_usb1_inst_DIR     => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_DIR,     --                   .hps_io_usb1_inst_DIR
			hps_0_io_hps_io_usb1_inst_NXT     => CONNECTED_TO_hps_0_io_hps_io_usb1_inst_NXT,     --                   .hps_io_usb1_inst_NXT
			hps_0_io_hps_io_spim1_inst_CLK    => CONNECTED_TO_hps_0_io_hps_io_spim1_inst_CLK,    --                   .hps_io_spim1_inst_CLK
			hps_0_io_hps_io_spim1_inst_MOSI   => CONNECTED_TO_hps_0_io_hps_io_spim1_inst_MOSI,   --                   .hps_io_spim1_inst_MOSI
			hps_0_io_hps_io_spim1_inst_MISO   => CONNECTED_TO_hps_0_io_hps_io_spim1_inst_MISO,   --                   .hps_io_spim1_inst_MISO
			hps_0_io_hps_io_spim1_inst_SS0    => CONNECTED_TO_hps_0_io_hps_io_spim1_inst_SS0,    --                   .hps_io_spim1_inst_SS0
			hps_0_io_hps_io_uart0_inst_RX     => CONNECTED_TO_hps_0_io_hps_io_uart0_inst_RX,     --                   .hps_io_uart0_inst_RX
			hps_0_io_hps_io_uart0_inst_TX     => CONNECTED_TO_hps_0_io_hps_io_uart0_inst_TX,     --                   .hps_io_uart0_inst_TX
			hps_0_io_hps_io_i2c0_inst_SDA     => CONNECTED_TO_hps_0_io_hps_io_i2c0_inst_SDA,     --                   .hps_io_i2c0_inst_SDA
			hps_0_io_hps_io_i2c0_inst_SCL     => CONNECTED_TO_hps_0_io_hps_io_i2c0_inst_SCL,     --                   .hps_io_i2c0_inst_SCL
			hps_0_io_hps_io_i2c1_inst_SDA     => CONNECTED_TO_hps_0_io_hps_io_i2c1_inst_SDA,     --                   .hps_io_i2c1_inst_SDA
			hps_0_io_hps_io_i2c1_inst_SCL     => CONNECTED_TO_hps_0_io_hps_io_i2c1_inst_SCL,     --                   .hps_io_i2c1_inst_SCL
			hps_0_io_hps_io_gpio_inst_GPIO09  => CONNECTED_TO_hps_0_io_hps_io_gpio_inst_GPIO09,  --                   .hps_io_gpio_inst_GPIO09
			hps_0_io_hps_io_gpio_inst_GPIO35  => CONNECTED_TO_hps_0_io_hps_io_gpio_inst_GPIO35,  --                   .hps_io_gpio_inst_GPIO35
			hps_0_io_hps_io_gpio_inst_GPIO40  => CONNECTED_TO_hps_0_io_hps_io_gpio_inst_GPIO40,  --                   .hps_io_gpio_inst_GPIO40
			hps_0_io_hps_io_gpio_inst_GPIO48  => CONNECTED_TO_hps_0_io_hps_io_gpio_inst_GPIO48,  --                   .hps_io_gpio_inst_GPIO48
			hps_0_io_hps_io_gpio_inst_GPIO53  => CONNECTED_TO_hps_0_io_hps_io_gpio_inst_GPIO53,  --                   .hps_io_gpio_inst_GPIO53
			hps_0_io_hps_io_gpio_inst_GPIO54  => CONNECTED_TO_hps_0_io_hps_io_gpio_inst_GPIO54,  --                   .hps_io_gpio_inst_GPIO54
			hps_0_io_hps_io_gpio_inst_GPIO61  => CONNECTED_TO_hps_0_io_hps_io_gpio_inst_GPIO61,  --                   .hps_io_gpio_inst_GPIO61
			reset_reset_n                     => CONNECTED_TO_reset_reset_n,                     --              reset.reset_n
			rx_video_reset_reset_n            => CONNECTED_TO_rx_video_reset_reset_n,            --     rx_video_reset.reset_n
			rx_video_writeclk_clk             => CONNECTED_TO_rx_video_writeclk_clk,             --  rx_video_writeclk.clk
			rx_video_writecsr_address         => CONNECTED_TO_rx_video_writecsr_address,         --  rx_video_writecsr.address
			rx_video_writecsr_read            => CONNECTED_TO_rx_video_writecsr_read,            --                   .read
			rx_video_writecsr_writedata       => CONNECTED_TO_rx_video_writecsr_writedata,       --                   .writedata
			rx_video_writecsr_write           => CONNECTED_TO_rx_video_writecsr_write,           --                   .write
			rx_video_writecsr_readdata        => CONNECTED_TO_rx_video_writecsr_readdata,        --                   .readdata
			rx_video_writedata_writedata      => CONNECTED_TO_rx_video_writedata_writedata,      -- rx_video_writedata.writedata
			rx_video_writedata_write          => CONNECTED_TO_rx_video_writedata_write,          --                   .write
			tx_video_readclk_clk              => CONNECTED_TO_tx_video_readclk_clk,              --   tx_video_readclk.clk
			tx_video_readcsr_address          => CONNECTED_TO_tx_video_readcsr_address,          --   tx_video_readcsr.address
			tx_video_readcsr_read             => CONNECTED_TO_tx_video_readcsr_read,             --                   .read
			tx_video_readcsr_writedata        => CONNECTED_TO_tx_video_readcsr_writedata,        --                   .writedata
			tx_video_readcsr_write            => CONNECTED_TO_tx_video_readcsr_write,            --                   .write
			tx_video_readcsr_readdata         => CONNECTED_TO_tx_video_readcsr_readdata,         --                   .readdata
			tx_video_readdata_readdata        => CONNECTED_TO_tx_video_readdata_readdata,        --  tx_video_readdata.readdata
			tx_video_readdata_read            => CONNECTED_TO_tx_video_readdata_read,            --                   .read
			tx_video_reset_reset_n            => CONNECTED_TO_tx_video_reset_reset_n,            --     tx_video_reset.reset_n
			leds_out_export                   => CONNECTED_TO_leds_out_export,                   --           leds_out.export
			switches_in_export                => CONNECTED_TO_switches_in_export                 --        switches_in.export
		);

