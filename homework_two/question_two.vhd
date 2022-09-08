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
        y : out std_logic;
    );
end question_two;

--architecture
architecture model of question_two is 
begin
    
    --PART A; Simple Assignment Statements
    --y = a!s + sb
    y <= ((a AND NOT s) OR (s AND b));

end model;
