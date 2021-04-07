library ieee;
use ieee.std_logic_1164.all;



entity reciever is
port(	
	stream_in: in std_logic;
	q: out std_logic;
	clk,rst: in std_logic
);
end reciever;  

architecture arc_reciever of reciever is

    begin
	 
	PROCESS (clk, rst)                      
		BEGIN
       IF rst = '1' THEN            
          q <= '0';
       ELSIF clk'EVENT AND clk = '1' THEN
          q <= stream_in;
       END IF;
   END PROCESS;
    
end arc_reciever;