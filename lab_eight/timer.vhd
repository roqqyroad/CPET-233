--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Eight - Timer
--Summary: Highest up unit for the execution of Lab Eight. A functional timer.

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--START OF ENTITY
entity timer is 
    port(
        --INPUTS
        set_n, s, clk, reset_n : in std_logic;
        timed : in std_logic_vector(9 downto 0);

        --OUTPUTS
        HEX2 : out std_logic_vector(6 downto 0); --for hundreds_dig value
        HEX1 : out std_logic_vector(6 downto 0); --for tens_dig value
        HEX0 : out std_logic_vector(6 downto 0)  --for ones_dig value
    );
end timer;
--END OF ENTITY

--START OF ARCHITECTURE
architecture structure of timer is 

    --SIGNALS
	signal s_max_val : std_logic_vector(27 downto 0);
	signal s_in_num : std_logic_vector(9 downto 0);
	signal s_flag : std_logic;
	signal s_count : std_logic_vector(9 downto 0);
    --END OF SIGNALS
    
    --COMPONENTS
    
    --START OF delay_mux
    component delay_mux is
        port(
            --INPUTS 
            s : in std_logic;
		
            --OUTPUTS 
            max_val : out std_logic_vector(27 downto 0)
            --Will have two constants for 100ms and 100ns
        );
    end component;
    --END OF delay_mux

    --START OF delay_unit
    component delay_unit is
        port(
            --INPUTS 
            clk, reset_n : std_logic;
            max_value : in std_logic_vector(27 downto 0);
		
            --OUTPUTS 
            flag : out std_logic
        );
    end component;
    --END OF delay_unit

    --START OF counter
    component counter is
        port(
            --INPUTS 
            clk, reset_n, enable, set_n : in std_logic;
            timed : in std_logic_vector(9 downto 0);
		
            --OUTPUTS 
            count : out std_logic_vector(9 downto 0)
        );
    end component;
    --END OF counter
    
    --START OF binary_to_ssd
    component binary_to_ssd is
        port(
            --INPUTS
            in_num : in std_logic_vector(9 downto 0);

            --OUTPUTS
            HEX2 : out std_logic_vector(6 downto 0); --for hundreds_dig value
            HEX1 : out std_logic_vector(6 downto 0); --for tens_dig value
            HEX0 : out std_logic_vector(6 downto 0)  --for ones_dig value
        );
    end component;
    --END OF binary_to_ssd

    --END OF COMPONENTS
--ARCHITECTURE ACTUALLY BEGINS
begin
    
    --PORT MAPS

    --START OF delay_mux PORT MAP
    dm : delay_mux
    port map(
        --INPUTS 
	s => s,
	    
        --OUTPUTS 
	max_val => s_max_val
    );
    --END OF delay_mux PORT MAP

    --START OF delay_unit PORT MAP
    du : delay_unit
    port map(
        --INPUTS 
	max_value => s_max_val,
	clk => clk,
	reset_n => reset_n,
	    
        --OUTPUTS 
	flag => s_flag
    );
    --END OF delay_unit PORT MAP

    --START OF counter PORT MAP
    count : counter 
    port map(
        --INPUTS 
	set_n => set_n,
	timed => timed,
	enable => s_flag,
	clk => clk,
	reset_n => reset_n,
	    
        --OUTPUTS 
        count => s_count
    );
    --END OF counter PORT MAP

    --START OF binary_to_ssd PORT MAP
    btssd : binary_to_ssd
    port map(
        --INPUTS 
	in_num => s_count,
	    
        --OUTPUTS 
	hex0 => hex0,
	hex1 => hex1,
	hex2 => hex2
    );
    --END OF binary_to_ssd PORT MAP

    --END OF PORT MAPS

end structure;
--END OF ARCHITECTURE
