-- Quartus Prime VHDL Template
-- Basic Shift Register

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY sum IS
	GENERIC (
		data_width : NATURAL := 14
        );

	PORT (
      clk : In std_logic;
		signal_re : IN std_logic_vector(data_width - 1 DOWNTO 0);
      signal_im : IN std_logic_vector(data_width - 1 DOWNTO 0);
		signal_out : OUT std_logic_vector(data_width - 1 DOWNTO 0)
	); 
END ENTITY;


ARCHITECTURE rtl OF sum IS
BEGIN
process(clk)
begin
if(rising_edge(clk)) then
	if(signal_re(data_width-1) & signal_im(data_width-1)) then
		signal_out <= signal_re+signal_im-1;
	else
		signal_out <= signal_re+signal_im-1;
end if;
end process;

END rtl;