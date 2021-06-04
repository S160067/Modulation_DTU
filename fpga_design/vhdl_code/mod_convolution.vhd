library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod_convolution is 
	generic (
		constant G_SHIFTREG_SIZE 			: positive := 16;
		constant G_MANTISSA_SIZE			: positive := 15
		);
		
		port(
		i_rst										: in std_logic;
		i_clk 									: in std_logic;
		i_data_valid							: in std_logic;
		i_shiftreg_en							: in std_logic;
		i_data_window							: in signed(G_MANTISSA_SIZE downto 0);
		o_result									: out signed(G_MANTISSA_SIZE downto 0) := (others => '0');
		o_valid									: out std_logic
		);
		


function 	mult( a, b : signed(G_MANTISSA_SIZE downto 0)) return signed is 
						
						variable v_r :signed(2*G_MANTISSA_SIZE+1 downto 0);
						variable auxmax, auxmin :signed(G_MANTISSA_SIZE downto 0);
						
						begin
						v_r := a*b;
						auxmax := to_signed(32767, G_MANTISSA_SIZE+1);
						auxmin := to_signed(-32768, G_MANTISSA_SIZE+1);
						
						if v_r(2*G_MANTISSA_SIZE+1) = '1' then
							if v_r(2*G_MANTISSA_SIZE) = '0' then
								return auxmax;
							else 
								return (v_r(2*G_MANTISSA_SIZE+1) & v_r(2*G_MANTISSA_SIZE-1 downto G_MANTISSA_SIZE));
							end if;
							
						else
							if v_r(2*G_MANTISSA_SIZE) = '1' then
								return auxmin;
							else
								 return (v_r(2*G_MANTISSA_SIZE+1) & v_r(2*G_MANTISSA_SIZE-1 downto G_MANTISSA_SIZE));
							end if;
						end if;
		end mult;	
		
		
		function 	rshift( a : signed(G_MANTISSA_SIZE+4 downto 0)) return signed is 		
						
						begin
						return a(G_MANTISSA_SIZE+4 downto 4);
		end rshift;

end mod_convolution;	

architecture rtl of mod_convolution is 

	type fbarray is array (0 to G_SHIFTREG_SIZE) of signed(G_MANTISSA_SIZE downto 0);
	signal s_sregis 			: fbarray := (others=>(others=>'0'));
	signal s_validregis		: std_logic_vector(0 to G_SHIFTREG_SIZE-1);
	signal s_ones				: std_logic_vector(G_SHIFTREG_SIZE-1 downto 0) := (others=>'1');
	signal s_mult				: fbarray := (others=>(others=>'0'));
	signal s_pulse 			: fbarray := (others=>(others=>'0'));
	signal s_sum				: signed(G_MANTISSA_SIZE+4 downto 0);
	
	begin
	
	s_pulse(0) <= to_signed(0, s_pulse(0)'length);
	s_pulse(1) <= to_signed(-4215, s_pulse(0)'length);
	s_pulse(2) <= to_signed(-6954, s_pulse(0)'length);
	s_pulse(3) <= to_signed(-5900, s_pulse(0)'length);
	s_pulse(4) <= to_signed(0, s_pulse(0)'length);
	s_pulse(5) <= to_signed(9834, s_pulse(0)'length);
	s_pulse(6) <= to_signed(20861, s_pulse(0)'length);
	s_pulse(7) <= to_signed(29502, s_pulse(0)'length);
	s_pulse(8) <= to_signed(32767, s_pulse(0)'length);
	s_pulse(9) <= to_signed(29502, s_pulse(0)'length);
	s_pulse(10) <= to_signed(20861, s_pulse(0)'length);
	s_pulse(11) <= to_signed(9834, s_pulse(0)'length);
	s_pulse(12) <= to_signed(0, s_pulse(0)'length);
	s_pulse(13) <= to_signed(-5900, s_pulse(0)'length);
	s_pulse(14) <= to_signed(-6954, s_pulse(0)'length);
	s_pulse(15) <= to_signed(-4215, s_pulse(0)'length);
	s_pulse(16) <= to_signed(0, s_pulse(0)'length);
	
	shiftregs: process(i_clk) 
	begin
		if(i_clk'event and i_clk = '1') then
		
				if(i_shiftreg_en = '1') then	
					s_sregis(1 to G_SHIFTREG_SIZE-1) <= s_sregis(0 to G_SHIFTREG_SIZE-2);
					s_sregis(0)<= i_data_window;
					s_validregis(1 to G_SHIFTREG_SIZE-1) <= s_validregis(0 to G_SHIFTREG_SIZE-2);
					s_validregis(0)<= i_data_valid;
					
				end if;
					
					
				if(i_rst = '1') then
					s_sregis <= (others=>(others=>'0'));
					s_validregis <= (others=>'0');
				end if;
				
		end if;
			
	end process;
	
	arith: process(i_data_window, s_sregis, s_validregis, s_mult, s_pulse, s_sum, i_rst) 
	begin
	
		s_mult <= (others =>(others => '0'));
		
		for i in 0 to G_SHIFTREG_SIZE-1 loop
			
			s_mult(i) <= mult(s_sregis(i), s_pulse(i));
			
		end loop;
		
		s_sum <= (others=> '0');
		
		for i in 0 to G_SHIFTREG_SIZE loop
			
			s_sum <= s_sum + (resize(s_mult(i), s_sum'length));
			
		end loop;
		
		o_result <= rshift(s_sum);
		o_valid <= '0';
		
		if(s_validregis = s_ones) then
		
			o_valid <= '1';
			
		end if;
		
		
				
				
		if(i_rst = '1') then
			s_mult <= (others =>(others => '0'));
			s_sum <= (others => '0');
			o_result <= (others => '0');
			o_valid <= '0';
				
		end if;
			
	end process;
	
	
	
	
end architecture;