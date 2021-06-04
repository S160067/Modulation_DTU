-- Quartus Prime VHDL Template
-- Basic Shift Register

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY mix_mult IS
	GENERIC (
		data_width : NATURAL := 14
        );

	PORT (
      clk : In std_logic;
      mod_enable : std_logic;
		modded_signal : IN std_logic_vector(data_width - 1 DOWNTO 0);
      carrier_wave : IN std_logic_vector(data_width - 1 DOWNTO 0);
		data_out : OUT std_logic_vector(data_width - 1 DOWNTO 0)
	); 
END ENTITY;


ARCHITECTURE rtl OF mix_mult IS
    function 	mult( a, b : signed(data_width-1 downto 0)) return signed is 
						
    variable v_r :signed((2*data_width)-1 downto 0);
    variable auxmax, auxmin :signed(data_width downto 0);
    
    begin
    v_r := a*b;
    auxmax := to_signed(32767, data_width+1);
    auxmin := to_signed(-32768, data_width+1);
    
    if v_r(v_r'length-1) = '1' then
        if v_r(v_r'length-1) = '0' then
            return auxmax;
        else 
            return (v_r(v_r'length-1) & v_r(2*data_width-1 downto data_width+1));
        end if;
        
    else
        if v_r(2*(data_width-1)) = '1' then
            return auxmin;
        else
             return (v_r(v_r'length-1) & v_r(2*data_width-1 downto data_width+1));
        end if;
    end if;
end mult;	

BEGIN
process(clk)
begin
if(rising_edge(clk)) then
    if(mod_enable = '1') then
        data_out <=carrier_wave; --std_logic_vector(mult(signed(carrier_wave), signed(modded_signal)));
    else  
        data_out <= carrier_wave;
    end if;    
end if;
end process;

END rtl;