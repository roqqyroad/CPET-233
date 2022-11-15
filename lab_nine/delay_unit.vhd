--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Eight - Delay Unit
--Summary: Takes a clock cycle pulse at the interval defined by its delay input; which is selected by delay_mux

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--START OF ENTITY
entity delay_unit is
    port( 
        --INPUTS
        clk, reset_n : in std_logic;
        max_value : in std_logic_vector(27 downto 0); --retrieved from delay_mux in the slides this is a constant that is equal to a half second
        
        --OUTPUTS
        flag : out std_logic --this flag will be raised every time max_value is hit
    );
end delay_unit;
--END OF ENTITY

--START OF ARCHITECTURE
architecture behavioral of delay_unit is 
    
    --SIGNALS
    signal count : unsigned(27 downto 0);
    --END OF SIGNALS

   begin
      
       --START OF FIRST SET OF NESTED IF's
    process(clk, reset_n, max_value) is
    begin 
        if (reset_n = '0') then --if reset is active (active low)
            count <= (others => '0'); --then reset count
        
        elsif (clk'event and clk = '1') then --when we have a rising clock edge;
            
            if(count = unsigned(max_value)) then
                count <= (others => '0'); --our value of count is reset
            
            else 
                count <= count + 1; --count increases
            
            end if;--close embedded if
                
        end if; --close outer if
            
    end process; --close process

            --START OF SECODN SET OF NESTED IF's
    process (clk, reset_n, max_value)
    begin
        if (reset_n = '0') then
            flag <= '0'; --when reset flag is inactive.
        
        elsif (clk'event and clk = '1') then --if theres a rising edge on the clock
            
            if (count = unsigned(max_value)) then --if count == max_value
                flag <= '1'; --the value desired has passed, so raise the flag
            
            else 
                flag <= '0'; --else count goes up one
            
            end if; --close embedded if
                
        end if; --close whole if
            
    end process; --close process
            
end behavioral;
--END OF ARCHITECTURE
