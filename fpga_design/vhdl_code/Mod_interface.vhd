
entity Mod_interface_TX is
	generic (
  	pulse_width: integer :=17;
   	standoff: integer := 0
   	);
   port (
   	clk 			: in std_logic;
   	reset			: in std_logic;
   	data_i 		: in std_logic;
   	fifo_full : in std_logic;
   	fifo_read : out std_logic;


   	re_o			: out std_logic;
   	im_o 			: out std_logic;
    enable_o	: out std_logic	
    );
end Mod_interface_TX;

architecture rtl of Mod_interface_TX is
--declarations
signal counter : std_logic_vector(4 downto 0);
signal symbol_cnt : std_logic_vector(1 downto);
signal data_sr : std_logic_vector(1 downto 0);
signal data_available : std_logic;
signal int_read : std_logic;		--internal flag to signal that read is high
begin
--assignments

re_o <= data_sr(1);
im_o <= data_sr(0);
fifo_read <= int_read;
--------------------------------------------------
shiftreg: process(clk)
begin
if(rising_edge(clk)) then
	if(reset = '1') then
		symbol_cnt <= (others=>'0');
		data_sr <= (others=>'0');
		data_available <= '0';
	else
		if(data_available <= '0' or data_read = '1') then
			if(symbol_cnt < 2)
				symbol_cnt <= (others=>'0');
				data_available <= '1';
			else
				data_available <= '0';
				symbol_cnt <= symbol_cnt +1;
			end if;	
		end if;
	end if; 
end if;	
end process;
FSM:process(clk)
begin
if(rising_edge(clk)) then
	if(reset = '1') then

	end if;

end if;
end process;
end rtl; 
