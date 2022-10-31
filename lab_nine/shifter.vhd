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
        in_num : in std_logic_vector(9 downto 0);

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

    --CONSTANTS
    constant II : std_logic_vector(6 downto 0) := "0110000"; --g
    constant CC : std_logic_vector(6 downto 0) := "0011000";
    constant EE : std_logic_vector(6 downto 0) := "0000000";
    constant oo : std_logic_vector(6 downto 0) := "1000000";
    constant LL : std_logic_vector(6 downto 0) := "0000010";
    constant dd : std_logic_vector(6 downto 0) := "0010010";
    constant SS : std_logic_vector(6 downto 0) := "0011001";
    constant AA : std_logic_vector(6 downto 0) := "0110000";
    constant HH : std_logic_vector(6 downto 0) := "0100100";
    constant rr : std_logic_vector(6 downto 0) := "1111001";
    --end of constants
    
--architecture actually begins
begin

end behavior;
--END OF ARCHITECTURE

