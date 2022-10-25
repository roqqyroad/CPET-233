--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Six - Absolute Value

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--ENTITY
entity is_neg is
	port(
		num : in std_logic;

		--outputs
		hexx : out std_logic_vector(6 downto 0)
	);
end is_neg;
--END OF ENTITY

--ARCHITECTURE
architecture model of is_neg is 

	--constants
	constant DASH : std_logic_vector(6 downto 0) := "0111111";
	constant BLANK : std_logic_vector(6 downto 0) := "1111111";
begin

	--START OF IF STATEMENT PROCESS 
	--determine whether a value given is negative or positive
	if_statement : process(num)
	begin
		--if num is one then its a negative number
		if (num = '1') then 
			hexx <= DASH;
		--if it isnt one then its positive
		else
			hexx <= BLANK;
		end if;
	end process;
	--END OF IF STATEMENT PROCESS
			
end model;
--END OF ARCHITECTURE
