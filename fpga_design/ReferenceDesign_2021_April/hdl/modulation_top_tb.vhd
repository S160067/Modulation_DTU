library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

ENTITY modulation_top_tb IS
END modulation_top_tb;
 
ARCHITECTURE behavior OF modulation_top_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
 component reciever_top is
   port (
      clk, reset : in std_logic;
      data_i, data_q  : in std_logic_vector(13 downto 0);
      fifo_full : in std_logic;
      bitstream, fifo_wr : out std_logic
   );
   end component;

   component sender_top is
      port (
         clk, reset : in std_logic;
         fifo_bitstream, fifo_empty : in std_logic;
         write, read_en : out std_logic;
         data_i, data_q : out std_logic_vector(13 downto 0);
         modulation_scheme_select : in std_logic
         );
   end component;

signal clk, reset : std_logic := '0';
signal bitstream_in, fifo_read_en, fifo_empty, write, modulation_scheme_select : std_logic := '0';
signal bitstream_out, fifo_wr, fifo_full  : std_logic := '0';
signal data_i_tx, data_q_tx,data_i_rx, data_q_rx : std_logic_vector(13 downto 0) :=  ( others => '0');

 -- Clock period definitions
constant clock_period : time := 20 ns;
 
BEGIN

 -- Instantiate the Unit Under Test (UUT)
 UUT_RX: component reciever_top PORT MAP (
      clk => clk, 
      reset => reset, 
      data_i => data_i_rx, 
      data_q => data_q_rx, 
      fifo_full => fifo_full, 
      bitstream => bitstream_out, 
      fifo_wr => fifo_wr
   );

UUT_TX: component sender_top port map(
      clk => clk, 
      reset => reset,
      fifo_bitstream => bitstream_in, 
      fifo_empty => fifo_empty,
      write => write, 
      read_en => fifo_read_en,
      data_i => data_i_tx, 
      data_q => data_q_tx,
      modulation_scheme_select => modulation_scheme_select
); 

data_i_rx <= data_i_tx;
data_q_rx <= data_q_tx;

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
   bitstream_in <= '0';

      -- Test 10
   wait until fifo_read_en = '1';
   wait for clock_period;
   bitstream_in <= '1';
   wait for clock_period;
   bitstream_in <= '0';

         -- Test 01
   wait until fifo_read_en = '1';
   wait for clock_period;
   bitstream_in <= '0';
   wait for clock_period;
   bitstream_in <= '1';
        -- Test 11
   wait until fifo_read_en = '1';
   --wait for clock_period;
   wait for clock_period;
   bitstream_in <= '0';
   wait for clock_period;
   bitstream_in <= '1'; 

end process;


-- Stimulus process
stim_proc: process

begin
   
   reset <= '1';
   fifo_full <= '1';
   modulation_scheme_select <= '0';
   fifo_empty <= '1';
   wait for 60 ns;
   reset <= '0';
   wait for 20 ns;
   fifo_empty <= '0';
   fifo_full <= '0';
   

   wait;
end process;
 
END;
