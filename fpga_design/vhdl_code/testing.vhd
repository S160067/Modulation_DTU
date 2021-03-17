--------------------------------------------------
-- AND gate (ESD book figure 2.3)		
-- two descriptions provided
--------------------------------------------------

-- TEST FILE

library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity AND_ent is
port(	x: in std_logic;
	y: in std_logic;
	F: out std_logic
);
end AND_ent;  

--------------------------------------------------

architecture behav2 of AND_ent is
begin

    F <= x or y;

end behav2;

--------------------------------------------------