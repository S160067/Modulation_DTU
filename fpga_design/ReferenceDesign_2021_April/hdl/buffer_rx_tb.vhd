library ieee;
use ieee.std_logic_1164.all;


ENTITY buffer_rx_tb IS
END buffer_rx_tb;
 
ARCHITECTURE behavior OF buffer_rx_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
COMPONENT buffer_rx_tb is
   port (
      clk, reset, en	: in std_logic;
      data_in : in std_logic_vector(13 downto 0);
      data_write, data_read : in std_logic
      data_out : out std_logic_vector(13 downto 0)
      );
end component;
 
signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal data_write, data_read, en : std_logic := '0';
signal data_in, data_out : std_logic_vector(13 downto 0) :=  ( others => '0');
 -- Clock period definitions
constant clock_period : time := 20 ns;

BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: buffer_rx_tb PORT MAP (
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
begin
   reset <= '1';
 -- hold reset state for 100 ns. 
 wait for 20 ns;
   reset <= '0';
-- Test things
wait for 5 ns;
data_in <= "01010101010101";
en <= '1';
data_write <= '1';

wait for clock_period;
data_read <= '1';
wait for clock_period;
wait for clock_period;
data_write <= '0';
data_in <= "10101010101010";
data_read <= '0';




wait for 50 ns;

end process;
 
END;
