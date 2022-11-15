--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Nine - Shifting Display
--Summary: Highest level entity of Lab Nine

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--START OF ENTITY
entity shifting_display is 
    port(
        --INPUTS
        s, clk, reset_n : in std_logic;

        --OUTPUTS
        HEX5 : out std_logic_vector(6 downto 0); 
        HEX4 : out std_logic_vector(6 downto 0); 
        HEX3 : out std_logic_vector(6 downto 0); 
        HEX2 : out std_logic_vector(6 downto 0); 
        HEX1 : out std_logic_vector(6 downto 0); 
        HEX0 : out std_logic_vector(6 downto 0)  
    );
end shifting_display;
--END OF ENTITY

--START OF ARCHITECTURE
architecture structure of shifting_display is 

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

    --START OF shifter
    component shifter is
        port(
            --INPUTS 
            clk, reset_n, enable : in std_logic;
            --OUTPUTS 
            HEX5 : out std_logic_vector(6 downto 0); 
            HEX4 : out std_logic_vector(6 downto 0); 
            HEX3 : out std_logic_vector(6 downto 0); 
            HEX2 : out std_logic_vector(6 downto 0); 
            HEX1 : out std_logic_vector(6 downto 0); 
            HEX0 : out std_logic_vector(6 downto 0) 
        );
    end component;
    --END OF shifter
   
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
    shift : shifter 
    port map(
        --INPUTS 
	clk => clk,
	reset_n => reset_n,
	enable => s_flag,
        --OUTPUTS 
	HEX0 => HEX0,
	HEX1 => HEX1,
	HEX2 => HEX2,
	HEX3 => HEX3,
	HEX4 => HEX4,
	HEX5 => HEX5
    );
    --END OF shifter PORT MAP

    --END OF PORT MAPS

end structure;
--END OF ARCHITECTURE
