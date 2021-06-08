library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod_shaper is 
	generic (
		constant G_SHIFTREG_SIZE 			: positive := 16;
		constant G_MANTISSA_SIZE			: positive := 13
		);
		
		port(
		i_rst										: in std_logic;
		i_clk 									: in std_logic;
		i_data_valid							: in std_logic;
		i_symbol									: in std_logic;
		o_result									: out std_logic_vector(G_MANTISSA_SIZE downto 0);
		o_valid									: out std_logic
		);	

end mod_shaper;	

architecture rtl of mod_shaper is 
	type fbarray is array (0 to G_SHIFTREG_SIZE) of signed(G_MANTISSA_SIZE downto 0);
	signal s_lock				: std_logic;
	signal s_symbol			: std_logic;
	signal s_pulse 			: fbarray := (others=>(others=>'0'));
	signal cnt     			: integer range 0 to 16;
	
	begin
		
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
	
	synced: process(i_clk)
		
	begin
	
		if(i_clk'event and i_clk = '1') then

					if(i_rst = '1') then
					cnt <= 0;
					s_lock <= '0';
					s_symbol <= '0';
					o_result <= (others=>'0');
					o_valid <= '0';
				else			
				if(i_data_valid = '1' and s_lock= '0') then	
					cnt <= 0;
					s_lock <= '1';
					o_valid <= '0';
					s_symbol <= i_symbol;
				
				elsif (i_data_valid = '1' and s_lock = '1' and s_symbol = '0') then
					o_valid <= '1';
					if cnt < 16 then
						cnt <= cnt + 1;
					end if;
					o_result <=std_logic_vector(s_pulse(cnt));
					
				
				elsif (i_data_valid = '1' and s_lock = '1' and s_symbol = '1') then
					o_valid <= '1';
					if cnt < 16 then
						cnt <= cnt + 1;
					end if;
					o_result <= std_logic_vector(-s_pulse(cnt));
				end if;
					
				if ( cnt = 16) then
					--cnt <= 0;
					s_lock <= '0';
					s_symbol <= i_symbol;
				end if;	
				
				if(i_data_valid = '0') then
					o_valid <= '0';

				end if;
					

				end if;
		end if;
			
	end process;
	
end architecture;