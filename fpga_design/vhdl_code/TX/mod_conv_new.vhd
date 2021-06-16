LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY mod_convolution IS
	GENERIC (
		CONSTANT G_SHIFTREG_SIZE : POSITIVE := 16;
		CONSTANT G_MANTISSA_SIZE : POSITIVE := 13
	);

	PORT (
		i_rst : IN STD_LOGIC;
		i_clk : IN STD_LOGIC;
		i_data_valid : IN STD_LOGIC;
		i_no_data_flag : IN STD_LOGIC;
		i_symbol : IN STD_LOGIC;
		o_result : OUT STD_LOGIC_VECTOR(G_MANTISSA_SIZE DOWNTO 0);
		o_valid : OUT STD_LOGIC
	);

	FUNCTION mult(a, b : signed(G_MANTISSA_SIZE DOWNTO 0)) RETURN signed IS

		VARIABLE v_r : signed(2 * G_MANTISSA_SIZE + 1 DOWNTO 0);
		VARIABLE auxmax, auxmin : signed(G_MANTISSA_SIZE DOWNTO 0);

	BEGIN
		v_r := a * b;
		auxmax := to_signed(8191, G_MANTISSA_SIZE + 1);
		auxmin := to_signed(-8191, G_MANTISSA_SIZE + 1);

		IF v_r(2 * G_MANTISSA_SIZE + 1) = '1' THEN
			IF v_r(2 * G_MANTISSA_SIZE) = '0' THEN
				RETURN auxmin;
			ELSE
				RETURN (v_r(2 * G_MANTISSA_SIZE + 1) & v_r(2 * G_MANTISSA_SIZE - 1 DOWNTO G_MANTISSA_SIZE));
			END IF;

		ELSE
			IF v_r(2 * G_MANTISSA_SIZE) = '1' THEN
				RETURN auxmax;
			ELSE
				RETURN (v_r(2 * G_MANTISSA_SIZE + 1) & v_r(2 * G_MANTISSA_SIZE - 1 DOWNTO G_MANTISSA_SIZE));
			END IF;
		END IF;
	END mult;
END mod_convolution;

ARCHITECTURE rtl OF mod_convolution IS

	TYPE fbarray IS ARRAY (0 TO G_SHIFTREG_SIZE) OF signed(G_MANTISSA_SIZE DOWNTO 0);
	SIGNAL s_sregis : fbarray := (OTHERS => (OTHERS => '0'));
	SIGNAL s_mult : fbarray := (OTHERS => (OTHERS => '0'));
	SIGNAL s_pulse : fbarray := (OTHERS => (OTHERS => '0'));
	SIGNAL s_sum : signed(G_MANTISSA_SIZE + 4 DOWNTO 0);
	signal no_data_flag_reg : STD_LOGIC;
BEGIN

	s_pulse(0) <= to_signed(212, s_pulse(0)'length);
	s_pulse(1) <= to_signed(156, s_pulse(0)'length);
	s_pulse(2) <= to_signed(-424, s_pulse(0)'length);
	s_pulse(3) <= to_signed(-784, s_pulse(0)'length);
	s_pulse(4) <= to_signed(-424, s_pulse(0)'length);
	s_pulse(5) <= to_signed(784, s_pulse(0)'length);
	s_pulse(6) <= to_signed(2474, s_pulse(0)'length);
	s_pulse(7) <= to_signed(3943, s_pulse(0)'length);

	s_pulse(8) <= to_signed(4523, s_pulse(0)'length);

	s_pulse(9) <= to_signed(3943, s_pulse(0)'length);
	s_pulse(10) <= to_signed(2474, s_pulse(0)'length);
	s_pulse(11) <= to_signed(784, s_pulse(0)'length);
	s_pulse(12) <= to_signed(-424, s_pulse(0)'length);
	s_pulse(13) <= to_signed(-784, s_pulse(0)'length);
	s_pulse(14) <= to_signed(-424, s_pulse(0)'length);
	s_pulse(15) <= to_signed(156, s_pulse(0)'length);
	s_pulse(16) <= to_signed(212, s_pulse(0)'length);

	shiftregs : PROCESS (i_clk)

		VARIABLE sumvar : signed(G_MANTISSA_SIZE + 4 DOWNTO 0);

	BEGIN

		IF (rising_edge(i_clk)) THEN
			IF (i_rst = '1') THEN

				s_sregis <= (OTHERS => (OTHERS => '0'));
				s_sum <= (OTHERS => '0');
				no_data_flag_reg <= '1';
			ELSE
			no_data_flag_reg <= i_no_data_flag;
			o_valid <= not no_data_flag_reg;
				s_sregis(1 TO G_SHIFTREG_SIZE - 1) <= s_sregis(0 TO G_SHIFTREG_SIZE - 2);

				IF (i_data_valid = '1' AND i_symbol = '0') THEN
					s_sregis(0) <= to_signed(8191, s_sregis(0)'length);

				ELSIF (i_data_valid = '1' AND i_symbol = '1') THEN

					s_sregis(0) <= to_signed(-8192, s_sregis(0)'length);
				ELSE
					s_sregis(0) <= to_signed(0, s_sregis(0)'length);
				END IF;
				sumvar := (OTHERS => '0');
				FOR i IN 0 TO G_SHIFTREG_SIZE - 1 LOOP
					sumvar := sumvar + resize(s_mult(i), sumvar'length);
				END LOOP;
				s_sum <= sumvar;
			END IF;
		END IF;
	END PROCESS;
	
	arith : PROCESS (i_symbol, s_sregis, s_mult, s_sum, i_rst, s_pulse)
	BEGIN
		s_mult <= (OTHERS => (OTHERS => '0'));
		FOR i IN 0 TO G_SHIFTREG_SIZE - 1 LOOP
			s_mult(i) <= mult(s_sregis(i), s_pulse(i));
		END LOOP;
			o_result <= STD_LOGIC_VECTOR(8191+s_sum(G_MANTISSA_SIZE DOWNTO 0));

		IF (i_rst = '1') THEN
			s_mult <= (OTHERS => (OTHERS => '0'));
		END IF;
	END PROCESS;
END ARCHITECTURE;