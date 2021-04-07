library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
-- Controller for testing purposes
-- Add components as they are made, so we can test the complete system
--------------------------------------------------


entity sender is
port(	
	stream_in: in std_logic;
	q: out std_logic;
	clk,rst: in std_logic
);
end sender;  

architecture arc_sender of sender is


    begin
    	PROCESS (clk, rst)                      
		BEGIN
       IF rst = '1' THEN            
          q <= '0';
       ELSIF clk'EVENT AND clk = '1' THEN
          q <= stream_in;
       END IF;
   END PROCESS;
end arc_sender;