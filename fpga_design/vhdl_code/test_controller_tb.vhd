library ieee;
use ieee.std_logic_1164.all;


ENTITY test_controller_tb IS
END test_controller_tb;
 
ARCHITECTURE behavior OF test_controller_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
COMPONENT test_controller
PORT(
    clk: in std_logic;
	reset: in std_logic
);
END COMPONENT;
 
signal clk : std_logic := '0';
signal reset : std_logic := '0';



 -- Clock period definitions
constant clock_period : time := 20 ns;
 
BEGIN

 -- Instantiate the Unit Under Test (UUT)
uut: test_controller PORT MAP (
    clk => clk,
	reset => reset
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
 -- hold reset state for 100 ns.
wait for 20 ns;

-- Test things

wait for 200 ns;

end process;
 
END;
