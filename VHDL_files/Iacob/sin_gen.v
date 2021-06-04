-- Quartus Prime VHDL Template
-- Basic Shift Register

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sin_gen IS
	GENERIC (
		data_width : NATURAL := 14
		pulse_width : NATURAL := 17
		phase_width : NATURAL := pulse_width >> 3
	);

	PORT (
		phase_i : IN std_logic(phase_width - 1 DOWNTO 0);
		sin_o : OUT std_logic_vector(data_width - 1 DOWNTO 0)
	);

END ENTITY;

ARCHITECTURE rtl OF sin_gen IS

BEGIN
	CASE phase_i IS
		WHEN x"00" => sin_o <= x"00";
		WHEN x"01" => sin_o <= x"187E";
		WHEN x"02" => sin_o <= x"2D41";
		WHEN x"03" => sin_o <= x"3B21";
		WHEN x"04" => sin_o <= x"4000";
		WHEN x"05" => sin_o <= x"3B21";
		WHEN x"06" => sin_o <= x"2D41";
		WHEN x"07" => sin_o <= x"187E";
		WHEN x"08" => sin_o <= x"00";
		WHEN x"09" => sin_o <= x"E782";
		WHEN x"0A" => sin_o <= x"D2BF";
		WHEN x"0B" => sin_o <= x"C4DF";
		WHEN x"0C" => sin_o <= x"C000";
		WHEN x"0D" => sin_o <= x"C4DF";
		WHEN x"0E" => sin_o <= x"D2BF";
		WHEN x"0F" => sin_o <= x"E782";
		WHEN x"10" => sin_o <= x"00";
		WHEN OTHERS => sin_o <= x"FFFF";
	END CASE;

END rtl;