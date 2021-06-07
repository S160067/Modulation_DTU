library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod_deshaper is 
	generic (
		constant G_SHIFTREG_SIZE 			: positive := 16;
		constant G_MANTISSA_SIZE			: positive := 13
		);
		
		port(
		i_rst										: in std_logic;
		i_clk 									: in std_logic;
		i_data_valid							: in std_logic;
		i_sample									: in signed(G_MANTISSA_SIZE downto 0);
		o_symbol									: out std_logic;
		o_valid									: out std_logic
		);	

end mod_deshaper;	

architecture rtl of mod_deshaper is 

	type fbarray is array (0 to G_SHIFTREG_SIZE) of signed(G_MANTISSA_SIZE downto 0);
	signal s_lock				: std_logic;
	signal s_sum 				: signed(G_MANTISSA_SIZE+4 downto 0);
	signal cnt     			: integer range 0 to 16;
	
	begin
	
	synced: process(i_clk)

		
	begin
	
		if(i_clk'event and i_clk = '1') then
		
				if(i_data_valid = '1' and s_lock= '0') then	
					cnt <= 0;
					s_sum <= (others =>'0');
					s_lock <= '1';
					o_valid <= '0';
				
				elsif (i_data_valid = '1' and s_lock = '1') then
				
					if (cnt > 5 and cnt < 11) then
					
						s_sum <= s_sum + i_sample;
						
					end if;
					
					
					if (i_data_valid = '1' and cnt = 16) then
					
						s_lock <= '0';
						o_valid <= '1';
						o_symbol <= s_sum(G_MANTISSA_SIZE+4);
				
					else
					
						if(i_data_valid = '1') then
							cnt <= cnt + 1;	
						end if;
						
					end if;
					
				end if;
					
				if(i_rst = '1') then
				
					cnt <= 0;
					o_symbol <= '0';
					s_lock <= '0';
					s_sum <= (others =>'0');
					o_valid <= '0';
					
				end if;
				
		end if;
			
	end process;
	
end architecture;