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
signal sin_temp : std_logic_vector(15 downto 0);

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
when b"00000" => sin_temp <=x"2000";
when b"00001" => sin_temp <=x"261F";
when b"00010" => sin_temp <=x"2B50";
when b"00011" => sin_temp <=x"2EC8";
when b"00100" => sin_temp <=x"3000";
when b"00101" => sin_temp <=x"2EC8";
when b"00110" => sin_temp <=x"2B50";
when b"00111" => sin_temp <=x"261F";
when b"01000" => sin_temp <=x"2000";
when b"01001" => sin_temp <=x"19E1";
when b"01010" => sin_temp <=x"14B0";
when b"01011" => sin_temp <=x"1138";
when b"01100" => sin_temp <=x"1000";
when b"01101" => sin_temp <=x"1138";
when b"01110" => sin_temp <=x"14B0";
when b"01111" => sin_temp <=x"19E1";
when b"10000" => sin_temp <=x"2000";
when others => sin_temp <=x"FFFF";
end case;
end process;
sin_o <= sin_temp(13 downto 0);	

END rtl;

