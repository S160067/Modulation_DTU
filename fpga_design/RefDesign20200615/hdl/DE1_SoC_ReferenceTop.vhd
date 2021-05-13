library ieee;
use ieee.std_logic_1164.all;

entity DE1_SoC_ReferenceTop is
    port(
        -- ADC
     -- ADC_CS_n         : out   std_logic;
     -- ADC_DIN          : out   std_logic;
     -- ADC_DOUT         : in    std_logic;
     -- ADC_SCLK         : out   std_logic;

        -- CLOCK
        CLOCK_50 : in std_logic;
     -- CLOCK2_50        : in    std_logic;
     -- CLOCK3_50        : in    std_logic;
     -- CLOCK4_50        : in    std_logic;

        -- SEG7
   --   HEX0_N           : out   std_logic_vector(6 downto 0);
    --  HEX1_N           : out   std_logic_vector(6 downto 0);
     -- HEX2_N           : out   std_logic_vector(6 downto 0);
--      HEX3_N           : out   std_logic_vector(6 downto 0);
 ---     HEX4_N           : out   std_logic_vector(6 downto 0);
  --    HEX5_N           : out   std_logic_vector(6 downto 0);

 

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
		
		
				-- loopback tx
		GPIO_0				: inout std_logic_vector(35 downto 0);
		GPIO_1				: inout std_logic_vector(35 downto 0);
		SW : in std_logic_vector(9 downto 0);
      LEDR : out std_logic_vector(9 downto 0)
		);
	end component fpga_top;
	
		
		
signal CLOCK_1 : std_logic;

begin

	--LEDR(7 downto 0) <= GPIO_1(7 downto 0) ;
	--GPIO_0(7 downto 0) <= sw(7 downto 0);

	fpga_top_inst : component fpga_top
	port map (
		clk						=> CLOCK_1,
		reset						=> KEY_N(0),
	
		
		-- GPIO Interface to DA AD board
		GPIO_0					=> GPIO_0,
		GPIO_1					=> GPIO_1,
		SW => sw,
      LEDR => LEDR
	);
	

	
end;