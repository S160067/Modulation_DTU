library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY buffer_rx_tb IS
END buffer_rx_tb;
 
ARCHITECTURE behavior OF buffer_rx_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
COMPONENT buffer_rx is
   port (
      clk, reset : in std_logic;
      data_mod : in std_logic_vector(1 downto 0);
      fifo_full, valid : in std_logic;
      bitstream, fifo_wr : out std_logic
      );
end component;

signal clk, reset : std_logic := '0';
signal fifo_full, valid : std_logic := '0';
signal bitstream, fifo_wr : std_logic := '0';
signal data_mod : std_logic_vector(1 downto 0) :=  ( others => '0');
 -- Clock period definitions
constant clock_period : time := 20 ns;

BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: component buffer_rx PORT MAP (
   clk => clk, 
   reset => reset,
   data_mod => data_mod,
   fifo_full => fifo_full,
   bitstream => bitstream,
   valid => valid,
   fifo_wr => fifo_wr
);
 

-- Clock process definitions
clock_process : process
begin
clk <= '0';
wait for clock_period/2;
clk <= '1';
wait for clock_period/2;
end process;

-- Stimulus process
stim_proc: process
begin

      reset <= '1';
      wait for 30 ns;
      reset <= '0';
      fifo_full <= '0';
      wait for clock_period;

      data_mod <= "00";
      valid <= '1';
      wait until fifo_wr = '1';
      wait for clock_period;
      
      data_mod <= "01";
      valid <= '1';
      wait until fifo_wr = '1';
      wait for clock_period;

      data_mod <= "10";
      valid <= '1';
      wait until fifo_wr = '1';
      wait for clock_period;

      data_mod <= "11";
      valid <= '1';
      wait until fifo_wr = '1';
      wait for clock_period;
      wait for clock_period;

      fifo_full <= '1';

      data_mod <= "11";
      valid <= '1';
      wait for clock_period;
      wait for clock_period;
      data_mod <= "01";
      valid <= '1';
      wait for clock_period;
      wait for clock_period;
wait;

end process;
 
END;