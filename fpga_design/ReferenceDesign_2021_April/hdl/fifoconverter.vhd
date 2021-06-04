-- This entity converts input from an Avalon FIFO to a "normal" /classic IP cores FIFO
library ieee;
use ieee.std_logic_1164.all;


entity fifo_convert_avalon_to_classic is
	generic
	(
		width	: integer  :=	8
	);

	port
	(
		clk, reset	: in  std_logic;
		
		-- Avalon FIFO read side port
		avalon_data		: in std_logic_vector(width-1 downto 0);
		avalon_rdreq	: out std_logic;
		avalon_empty	: in std_logic;
		
		-- IP cores FIFO write port
		classic_data	: out std_logic_vector(width-1 downto 0);
		classic_wrreq	: out std_logic;
		classic_full	: in std_logic);
end fifo_convert_avalon_to_classic;


library ieee;
use ieee.std_logic_1164.all;

entity fifo_convert_classic_to_avalon is
	generic
	(
		width	: integer  :=	8
	);

	port
	(
		clk, reset	: in std_logic;
		
		-- IP cores FIFO write port
		classic_data	: in std_logic_vector(width-1 downto 0);
		classic_rdreq	: out std_logic;
		classic_empty	: in std_logic;
		
		-- Avalon FIFO write side port
		avalon_data		: out std_logic_vector(width-1 downto 0);
		avalon_wrreq	: out std_logic;
		avalon_full		: in std_logic);		
end fifo_convert_classic_to_avalon;






architecture to_classic_arch of fifo_convert_avalon_to_classic is

type readystate is (READY,WRITEREQ,WAITING);
signal txwait, txwait_next : readystate;

begin

classic_data <= avalon_data;

gen_rdreq_wrreq : process(avalon_empty, txwait,classic_full)
begin
	classic_wrreq <= '0';
	avalon_rdreq <= '0';
case txwait is
	when READY =>
		if (avalon_empty='0') then
			txwait_next <= WRITEREQ;
			avalon_rdreq <= '1';
		else
			txwait_next <= READY;
		end if;
	when WRITEREQ =>
		classic_wrreq <='1';
		txwait_next <= WAITING;
	when WAITING =>
		if (classic_full='0') then
			txwait_next <= READY;
		else 
			txwait_next <= WAITING;
		end if;
	when others =>
		txwait_next <= WAITING;
end case;
end process;
					
process(clk, reset)
begin
	if reset = '0' then
		txwait <= WAITING;
	elsif rising_edge(clk) then
		txwait <= txwait_next;
	end if;
end process;
end to_classic_arch;


architecture to_avalon_arch of fifo_convert_classic_to_avalon is

type readystate is (READY,WRITEREQ,WAITING);
signal rxwait, rxwait_next : readystate;

begin

avalon_data <= classic_data;

gen_rdreq_wrreq_rx: process(classic_empty, rxwait, avalon_full)
begin
	classic_rdreq <= '0';
	avalon_wrreq <= '0';		
case rxwait is 
	when READY =>
		if (classic_empty='0') then
			rxwait_next <= WRITEREQ;
			classic_rdreq <= '1';
		else
			rxwait_next <= READY;
		end if;
	when WRITEREQ => 
		avalon_wrreq <= '1';
		rxwait_next <= WAITING;
	when WAITING =>
		if (avalon_full='0') then
			rxwait_next <= READY;
		else 
			rxwait_next <= WAITING;
		end if;
	when others =>
		rxwait_next <= WAITING;
end case;
end process;

					
process(clk, reset)
begin
	if reset = '0' then
		rxwait <= WAITING;
	elsif rising_edge(clk) then
		rxwait <= rxwait_next;
	end if;
end process;

end to_avalon_arch;
	
	

