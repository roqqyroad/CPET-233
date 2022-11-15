


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
        max_val : out std_logic_vector(27 downto 0)
    );
end delay_mux;
--END OF ENTITY

--START OF ARCHITECTURE
architecture behave of delay_mux is
    --constants
    constant ms : unsigned (27 downto 0) := x"2FAF07F"; --equal to 1s (ONE SECOND)
    constant ns : unsigned (27 downto 0) := x"0000004"; --equal to 100ns (NANO)
    --counts = delay / clock

    --END OF constant 
begin

    --START OF IF PROCESS
    process(s) is
    begin  
        if (s = '1') then --when s is 1
            max_val <= std_logic_vector((ms)); --we work in s  (excuse the incorrect name)
        
        else
            max_val <= std_logic_vector((ns)); --otherwise we work in ns
        
        end if; --close if
            
    end process;
    --END OF IF PROCESS
    
end behave;
--END OF ARCHITECTURE
