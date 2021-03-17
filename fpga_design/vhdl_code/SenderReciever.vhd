
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity SenderReciever is
port (
		clk						: in std_logic;
		reset						: in std_logic;
		hej : in std_logic;
		hejhaj : out std_logic
		);
end SenderReciever;



architecture arc of SenderReciever is


begin

	process(hej)
		begin
			hejhaj <= '0';
			if hej = '1' then
				hejhaj <= '1';
			end if;
	end process;

--		process(clk,reset)		 
--        if rising_edge(clk) then
--            if reset = '1' then
--               
--            else
--               hejhaj <= '1';
--            end if;
--        end if;
--    end process ;
				


end arc;