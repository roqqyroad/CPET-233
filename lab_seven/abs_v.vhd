--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Six - Absolute Value

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity abs_v is
    port(
        --INPUTS
        num : in std_logic_vector(7 downto 0);

        --OUTPUTS
        abs_num : out std_logic_vector(7 downto 0)
    );
end abs_v;

architecture model of abs_v is

    --CONSTANTS
    constant one : std_logic := '1';
    
begin
    
    abs_num <= (not (num) + "00000001");

end model;

