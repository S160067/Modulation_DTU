library ieee;
USE ieee.std_logic_1164.ALL;
entity Mod_interface_RX is
	generic (
  	pulse_width: integer :=17;
   	standoff: integer := 0
   	);
   port (
   	clk 			: in std_logic;
   	reset			: in std_logic;
   	data_o 			: out std_logic_vector(1 downto 0);
   	valid_o 		: out std_logic;

   	re_i			: in std_logic;
   	im_i 			: in std_logic;
	  re_valid_i	: in std_logic;		--note: valid_i is  re_valid && im_valid	
    im_valid_i	: in std_logic	
    );
end Mod_interface_RX;

architecture rtl of Mod_interface_RX is
--declarations
begin
--assignments

--------------------------------------------------
shiftreg: process(clk)
begin
if(rising_edge(clk)) then
	if(reset = '1') then
		data_o <= (others=>'0');
		valid_o <= '0';
	else
		data_o <= re_i & im_i;
		valid_o <= re_valid_i and im_valid_i;
	end if;
end if;	
end process;

end rtl; 
