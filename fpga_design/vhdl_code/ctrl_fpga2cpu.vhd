
entity ctrl_fpga2cpu is
	generic (
  	msg_width: integer :=16
   	);
   port (
   	clk 			: in  std_logic;
   	reset			: in  std_logic;
   	--To blocks
   	crypto_full		: out std_logic;
   	framing_full	: out std_logic;
   	mod_full		: out std_logic;
   	Crypto_write 	: in  std_logic;
   	Framing_write 	: in  std_logic;
   	mod_write		: in  std_logic;
   	Crypto_msg		: in  std_logic_vector(msg_width-1 downto 0);
   	Framing_msg		: in  std_logic_vector(msg_width-1 downto 0);
   	mod_msg			: in  std_logic_vector(msg_width-1 downto 0);
   	--Avalon interface
   	Avalon_data		: out std_logic;
   	Avalon_write	: out std_logic;
    ready_i			: in  std_logic		--note: valid_i is  re_valid && im_valid	
    );
end ctrl_fpga2cpu;

architecture rtl of ctrl_fpga2cpu is
--declarations
signal empty_vector_array, scheduling_mask, scheduling_array : std_logic_vector(2 downto 0);
signal crypto_empty, framing_empty, mod_empty : std_logic;

begin
--assignments
empty_vector_array <= crypto_empty & framing_empty & mod_empty;
--------------------------------------------------
Scheduling: process(clk)
begin
if(rising_edge(clk)) then
	if(reset = '1') then
		Avalon_data <= (others=>'0');
		Avalon_write <= (others=>'0');
		data_available <= '0';
		scheduling_mask <= (others=>'0');
	else
		scheduling_array <= empty_vector_array AND scheduling_mask;

		
	end if;	
end if;
end process;

end rtl; 
