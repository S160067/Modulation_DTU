library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity testbench is
end testbench;

architecture structure of testbench is
    component SenderReciever
        port(
            clk : in  std_logic;
            reset  : in std_logic;
					hej : in std_logic;
		hejhaj : out std_logic
        );
    end component;

	signal clk, reset, hej, hejhaj : std_logic;

begin
    DUT : SenderReciever
        port map(
            clk        => clk,
            reset => reset,
                hej => hej,
                hejhaj => hejhaj
            );

    start_logic : process
    begin
			wait for 10 ns;
			hej <= '1';
			wait for 10 ns;
			hej <= '0';
		end process;



end structure;