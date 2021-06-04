
module soc_system (
	clk_clk,
	clk_1m_clk,
	ctrl_rx_reset_reset_n,
	ctrl_rx_writeclk_clk,
	ctrl_rx_writecsr_address,
	ctrl_rx_writecsr_read,
	ctrl_rx_writecsr_writedata,
	ctrl_rx_writecsr_write,
	ctrl_rx_writecsr_readdata,
	ctrl_rx_writedata_writedata,
	ctrl_rx_writedata_write,
	ctrl_tx_readclk_clk,
	ctrl_tx_readcsr_address,
	ctrl_tx_readcsr_read,
	ctrl_tx_readcsr_writedata,
	ctrl_tx_readcsr_write,
	ctrl_tx_readcsr_readdata,
	ctrl_tx_readdata_readdata,
	ctrl_tx_readdata_read,
	ctrl_tx_reset_reset_n,
	hps_0_ddr_mem_a,
	hps_0_ddr_mem_ba,
	hps_0_ddr_mem_ck,
	hps_0_ddr_mem_ck_n,
	hps_0_ddr_mem_cke,
	hps_0_ddr_mem_cs_n,
	hps_0_ddr_mem_ras_n,
	hps_0_ddr_mem_cas_n,
	hps_0_ddr_mem_we_n,
	hps_0_ddr_mem_reset_n,
	hps_0_ddr_mem_dq,
	hps_0_ddr_mem_dqs,
	hps_0_ddr_mem_dqs_n,
	hps_0_ddr_mem_odt,
	hps_0_ddr_mem_dm,
	hps_0_ddr_oct_rzqin,
	hps_0_io_hps_io_emac1_inst_TX_CLK,
	hps_0_io_hps_io_emac1_inst_TXD0,
	hps_0_io_hps_io_emac1_inst_TXD1,
	hps_0_io_hps_io_emac1_inst_TXD2,
	hps_0_io_hps_io_emac1_inst_TXD3,
	hps_0_io_hps_io_emac1_inst_RXD0,
	hps_0_io_hps_io_emac1_inst_MDIO,
	hps_0_io_hps_io_emac1_inst_MDC,
	hps_0_io_hps_io_emac1_inst_RX_CTL,
	hps_0_io_hps_io_emac1_inst_TX_CTL,
	hps_0_io_hps_io_emac1_inst_RX_CLK,
	hps_0_io_hps_io_emac1_inst_RXD1,
	hps_0_io_hps_io_emac1_inst_RXD2,
	hps_0_io_hps_io_emac1_inst_RXD3,
	hps_0_io_hps_io_qspi_inst_IO0,
	hps_0_io_hps_io_qspi_inst_IO1,
	hps_0_io_hps_io_qspi_inst_IO2,
	hps_0_io_hps_io_qspi_inst_IO3,
	hps_0_io_hps_io_qspi_inst_SS0,
	hps_0_io_hps_io_qspi_inst_CLK,
	hps_0_io_hps_io_sdio_inst_CMD,
	hps_0_io_hps_io_sdio_inst_D0,
	hps_0_io_hps_io_sdio_inst_D1,
	hps_0_io_hps_io_sdio_inst_CLK,
	hps_0_io_hps_io_sdio_inst_D2,
	hps_0_io_hps_io_sdio_inst_D3,
	hps_0_io_hps_io_usb1_inst_D0,
	hps_0_io_hps_io_usb1_inst_D1,
	hps_0_io_hps_io_usb1_inst_D2,
	hps_0_io_hps_io_usb1_inst_D3,
	hps_0_io_hps_io_usb1_inst_D4,
	hps_0_io_hps_io_usb1_inst_D5,
	hps_0_io_hps_io_usb1_inst_D6,
	hps_0_io_hps_io_usb1_inst_D7,
	hps_0_io_hps_io_usb1_inst_CLK,
	hps_0_io_hps_io_usb1_inst_STP,
	hps_0_io_hps_io_usb1_inst_DIR,
	hps_0_io_hps_io_usb1_inst_NXT,
	hps_0_io_hps_io_spim1_inst_CLK,
	hps_0_io_hps_io_spim1_inst_MOSI,
	hps_0_io_hps_io_spim1_inst_MISO,
	hps_0_io_hps_io_spim1_inst_SS0,
	hps_0_io_hps_io_uart0_inst_RX,
	hps_0_io_hps_io_uart0_inst_TX,
	hps_0_io_hps_io_i2c0_inst_SDA,
	hps_0_io_hps_io_i2c0_inst_SCL,
	hps_0_io_hps_io_i2c1_inst_SDA,
	hps_0_io_hps_io_i2c1_inst_SCL,
	hps_0_io_hps_io_gpio_inst_GPIO09,
	hps_0_io_hps_io_gpio_inst_GPIO35,
	hps_0_io_hps_io_gpio_inst_GPIO40,
	hps_0_io_hps_io_gpio_inst_GPIO48,
	hps_0_io_hps_io_gpio_inst_GPIO53,
	hps_0_io_hps_io_gpio_inst_GPIO54,
	hps_0_io_hps_io_gpio_inst_GPIO61,
	reset_reset_n,
	rx_video_reset_reset_n,
	rx_video_writeclk_clk,
	rx_video_writecsr_address,
	rx_video_writecsr_read,
	rx_video_writecsr_writedata,
	rx_video_writecsr_write,
	rx_video_writecsr_readdata,
	rx_video_writedata_writedata,
	rx_video_writedata_write,
	tx_video_readclk_clk,
	tx_video_readcsr_address,
	tx_video_readcsr_read,
	tx_video_readcsr_writedata,
	tx_video_readcsr_write,
	tx_video_readcsr_readdata,
	tx_video_readdata_readdata,
	tx_video_readdata_read,
	tx_video_reset_reset_n,
	leds_out_export,
	switches_in_export);	

	input		clk_clk;
	output		clk_1m_clk;
	input		ctrl_rx_reset_reset_n;
	input		ctrl_rx_writeclk_clk;
	input	[2:0]	ctrl_rx_writecsr_address;
	input		ctrl_rx_writecsr_read;
	input	[31:0]	ctrl_rx_writecsr_writedata;
	input		ctrl_rx_writecsr_write;
	output	[31:0]	ctrl_rx_writecsr_readdata;
	input	[31:0]	ctrl_rx_writedata_writedata;
	input		ctrl_rx_writedata_write;
	input		ctrl_tx_readclk_clk;
	input	[2:0]	ctrl_tx_readcsr_address;
	input		ctrl_tx_readcsr_read;
	input	[31:0]	ctrl_tx_readcsr_writedata;
	input		ctrl_tx_readcsr_write;
	output	[31:0]	ctrl_tx_readcsr_readdata;
	output	[7:0]	ctrl_tx_readdata_readdata;
	input		ctrl_tx_readdata_read;
	input		ctrl_tx_reset_reset_n;
	output	[14:0]	hps_0_ddr_mem_a;
	output	[2:0]	hps_0_ddr_mem_ba;
	output		hps_0_ddr_mem_ck;
	output		hps_0_ddr_mem_ck_n;
	output		hps_0_ddr_mem_cke;
	output		hps_0_ddr_mem_cs_n;
	output		hps_0_ddr_mem_ras_n;
	output		hps_0_ddr_mem_cas_n;
	output		hps_0_ddr_mem_we_n;
	output		hps_0_ddr_mem_reset_n;
	inout	[31:0]	hps_0_ddr_mem_dq;
	inout	[3:0]	hps_0_ddr_mem_dqs;
	inout	[3:0]	hps_0_ddr_mem_dqs_n;
	output		hps_0_ddr_mem_odt;
	output	[3:0]	hps_0_ddr_mem_dm;
	input		hps_0_ddr_oct_rzqin;
	output		hps_0_io_hps_io_emac1_inst_TX_CLK;
	output		hps_0_io_hps_io_emac1_inst_TXD0;
	output		hps_0_io_hps_io_emac1_inst_TXD1;
	output		hps_0_io_hps_io_emac1_inst_TXD2;
	output		hps_0_io_hps_io_emac1_inst_TXD3;
	input		hps_0_io_hps_io_emac1_inst_RXD0;
	inout		hps_0_io_hps_io_emac1_inst_MDIO;
	output		hps_0_io_hps_io_emac1_inst_MDC;
	input		hps_0_io_hps_io_emac1_inst_RX_CTL;
	output		hps_0_io_hps_io_emac1_inst_TX_CTL;
	input		hps_0_io_hps_io_emac1_inst_RX_CLK;
	input		hps_0_io_hps_io_emac1_inst_RXD1;
	input		hps_0_io_hps_io_emac1_inst_RXD2;
	input		hps_0_io_hps_io_emac1_inst_RXD3;
	inout		hps_0_io_hps_io_qspi_inst_IO0;
	inout		hps_0_io_hps_io_qspi_inst_IO1;
	inout		hps_0_io_hps_io_qspi_inst_IO2;
	inout		hps_0_io_hps_io_qspi_inst_IO3;
	output		hps_0_io_hps_io_qspi_inst_SS0;
	output		hps_0_io_hps_io_qspi_inst_CLK;
	inout		hps_0_io_hps_io_sdio_inst_CMD;
	inout		hps_0_io_hps_io_sdio_inst_D0;
	inout		hps_0_io_hps_io_sdio_inst_D1;
	output		hps_0_io_hps_io_sdio_inst_CLK;
	inout		hps_0_io_hps_io_sdio_inst_D2;
	inout		hps_0_io_hps_io_sdio_inst_D3;
	inout		hps_0_io_hps_io_usb1_inst_D0;
	inout		hps_0_io_hps_io_usb1_inst_D1;
	inout		hps_0_io_hps_io_usb1_inst_D2;
	inout		hps_0_io_hps_io_usb1_inst_D3;
	inout		hps_0_io_hps_io_usb1_inst_D4;
	inout		hps_0_io_hps_io_usb1_inst_D5;
	inout		hps_0_io_hps_io_usb1_inst_D6;
	inout		hps_0_io_hps_io_usb1_inst_D7;
	input		hps_0_io_hps_io_usb1_inst_CLK;
	output		hps_0_io_hps_io_usb1_inst_STP;
	input		hps_0_io_hps_io_usb1_inst_DIR;
	input		hps_0_io_hps_io_usb1_inst_NXT;
	output		hps_0_io_hps_io_spim1_inst_CLK;
	output		hps_0_io_hps_io_spim1_inst_MOSI;
	input		hps_0_io_hps_io_spim1_inst_MISO;
	output		hps_0_io_hps_io_spim1_inst_SS0;
	input		hps_0_io_hps_io_uart0_inst_RX;
	output		hps_0_io_hps_io_uart0_inst_TX;
	inout		hps_0_io_hps_io_i2c0_inst_SDA;
	inout		hps_0_io_hps_io_i2c0_inst_SCL;
	inout		hps_0_io_hps_io_i2c1_inst_SDA;
	inout		hps_0_io_hps_io_i2c1_inst_SCL;
	inout		hps_0_io_hps_io_gpio_inst_GPIO09;
	inout		hps_0_io_hps_io_gpio_inst_GPIO35;
	inout		hps_0_io_hps_io_gpio_inst_GPIO40;
	inout		hps_0_io_hps_io_gpio_inst_GPIO48;
	inout		hps_0_io_hps_io_gpio_inst_GPIO53;
	inout		hps_0_io_hps_io_gpio_inst_GPIO54;
	inout		hps_0_io_hps_io_gpio_inst_GPIO61;
	input		reset_reset_n;
	input		rx_video_reset_reset_n;
	input		rx_video_writeclk_clk;
	input	[2:0]	rx_video_writecsr_address;
	input		rx_video_writecsr_read;
	input	[31:0]	rx_video_writecsr_writedata;
	input		rx_video_writecsr_write;
	output	[31:0]	rx_video_writecsr_readdata;
	input	[7:0]	rx_video_writedata_writedata;
	input		rx_video_writedata_write;
	input		tx_video_readclk_clk;
	input	[2:0]	tx_video_readcsr_address;
	input		tx_video_readcsr_read;
	input	[31:0]	tx_video_readcsr_writedata;
	input		tx_video_readcsr_write;
	output	[31:0]	tx_video_readcsr_readdata;
	output	[7:0]	tx_video_readdata_readdata;
	input		tx_video_readdata_read;
	input		tx_video_reset_reset_n;
	output	[9:0]	leds_out_export;
	input	[9:0]	switches_in_export;
endmodule
