
--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Six - Binary to SSD
--Summary: Converts a binary value to a value that is able to be displayed on a few hex displays

--EDITED FOR USE IN LAB EIGHT AS WE DO NOT NEED TO ACCOUNT FOR NEGATIVE VALUES

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--START OF ENTITY
entity shifter is
    port(
        --INPUTS
        enable, clk, reset_n : in std_logic;

        --OUTPUTS
        HEX6 : out std_logic_vector(6 downto 0); 
        HEX5 : out std_logic_vector(6 downto 0); 
        HEX4 : out std_logic_vector(6 downto 0); 
        HEX3 : out std_logic_vector(6 downto 0); 
        HEX2 : out std_logic_vector(6 downto 0); 
        HEX1 : out std_logic_vector(6 downto 0); 
        HEX0 : out std_logic_vector(6 downto 0)  
    );
end shifter;
--END OF ENTITY

--START OF ARCHITECTURE
architecture behavior of shifter is

    --TYPES
    type cons_arr is array (0 to 23) of std_logic_vector(6 downto 0);
    --end of types

    --CONSTANTS
    constant II : std_logic_vector(6 downto 0) := "1001111"; --uppercase I
    constant CC : std_logic_vector(6 downto 0) := "1000110"; --uppercase C
    constant EE : std_logic_vector(6 downto 0) := "0000110"; --uppercase E
    constant OO : std_logic_vector(6 downto 0) := "1000000"; --uppercase O
    constant LL : std_logic_vector(6 downto 0) := "1000111"; --uppercase L
    constant DD : std_logic_vector(6 downto 0) := "0100001"; --lowercase d
    constant SS : std_logic_vector(6 downto 0) := "0010010"; --uppercase S
    constant AA : std_logic_vector(6 downto 0) := "0001000"; --uppercase A
    constant HH : std_logic_vector(6 downto 0) := "0001001"; --uppercase H     --constant to reset signal to shift
    constant RR : std_logic_vector(6 downto 0) := "1001110"; --lowercase r
    constant SPACE : std_logic_vector(6 downto 0) := "1111111"; -- SPACES
    constant soda_arr : cons_arr := (II, CC, EE, SPACE, CC, OO, LL, DD, SPACE, SS, OO, DD, AA, SPACE, SS, OO, LL, DD, SPACE, HH, EE, RR, EE, SPACE);
	--an array of logic vectors
    --end of constants

    --SIGNALS
    signal shifts : cons_arr;
    --END OF SIGNALS
    
--architecture actually begins
begin

--SHIFTING PROCESS
    process(enable, clk, reset_n)
    begin

    if(reset_n = '0') then
   	 shifts <= soda_arr; --gives soda arr on reset

    elsif(clk'event and clk = '1') then --when clock rising edge
        if(enable = '1') then 	
		shifts(0 to 22) <= shifts(1 to 23); --SHIFT left
		shifts(23) <= shifts(0);
	end if; --close inner if
   end if; --close outer if
end process;
    hex0 <= shifts(5);
    hex1 <= shifts(4);
    hex2 <= shifts(3);
    hex3 <= shifts(2);
    hex4 <= shifts(1);
    hex5 <= shifts(0);

end behavior;
--END OF ARCHITECTURE
