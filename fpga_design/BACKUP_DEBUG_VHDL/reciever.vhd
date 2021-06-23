library ieee;
use ieee.std_logic_1164.all;


entity reciever is
port (
	clk, reset : in std_logic;
	data_i, data_q : in std_logic_vector(13 downto 0);
	data_sync_i, data_sync_q : out std_logic_vector(13 downto 0);
	valid : out std_logic
	);
end reciever;

architecture loopback_arch of reciever is 

	signal reg_out_i, reg_out_q, reg_next_i, reg_next_q : std_logic_vector(13 downto 0);
	signal zerovec : std_logic_vector(13 downto 0);
	signal valid1, valid2 : std_logic;
begin

	--valid <= data_i(13) OR data_i(12) OR data_i(11) OR data_i(10) OR data_i(9) OR data_i(8) OR data_i(7) OR data_q(13) OR data_q(12) OR data_q(11) OR data_q(10) OR data_q(9) OR data_q(8) OR data_q(7) ; 
	--valid <= '1';
	--zerovec <= (others => '0');
	valid <= valid1 or valid2;
	valid1 <= '0' when reg_out_i = reg_next_i else '1';
	valid2 <= '0' when reg_out_q = reg_next_q else '1';

	reg_next_i <= data_i;
	reg_next_q <= data_q;

	data_sync_i <= reg_out_i;
	data_sync_q <= reg_out_q;


	   -- FOR BOARD KEY/RESET MIGHT BE INVERTED...
	   PROCESS (clk, reset)                      
	   BEGIN
				IF reset = '1' THEN
					
				   reg_out_i <= (others => '0');
				   reg_out_q <= (others => '0');
			
				ELSIF rising_edge(clk) THEN
				   reg_out_i <= reg_next_i;
				   reg_out_q <= reg_next_q;
				END IF;		  
	   END PROCESS;
	
end loopback_arch;