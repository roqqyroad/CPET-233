--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Eight - Delay Mux
--Summary: Selects the delay input for delay_unit. Will select either 1s or 100ns

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--START OF ENTITY
entity delay_mux is 
    port(
        --INPUTS
        s : in std_logic;

        --OUTPUTS
        max_value : out std_logic_vector()
    );
end delay_mux;
--END OF ENTITY

--START OF ARCHITECTURE
architecture behave of delay_mux is
    --CONSTANTS
    constant ms : unsigned ( downto 0) := x"";
    constant ns : unsigned ( downto 0) := x"";
    --END OF CONStANTS 
begin

    --START OF IF PROCESS
    process(s) is
    begin  
        if (s = '0') then
            max_value <= ms;
        else
            max_value <= ns;
        end if;
    end process;
    --END OF IF PROCESS
    
end behave;
--END OF ARCHITECTURE