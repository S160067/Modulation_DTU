library ieee;
use ieee.std_logic_1164.all;

entity modulator is
port (
	clk, reset : in std_logic
	data_in : in std_logic_vector(1 downto 0);
	data_i, data_q : out std_logic_vector(13 downto 0);
	valid, ready : out std_logic
	);
end modulator;

architecture arch of demodulator is 


begin
	data_i <= "00000000000000" when data_in = "00" else "11111111111111";
	data_q <= "00000000000000" when data_in = "00" else "11111111111111";
	valid <= '0' when data_in = "00" else "1";
end arch;