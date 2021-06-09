LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY cos_gen IS
	GENERIC (
		data_width : NATURAL := 14;
		pulse_width : NATURAL := 17;
		phase_width : NATURAL := 5
	);

	PORT (
		clk_i 	: std_logic;
		reset_i : std_logic;
		--phase_i : IN std_logic(phase_width - 1 DOWNTO 0);
		cos_o : OUT std_logic_vector(data_width - 1 DOWNTO 0)
	);

END ENTITY;

ARCHITECTURE rtl OF cos_gen IS
signal phase_cnt : std_logic_vector(4 downto 0);
signal cos_temp : std_logic_vector(13 downto 0);

BEGIN	

process(clk_i, reset_i)
begin
if(rising_edge(clk_i)) then
	if(reset_i = '1') then
	phase_cnt <= B"10000";
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
when b"00000" => cos_temp <="01111111111111";
when b"00001" => cos_temp <="10110000111110";
when b"00010" => cos_temp <="11011010100000";
when b"00011" => cos_temp <="11110110001111";
when b"00100" => cos_temp <="11111111111111";
when b"00101" => cos_temp <="11110110001111";
when b"00110" => cos_temp <="11011010100000";
when b"00111" => cos_temp <="10110000111110";
when b"01000" => cos_temp <="01111111111111";
when b"01001" => cos_temp <="01001111000000";
when b"01010" => cos_temp <="00100101011110";
when b"01011" => cos_temp <="00001001101111";
when b"01100" => cos_temp <="00000000000000";
when b"01101" => cos_temp <="00001001101111";
when b"01110" => cos_temp <="00100101011110";
when b"01111" => cos_temp <="01001111000000";
when b"10000" => cos_temp <="01111111111111";
when others => cos_temp <="11111111111111";
end case;
end process;
cos_o <= cos_temp;
END rtl;