
entity Mod_interface_RX is
	generic (
  	pulse_width: integer :=17;
   	standoff: integer := 0
   	);
   port (
   	clk 			: in std_logic;
   	reset			: in std_logic;
   	 fifo_full 		: in std_logic;
   	data_o 			: out std_logic;
   	fifo_write 		: out std_logic;


   	re_i			: in std_logic;
   	im_i 			: in std_logic;
    valid_i	: in std_logic		--note: valid_i is  re_valid && im_valid	
    );
end Mod_interface_RX;

architecture rtl of Mod_interface_RX is
--declarations
signal data_reg : std_logic;
signal valid_reg : std_logic;

begin
--assignments

--------------------------------------------------
shiftreg: process(clk)
begin
if(rising_edge(clk)) then
	if(reset = '1') then
		symbol_cnt <= (others=>'0');
		data_sr <= (others=>'0');
		data_available <= '0';
	else
		fifo_read <= '0';
		if(fifo_full <= '1')
			if(valid_i) then
				fifo_read <= '1';
				data_o <= re_i;
				data_reg <=  im_i;
			elsif (valid_reg = '1') then
				data_o <= data_reg;	
				fifo_read <= '1'; 
				valid_reg <='0';		
			end if; 
		end if;
	end if;	
end if;
end process;

end rtl; 
