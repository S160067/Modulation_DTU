library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
-- Controller for testing purposes
-- Add components as they are made, so we can test the complete system
--------------------------------------------------


entity test_controller is
port(	
   clk: in std_logic;
	reset: in std_logic; 
   stream_in: in std_logic;
	stream_out: out std_logic
);
end test_controller;  

architecture arc_controller of test_controller is

    -- Component declaration

	component reciever is
		port(stream_in: in std_logic;
		q: out std_logic;
		clk,rst: in std_logic);
	end component reciever;
	component sender is
		port(stream_in: in std_logic;
		q: out std_logic;
		clk,rst: in std_logic);
	end component sender;
	
    -- Signal decleration

	signal data : std_logic;
	 
    begin
	    s1 : sender port map(stream_in,data,clk,reset);
	    r1 : reciever port map(data,stream_out,clk,reset);

    
end arc_controller;