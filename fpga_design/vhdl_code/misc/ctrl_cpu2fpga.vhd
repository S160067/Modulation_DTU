library ieee;
use ieee.std_logic_1164.all;
entity ctrl_cpu2FPGA is
	generic (
  	msg_width: integer :=8
   	);
   port (
   	clk 			: in  std_logic;
   	reset			: in  std_logic;
   	--To blocks
   	crypto_valid		: out std_logic;
   	framing_valid	: out std_logic;
   	mod_valid		  : out std_logic;
   	Crypto_msg		: out  std_logic_vector(msg_width-1 downto 0);
   	Framing_msg		: out  std_logic_vector(msg_width-1 downto 0);
   	mod_msg		   	: out  std_logic_vector(msg_width-1 downto 0);
   	--Avalon interface
   	Avalon_data		: in std_logic_vector(msg_width-1 downto 0);
    avalon_empty  : in std_logic;
   	Avalon_read	: out std_logic
    );
end ctrl_cpu2FPGA;

architecture rtl of ctrl_fpga2cpu is
--declarations
signal empty_vector_array, scheduling_mask, scheduling_array : std_logic_vector(2 downto 0);
signal group_id : std_logic_vector(1 downto 0);
signal mod_write, crypto_write, framing_write : std_logic;
begin
--assignments
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
    write_reg <= Avalon_read;
    if(avalon_empty = '0') then 
    Avalon_read <= '1';
    end if;
    if(read_reg) then
     if group_id = "01" then
       Crypto_msg <= Avalon_data;
       crypto_valid <= '1';
     elsif group_id = "10" then
       framing_msg <= Avalon_data;
       framing_valid <= '1';    
     elsif group_id = "11" then
		 mod_msg <= Avalon_data;
       mod_valid <= '1';
    end if; 	 
	 end if;
	end if;	
end if;
end process;

end rtl; 
