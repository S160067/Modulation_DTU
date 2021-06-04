library ieee;
use ieee.std_logic_1164.all;


ENTITY sender_tb IS
END sender_tb;
 
ARCHITECTURE behavior OF test_controller_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
COMPONENT sender is
   port (
      clk, reset, valid : in std_logic;
      data_in : in std_logic_vector(13 downto 0);
      write : out std_logic:
      data_out : out std_logic_vector(13 downto 0)
      );
end component;
 
signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal write, valid : std_logic := '0';
signal data_in, data_out : std_logic_vector(13 downto 0) :=  ( others => '0');
 -- Clock period definitions
constant clock_period : time := 20 ns;

BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: modulation_top PORT MAP (
   clk, reset, valid,write, data_in, data_out
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
   reset <= '1';
 -- hold reset state for 100 ns. 
 wait for 20 ns;
   reset <= '0';
-- Test things
wait for 5 ns;
data_in <= "01010101010101";
valid <= '1';

wait for clock_period;

wait for clock_period;
data_in <= "10101010101010";
valid <= '0';




wait for 50 ns;

end process;
 
END;
