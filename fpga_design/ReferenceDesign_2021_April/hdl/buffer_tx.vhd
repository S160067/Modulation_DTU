library ieee;
use ieee.std_logic_1164.all;

-- Buffer on transmitter side
-- read_en, fifo_empty, read_en : FIFO signals
-- data_mod : data bits to modulate
-- ready: high when modulator can recieve data

entity buffer_tx is
port (
	clk, reset : in std_logic;
	bitstream, fifo_empty : in std_logic;
	read_en : out std_logic;
	data_out : out std_logic_vector(1 downto 0)
	);
end buffer_tx;

<<<<<<< Updated upstream
 architecture arch of buffer_tx is 
=======
architecture arch of buffer_tx is 
>>>>>>> Stashed changes

signal reg1,reg2,regC,regV,regV_next, reg1_next,reg2_next, regC_next, reg1_en, reg2_en : std_logic;

begin

<<<<<<< Updated upstream
	data_out <= bitstream & '1' when fifo_empty = '0' else "00";
=======
data_out <= reg1 & reg2;

reg1_next <= bitstream; 
reg2_next<= bitstream;

regV_next <= regC;

regC_next <= '1' when regC ='0'
	else '0';


	reg1_en <='1' when regC ='0'
	else '0';
	
	reg2_en <='1' when regC ='1'
	else '0';

	
	PROCESS (clk)
	begin if reset = '1' then  
	reg1 <= '0';
	reg2 <= '0';
	regC <='0';
	
		elsif rising_edge(clk) then
			 	
			if fifo_empty = '0' then 
				regC <= regC_next;
				regV<= regV_next;
			
			end if;
	
			if reg1_en ='1' then
				reg1 <= reg1_next;
			end if;
	
			if reg2_en ='1' then
				reg2 <= reg2_next;
			end if;	
	end if;
	end process;
end arch;
>>>>>>> Stashed changes

