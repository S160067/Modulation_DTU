library ieee;
use ieee.std_logic_1164.all;

entity status_control_manager is
port (
	clk, reset 	: in std_logic;
	
	-- IP cores FIFO 32 bit status output
	status_data 	: out std_logic_vector(31 downto 0);
	status_full		: in std_logic;
	status_wrreq	: out std_logic;
	
	--Status FIFO from encryption
	status_encr_data 	: in std_logic_vector(23 downto 0);
	status_encr_rdreq	: out std_logic;
	status_encr_empty	: in std_logic;

	--Status FIFO from error correction
	status_error_data 	: in std_logic_vector(23 downto 0);
	status_error_rdreq	: out std_logic;
	status_error_empty	: in std_logic;

	--Status FIFO from modulation
	status_modulation_data 	: in std_logic_vector(23 downto 0);
	status_modulation_rdreq	: out std_logic;
	status_modulation_empty	: in std_logic
);
end status_control_manager;

architecture manager_arch of status_control_manager is

type statusstate is (NONE, ENCR,ERROR,MODULATION);
signal selector : statusstate;
signal data : std_logic_vector(31 downto 0);

begin

status_data <= data;

-- Checking all 24 bit fifos to determine which one to send to ARM
process(status_full, status_encr_empty, status_error_empty, status_modulation_empty)
begin
	status_error_rdreq <= '0';
	status_encr_rdreq <= '0';
	status_modulation_rdreq <= '0';
	
	if (status_full = '0') then
		if (status_encr_empty = '0') then
			selector <= ENCR;
			status_encr_rdreq <= '1';			
		elsif (status_error_empty = '0') then
			selector <= ERROR;
			status_error_rdreq <= '1';			
		elsif (status_modulation_empty = '0') then
			selector <= MODULATION;
			status_modulation_rdreq <= '1';			
		else
			selector <= NONE;
		end if;
	else
			selector <= NONE;
	end if;
end process;
	
process(clk, reset)
begin
	if reset='0' then 
		status_wrreq <= '0';
	elsif rising_edge(clk) then
		case selector is
		when NONE =>
			status_wrreq <= '0';
			data <= x"00000000";
		when ENCR =>
			status_wrreq <= '1';
			data <= (x"01" & status_encr_data);
		when ERROR =>
			status_wrreq <= '1';
			data <= (x"02" & status_error_data);
		when MODULATION =>
			status_wrreq <= '1';
			data <= (x"03" & status_modulation_data);

		end case;
	end if;
end process;

end manager_arch ;

