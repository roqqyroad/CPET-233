--Section: 02
--Lab: 02
--Assignment: Homework Two; Question Two
--Due Date: September 8, 2022; 11:59PM EST
--Completion: September 8, 2022 5:50PM EST


--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity
entity question_two is
    port(
        --inputs
        a, b, s : in std_logic;

        --output
        y : out std_logic
    );
end question_two;

--architecture
architecture model of question_two is 
	signal and1, and2 : std_logic;
begin
    
    --PART A; Simple Assignment Statements
    --y = a!s + sb
    --y <= ((a AND NOT s) OR (s AND b));

	 --Part C; two internal signals
	 --and1 <= a AND NOT s;
	 --and2 <= s AND b;
	 --y <= and1 OR and2;
	 
	 --Part E; rearrangements
	 --y <= and1 OR and2;
	 --and1 <= a AND NOT s;
	 --and2 <= s AND b;
	 
	 --Part G; rearrangements again
	 y <= and1 OR and2;
	 and2 <= s AND b;
	 and1 <= a AND NOT s;
	 
	 
end model;
