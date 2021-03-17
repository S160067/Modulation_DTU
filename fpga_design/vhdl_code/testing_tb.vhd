library ieee;
use ieee.std_logic_1164.all;

ENTITY tb_up_down IS
END tb_up_down;
 
ARCHITECTURE behavior OF tb_up_down IS
 
 – Component Declaration for the Unit Under Test (UUT)
 
COMPONENT AND_ent
PORT(
    x: in std_logic;
	y: in std_logic;
	F: out std_logic
);
END COMPONENT;
 
--Inputs
signal x : std_logic := '0';
signal y : std_logic := '0';

--Outputs
signal F : std_logic := '0';

signal clock : std_logic := '0';

 – Clock period definitions
constant clock_period : time := 20 ns;
 
BEGIN
 
 – Instantiate the Unit Under Test (UUT)
uut: ANT_ent PORT MAP (
    x => x,
	y => y,
	F => F
);
 

– Clock process definitions
clock_process :process
begin
clock <= '0';
wait for clock_period/2;
clock <= '1';
wait for clock_period/2;
end process;
 
 – Stimulus process
stim_proc: process
begin
 – hold reset state for 100 ns.
wait for 20 ns;
x <= '1';
wait for 20 ns;
y <= '1';

wait for 200 ns;

end process;
 
END;
