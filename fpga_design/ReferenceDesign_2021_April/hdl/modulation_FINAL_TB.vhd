library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

ENTITY modulation_FINAL_tb IS
END modulation_FINAL_tb;
 
ARCHITECTURE behavior OF modulation_FINAL_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
 component modulation_top_sim is
	port (
		clk, reset			: in std_logic;
		-- Datout to GPIO
		GPIO_0 : inout std_logic_vector(35 downto 0);
		GPIO_1 : inout std_logic_vector(35 downto 0);
		-- FIFO SIGNALS
		fifo_bitstream_in, fifo_empty, fifo_full : in std_logic;
		modulation_scheme_select : in std_logic;
		fifo_bitstream_out, fifo_wr, fifo_read_en : out std_logic
	);
end component;

signal clk, reset : std_logic := '0';
signal bitstream_in, fifo_read_en, fifo_empty, modulation_scheme_select, debug_select : std_logic := '0';
signal bitstream_out, fifo_wr, fifo_full  : std_logic := '0';
signal gp1, gp0 : std_logic_vector(35 downto 0);

 -- Clock period definitions
constant clock_period : time := 20 ns;
 
BEGIN

 -- Instantiate the Unit Under Test (UUT)
 UUT_mod_top: component modulation_top_sim PORT MAP (
      clk => clk, 
      reset => reset, 
      GPIO_0 => gp0, 
      GPIO_1 => gp1, 
      fifo_bitstream_in => bitstream_in, 
      fifo_empty => fifo_empty,
      fifo_full => fifo_full,
      modulation_scheme_select => modulation_scheme_select,
      fifo_bitstream_out => bitstream_out, 
      fifo_wr => fifo_wr,
      fifo_read_en => fifo_read_en
   );


-- Clock process definitions
clock_process :process
begin
   clk <= '1';
   wait for clock_period/2;
   clk <= '0';
wait for clock_period/2;
end process;

fifo_input :process
begin
   --bitstream_in <= '0';

   --wait for 40 ns;
   -- Test 00
   wait until fifo_read_en = '1';
   wait for clock_period;
   bitstream_in <= '1';
   wait for clock_period;
   bitstream_in <= '1';

      -- Test 10
   wait until fifo_read_en = '1';
   wait for clock_period;
   bitstream_in <= '1';
   wait for clock_period;
   bitstream_in <= '1';

   wait until fifo_read_en = '1';
   wait for clock_period;
   bitstream_in <= '1';
   wait for clock_period;
   bitstream_in <= '1';

   wait until fifo_read_en = '1';
   wait for clock_period;
   bitstream_in <= '1';
   wait for clock_period;
   bitstream_in <= '1';

   -- Test 01
   wait until fifo_read_en = '1';
   wait for clock_period;
   bitstream_in <= '0';
   wait for clock_period;
   bitstream_in <= '0';
        -- Test 11
   wait until fifo_read_en = '1';
   --wait for clock_period;
   wait for clock_period;
   bitstream_in <= '0';
   wait for clock_period;
   bitstream_in <= '0'; 

   wait until fifo_read_en = '1';
   --wait for clock_period;
   wait for clock_period;
   bitstream_in <= '0';
   wait for clock_period;
   bitstream_in <= '0'; 

   wait until fifo_read_en = '1';
   --wait for clock_period;
   wait for clock_period;
   bitstream_in <= '0';
   wait for clock_period;
   bitstream_in <= '0'; 

end process;


-- Stimulus process
stim_proc: process

begin
   
   reset <= '0';
   fifo_full <= '1';
   modulation_scheme_select <= '0';
   fifo_empty <= '1';
   wait for 60 ns;
   reset <= '1';
   wait for 20 ns;
   fifo_empty <= '0';
   fifo_full <= '0';
   

   wait;
end process;
 
END;
