
entity ctrl_cpu2FPGA is
	generic (
  	msg_width: integer :=8
   	);
   port (
   	clk 			: in  std_logic;
   	reset			: in  std_logic;
   	--To blocks
   	crypto_empty		: out std_logic;
   	framing_empty	: out std_logic;
   	mod_empty		  : out std_logic;
   	Crypto_msg		: out  std_logic_vector(msg_width-1 downto 0);
   	Framing_msg		: out  std_logic_vector(msg_width-1 downto 0);
   	mod_msg		   	: out  std_logic_vector(msg_width-1 downto 0);
   	--Avalon interface
   	Avalon_data		: in std_logic_vector(msg_width-1 downto 0);
   	Avalon_read	: out std_logic
    );
end ctrl_cpu2FPGA;

architecture rtl of ctrl_fpga2cpu is
--declarations
signal empty_vector_array, scheduling_mask, scheduling_array : std_logic_vector(2 downto 0);
signal crypto_empty, framing_empty, mod_empty : std_logic;
signal group_id : std_logic_vector(1 downto 0);
signal mod_write, crypto_write, framing_write : std_logic;
begin
--assignments
empty_vector_array <= crypto_empty & framing_empty & mod_empty;
group_id <= Avalon_data(msg_width-1 downto msg_width-2);
--------------------------------------------------
Decoding: process(clk)
begin
if(rising_edge(clk)) then
	if(reset = '1') then
		Avalon_data <= (others=>'0');
		Avalon_write <= (others=>'0');
		data_available <= '0';
		scheduling_mask <= (others=>'0');
	else
    crypto_write <= '0';
    framing_write<= '0';
    mod_write<= '0';
    
		case group_id is
    when b"01" => crypto_write <= '1';
    when b"10" => framing_write <= '1'; 
    when b"11" => mod_write <= '1';      
    when others => mod_write <= '0';
 		end case;
	end if;	
end if;
end process;

end rtl; 
