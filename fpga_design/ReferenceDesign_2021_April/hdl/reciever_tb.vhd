library ieee;
use ieee.std_logic_1164.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

ENTITY test_controller_tb IS
END test_controller_tb;
 
ARCHITECTURE behavior OF test_controller_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
COMPONENT reciever_top is
   port (
      clk, reset : in std_logic;
      data_i, data_q  : in std_logic_vector(13 downto 0);
      fifo_full : in std_logic;
      bitstream, fifo_wr : out std_logic
end component;
 
signal clk, reset, fifo_full : std_logic := '0';
signal bitstream, fifo_wr : std_logic;
signal data_i, data_q : std_logic_vector(13 downto 0) :=  ( others => '0');
 -- Clock period definitions
constant clock_period : time := 20 ns;

file file_dataI : text;
file file_dataQ : text;
 
constant c_WIDTH : natural := 4;

BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: modulation_top PORT MAP (
   clk, reset, en, data_in, data_out, data_write, data_read);
 

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

begin

   file_open(file_dataI, "datastreamI.txt",  read_mode);
   file_open(file_dataQ, "datastreamQ.txt", read_mode);

   while not endfile(file_dataI) loop
     readline(file_dataI, v_ILINE);
     readline(file_dataQ, v_QLINE);

     
     -- Pass the line to signal
     data_in_i <= v_ILINE;
     data_in_q <= v_QLINE;


     wait for clock_period;

 
   end loop;

   file_close(file_dataI);
   file_close(file_dataI);

   
´

wait for 50 ns;

end process;
 
END;
