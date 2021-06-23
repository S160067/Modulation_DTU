library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

ENTITY sender_top_tb IS
END sender_top_tb;
 
ARCHITECTURE behavior OF sender_top_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
COMPONENT sender_top is
   port (
      clk, reset : in std_logic;
      fifo_bitstream, fifo_empty : in std_logic;
      write, read_en : out std_logic;
      data_i, data_q : out std_logic_vector(13 downto 0);
      modulation_scheme_select : in std_logic;
      debug_select : in std_logic
   );
end component;
 
signal clk, reset : std_logic := '0';
signal bitstream, fifo_empty, read_en, write, modulation_scheme_select, debug_select : std_logic;
signal data_i, data_q : std_logic_vector(13 downto 0) :=  ( others => '0');
 -- Clock period definitions
constant clock_period : time := 20 ns;

file file_dataI : text;
file file_dataQ : text;
 

BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: component sender_top PORT MAP (
   clk => clk, 
   reset => reset, 
   fifo_bitstream => bitstream, 
   fifo_empty => fifo_empty,
   write => write,
   read_en => read_en,
   data_i => data_i, 
   data_q => data_q, 
   modulation_scheme_select => modulation_scheme_select,
   debug_select => debug_select
   );
 

-- Clock process definitions
clock_process :process
begin
clk <= '0';
wait for clock_period/2;
clk <= '1';
wait for clock_period/2;
end process;
 

-- Stimulus process
stim_proc: process
  
begin
   
   debug_select <= '0';
   reset <= '1';
   fifo_empty <= '1';
   wait for 30 ns;
   reset <= '0';
   fifo_empty <= '0';
   modulation_scheme_select <= '0';
   fifo_empty <= '0';
   
   -- Test 10
   wait until read_en = '1';
   wait for clock_period;
   bitstream <= '0';
   wait for clock_period;
   bitstream <= '1';

   -- Test 01
   wait until read_en = '1';
   wait for clock_period;
   bitstream <= '1';
   wait for clock_period;
   bitstream <= '0';

   -- Test 00
   wait until read_en = '1';
   wait for clock_period;
   bitstream <= '0';
   wait for clock_period;
   bitstream <= '0';

   -- Test 01
   wait until read_en = '1';
   wait for clock_period;
   bitstream <= '1';
   wait for clock_period;
   bitstream <= '1';

   wait for clock_period;
   
   wait for 40 ns;
   fifo_empty <= '1';
   
   wait for 100 ns;
   -- Test 01
   --wait until read_en = '1';
   wait for clock_period;
   bitstream <= '1';
   wait for clock_period;
   bitstream <= '0';

   -- Test 00
   --wait until read_en = '1';
   wait for clock_period;
   bitstream <= '0';
   wait for clock_period;
   bitstream <= '0';
   
 

   wait;

end process;
 
END;
