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
        gt : out std_logic;
    );
end question_one;

--architecture
architecture model of question_one is 
begin
    
    --PART C; unsimplified equation
    --GT = !A1A0!B1!B0 + A1!A0!B1!B0 + A1!A0!B1B0 + A1A0!B1!B0 + A1A0!B1B0 + A1A0B1!B0
    gt <= ((NOT a1 AND a0 AND NOT b1 AND NOT b0) OR (A1 AND NOT a0 AND NOT b1 AND NOT b0) OR (a1 AND NOT a0 AND NOT b1 AND b0) OR (a1 AND a0 AND NOT b1 AND NOT b0) OR (a1 AND a0 AND NOT b1 AND b0) OR (a1 AND a0 AND b1 AND NOT b0));

end model;