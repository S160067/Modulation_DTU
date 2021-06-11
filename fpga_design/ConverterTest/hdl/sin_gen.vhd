-- Quartus Prime VHDL Template
-- Basic Shift Register

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY sin_gen IS
	GENERIC (
		data_width : NATURAL := 14;
		pulse_width : NATURAL := 17;
		phase_width : NATURAL := 5
	);

	PORT (
		clk_i 	: std_logic;
		reset_i : std_logic;
		--phase_i : IN std_logic(phase_width - 1 DOWNTO 0);
		sin_o : OUT std_logic_vector(data_width - 1 DOWNTO 0)
	);

END ENTITY;

ARCHITECTURE rtl OF sin_gen IS
signal phase_cnt : std_logic_vector(4 downto 0);
signal sin_temp : std_logic_vector(13 downto 0);

BEGIN	


process(clk_i,reset_i)
begin
if(rising_edge(clk_i)) then
	if(reset_i = '1') then
	phase_cnt <=  B"10000";
	else
		if(phase_cnt = 16) then
			phase_cnt <= (others =>'0');
		else 
			phase_cnt <= phase_cnt +1;
		end if;
	end if;
end if;
end process;

process(phase_cnt)
begin
	CASE phase_cnt IS
	
	
	
when b"00000" => sin_temp <="01111111111111";
when b"00001" => sin_temp <="10101110001110";
when b"00010" => sin_temp <="11010110001110";
when b"00011" => sin_temp <="11110010100100";
when b"00100" => sin_temp <="11111111011100";
when b"00101" => sin_temp <="11111011000110";
when b"00110" => sin_temp <="11100110001000";
when b"00111" => sin_temp <="11000011011000";
when b"01000" => sin_temp <="10010111100000";
when b"01001" => sin_temp <="01101000011110";
when b"01010" => sin_temp <="00111100100110";
when b"01011" => sin_temp <="00011001110110";
when b"01100" => sin_temp <="00000100111000";
when b"01101" => sin_temp <="00000000100010";
when b"01110" => sin_temp <="00001101011010";
when b"01111" => sin_temp <="00101001110000";
when b"10000" => sin_temp <="01010001110000";
when others => sin_temp <="11111111111111";
end case;
end process;
sin_o <= sin_temp;	

END rtl;

