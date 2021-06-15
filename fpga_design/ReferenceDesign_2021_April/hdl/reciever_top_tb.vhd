library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

ENTITY reciever_top_tb IS
END reciever_top_tb;
 
ARCHITECTURE behavior OF reciever_top_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
COMPONENT reciever_top is
   port (
      clk, reset : in std_logic;
      data_i, data_q  : in std_logic_vector(13 downto 0);
      fifo_full : in std_logic;
      bitstream, fifo_wr : out std_logic
   );
end component;
 
signal clk, reset : std_logic := '0';
signal bitstream, fifo_wr, fifo_full : std_logic;
signal data_i, data_q : std_logic_vector(13 downto 0) :=  ( others => '0');
 -- Clock period definitions
constant clock_period : time := 20 ns;

file file_dataI : text;
file file_dataQ : text;
 

BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: reciever_top PORT MAP (
   clk, reset, data_i, data_q, fifo_full, bitstream, fifo_wr);
 

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
   variable v_QLINE     : line;
   variable r_ILINE : std_logic_vector(13 downto 0);
   variable r_QLINE : std_logic_vector(13 downto 0);
   
begin

   reset <= '1';
   fifo_full <= '0';
   wait for 30 ns;
   reset <= '0';
   wait for 20 ns;

   file_open(file_dataI, "/home/haraldbid/Projects/GIT/modulation_dtu/Modulation_DTU/fpga_design/ReferenceDesign_2021_April/hdl/ftable.txt",  read_mode);
   file_open(file_dataQ, "/home/haraldbid/Projects/GIT/modulation_dtu/Modulation_DTU/fpga_design/ReferenceDesign_2021_April/hdl/gtable.txt", read_mode);
   
   while not endfile(file_dataI) loop
      readline(file_dataI, v_ILINE);
      readline(file_dataQ, v_QLINE);
      read(v_ILINE, r_ILINE);
      read(v_QLINE, r_QLINE);
     
     -- Pass the line to signal
     data_i <= r_ILINE;
     data_q <= r_QLINE;


     --wait for clock_period;
      wait for 10 ns;
 
   end loop;

   file_close(file_dataI);
   file_close(file_dataI);

   

wait;

end process;
 
END;
