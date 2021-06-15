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
signal re_valid_reg,re_reg : std_logic;
signal im_valid_reg,im_reg : std_logic;

begin
--assignments

--------------------------------------------------
shiftreg: process(clk)
begin
if(rising_edge(clk)) then
	if(reset = '1') then
		data_o <= (others=>'0');
		valid_o <= '0';
    re_valid_reg <=
	else
  if(re_valid_i = '1')then
      re_valid_reg <= '1';
  end if;
  if(im_valid_i = '1')then
      im_valid_reg <= '1';
  end if;
  if((im_valid_i & re_valid_i) = "11") then
      data_o <= re_i & im_i;
      re_valid_reg <= '0';
      im_valid_reg <= '0';
  elsif ((im_valid_reg & re_valid_reg) = "11") then
      data_o <= re_reg & im_reg;
      re_valid_reg <= '0';
      im_valid_reg <= '0';
  end if;  
end if;
end if;	
end process;

end rtl; 
