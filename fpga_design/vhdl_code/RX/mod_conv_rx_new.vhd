library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mod_conv_rx_new is 
generic (
constant G_SHIFTREG_SIZE 	    : positive := 16;
constant G_MANTISSA_SIZE	    : positive := 13
);

port(
i_rst						    	: in std_logic;
i_clk 						  	: in std_logic;
i_data_valid				  	: in std_logic;
i_element				    	: in std_logic_vector(G_MANTISSA_SIZE downto 0);
o_result					    : out std_logic_vector(G_MANTISSA_SIZE downto 0);
o_valid						  	: out std_logic
);



function 	mult( a, b : signed(G_MANTISSA_SIZE downto 0)) return signed is 

variable v_r :signed(2*G_MANTISSA_SIZE+1 downto 0);
variable auxmax, auxmin :signed(G_MANTISSA_SIZE downto 0);

begin
v_r := a*b;
auxmax := to_signed(8191, G_MANTISSA_SIZE+1);
auxmin := to_signed(-8192, G_MANTISSA_SIZE+1);

if v_r(2*G_MANTISSA_SIZE+1) = '1' then
	if v_r(2*G_MANTISSA_SIZE) = '0' then
		return auxmin;
	else 
		return (v_r(2*G_MANTISSA_SIZE+1) & v_r(2*G_MANTISSA_SIZE-1 downto G_MANTISSA_SIZE));
	end if;

else
	if v_r(2*G_MANTISSA_SIZE) = '1' then
		return auxmax;
	else
		 return (v_r(2*G_MANTISSA_SIZE+1) & v_r(2*G_MANTISSA_SIZE-1 downto G_MANTISSA_SIZE));
	end if;
end if;
end mult;	


end mod_conv_rx_new;	

architecture rtl of mod_conv_rx_new is 

type fbarray is array (0 to G_SHIFTREG_SIZE) of signed(G_MANTISSA_SIZE downto 0);
signal element : signed(G_MANTISSA_SIZE downto 0);
signal s_sregis 			: fbarray := (others=>(others=>'0'));
signal s_mult				: fbarray := (others=>(others=>'0'));
signal s_pulse 			: fbarray := (others=>(others=>'0'));
signal s_sum				: signed(G_MANTISSA_SIZE+4 downto 0);

begin
element <= signed(i_element) -8191;

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

shiftregs: process(i_clk) 

variable sumvar : signed(G_MANTISSA_SIZE+4 downto 0);

begin

if(i_clk'event and i_clk = '1') then

	s_sregis(1 to G_SHIFTREG_SIZE-1) <= s_sregis(0 to G_SHIFTREG_SIZE-2);

	if (i_data_valid = '1') then

		s_sregis(0) <= element;
		
	end if;
	
	sumvar := (others=> '0');
	
	for i in 0 to G_SHIFTREG_SIZE-1 loop
		
			sumvar := sumvar + resize(s_mult(i), sumvar'length);

	end loop;
	
	s_sum <= sumvar;
	
	if(i_rst = '1') then

		s_sregis <= (others=>(others=>'0'));
		s_sum <= (others => '0');

	end if;

end if;

end process;

arith: process(i_element, s_sregis, s_mult, s_sum, i_data_valid, i_rst) 
begin

s_mult <= (others =>(others => '0'));

for i in 0 to G_SHIFTREG_SIZE-1 loop

s_mult(i) <= mult(s_sregis(i), s_pulse(i));

end loop;

o_result <= std_logic_vector(s_sum(G_MANTISSA_SIZE downto 0));
o_valid <= i_data_valid;


if(i_rst = '1') then
s_mult <= (others =>(others => '0'));
o_result <= (others => '0');
o_valid <= '0';

end if;
end process;
end architecture;