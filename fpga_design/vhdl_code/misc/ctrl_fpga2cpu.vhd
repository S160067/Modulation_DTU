
entity ctrl_fpga2cpu is
	generic (
  	msg_width: integer :=32
   	);
   port (
   	clk 			: in  std_logic;
   	reset			: in  std_logic;
   	--To blocks
   	crypto_full		: out std_logic;
   	framing_full	: out std_logic;
   	mod_full		  : out std_logic;
   	Crypto_write 	: in  std_logic;
   	Framing_write : in  std_logic;
   	mod_write	  	: in  std_logic;
   	Crypto_msg		: in  std_logic_vector(msg_width-1 downto 0);
   	Framing_msg		: in  std_logic_vector(msg_width-1 downto 0);
   	mod_msg		   	: in  std_logic_vector(msg_width-1 downto 0);
   	--Avalon interface
   	Avalon_data		: out std_logic_vector(msg_width-1 downto 0);
   	Avalon_write	: out std_logic;

    ready_i			: in  std_logic		--note: valid_i is  re_valid && im_valid	
    );
end ctrl_fpga2cpu;

architecture rtl of ctrl_fpga2cpu is
--declarations
signal empty_vector_array, scheduling_mask, scheduling_array : std_logic_vector(2 downto 0);
signal crypto_empty, framing_empty, mod_empty : std_logic;
signal framing_reg, crypto_reg,mod_reg : std_logic_vector(msg_width-1 downto 0);
begin
--assignments
empty_vector_array <= framing_empty & crypto_empty  & mod_empty;
--------------------------------------------------
Scheduling: process(clk)
begin
if(rising_edge(clk)) then
	if(reset = '1') then
		Avalon_data <= (others=>'0');
		Avalon_write <= (others=>'0');
		data_available <= '0';
		scheduling_mask <= "111";
	else
		scheduling_array <= empty_vector_array AND scheduling_mask;
    scheduling_mask <= "111";
    Avalon_write <= '0';
    if(mod_write = '1') then 
        mod_reg <= mod_msg;
        mod_full<= '1';
    end if;
    if(Crypto_write = '1') then 
        mod_reg <= mod_msg;
        mod_full<= '1';
    end if; 
    if(Framing_write = '1') then 
        mod_reg <= mod_msg;
        mod_full<= '1';
    end if;       
    if(not avalon_full) then
        if(scheduling_array(2) = '1') then
            Avalon_data <= framing_reg;
            scheduling_mask(2) <= '0';
            framing_full <= '0';
        elsif (scheduling_array(1) ='1') then
            Avalon_data <= crypto_reg;
            scheduling_mask(2) <= '0';
            crypto_full <= '0';
	     	elsif  (scheduling_array(0) ='1') then
            Avalon_data <= mod_reg;
            scheduling_mask(2) <= '0';
            mod_full <= '0';
        else
            Avalon_data <=  (others=>'0');
    end if;    
    end if;  
	end if;	
end if;
end process;

end rtl; 
