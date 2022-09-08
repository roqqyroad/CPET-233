--Name: Rachel DuBois
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
entity question_one is
    port(
        --inputs
        a1, a0, b1, b0 : in std_logic;

        --output
        gt : out std_logic
    );
end question_one;

--architecture
architecture model of question_one is 
begin
    
    --PART C; unsimplified equation
    --GT = !A1A0!B1!B0 + A1!A0!B1!B0 + A1!A0!B1B0 + A1A0!B1!B0 + A1A0!B1B0 + A1A0B1!B0
    --gt <= ((NOT a1 AND a0 AND NOT b1 AND NOT b0) OR (A1 AND NOT a0 AND NOT b1 AND NOT b0) OR (a1 AND NOT a0 AND NOT b1 AND b0) OR (a1 AND a0 AND NOT b1 AND NOT b0) OR (a1 AND a0 AND NOT b1 AND b0) OR (a1 AND a0 AND b1 AND NOT b0));

	 --Part g; putting in the new equation from the compilation
	 gt <= ((NOT a1 AND (NOT b1 AND (a0 AND NOT b0))) OR (a1 AND ((NOT b1) OR (a0 AND NOT b0))));
	 
end model;
