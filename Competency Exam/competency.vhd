--Section: 02
--Lab: 02
--Assignment: Lab Competency One

---------------------------------------------------------------

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--end of libraries

---------------------------------------------------------------

--entity
entity competency is

	port(
	
		--inputs
		g, h, i : in std_logic;
	
	
		--outputs
		y : out std_logic
		
	);
	
end competency;
--end of entity

---------------------------------------------------------------

--architecture
architecture model of competency is

	--signal for inputs
    signal inputs : std_logic_vector(2 downto 0);
	
--beginning of architecture
begin

	--concatenation of inputs
	inputs <= g & h & i;
	
	--conditional signal assignment of y
	y <= '1' when inputs = "000" or inputs = "010" or inputs = "100" or inputs = "110" 
        else '0';
		  
end model;
--end of architecture