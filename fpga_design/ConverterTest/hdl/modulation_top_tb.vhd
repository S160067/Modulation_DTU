library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

ENTITY modulation_top_tb IS
END modulation_top_tb;
 
ARCHITECTURE behavior OF modulation_top_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
 component modulation_top is
	port (
		clk, reset			: in std_logic;
		-- Datout to GPIO
		GPIO_0 : inout std_logic_vector(35 downto 0);
		GPIO_1 : inout std_logic_vector(35 downto 0);
		-- FIFO SIGNALS
		fifo_bitstream_in, fifo_empty, fifo_full : in std_logic;
		fifo_bitstream_out, fifo_wr, fifo_read_en : out std_logic
	);
end component;

signal clk, reset : std_logic := '0';
signal bitstream_in, bitstream_out, fifo_wr, fifo_full, fifo_read_en, fifo_empty : std_logic := '0';
signal data_i, data_q : std_logic_vector(13 downto 0) :=  ( others => '0');
signal GPIO_0, GPIO_1 : std_logic_vector(35 downto 0) :=  ( others => '0');
 -- Clock period definitions
constant clock_period : time := 20 ns;

file file_dataI : text;
 
BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: modulation_top PORT MAP (
   clk, reset, GPIO_0, GPIO_1, bitstream_in, fifo_empty, fifo_full, bitstream_out, fifo_wr, fifo_read_en);
 

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

   variable v_ILINE     : line;
   variable r_ILINE : std_logic;
   
begin

   file_open(file_dataI, "/home/haraldbid/Projects/GIT/Modulation_DTU/fpga_design/ReferenceDesign_2021_April/hdl/fifoinputs.txt",  read_mode);
   
   while not endfile(file_dataI) loop
     readline(file_dataI, v_ILINE);
      read(v_ILINE, r_ILINE);
     
     -- Pass the line to signal
     bitstream_in <= r_ILINE;


     wait for clock_period;
    --wait for 10 ns;
 
   end loop;

   file_close(file_dataI);
   
   

wait for 50 ns;

end process;
 
END;
