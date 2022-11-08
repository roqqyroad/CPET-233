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
entity binary_to_ssd is
    port(
        --INPUTS
        in_num : in std_logic_vector(9 downto 0);

        --OUTPUTS
        HEX2 : out std_logic_vector(6 downto 0); --for hundreds_dig value
        HEX1 : out std_logic_vector(6 downto 0); --for tens_dig value
        HEX0 : out std_logic_vector(6 downto 0)  --for ones_dig value
    );
end binary_to_ssd;
--END OF ENTITY

--START OF ARCHITECTURE
architecture structure of binary_to_ssd is

    --SIGNALS
    signal hundreds_dig : std_logic_vector(9 downto 0);
    signal tens_dig : std_logic_vector(9 downto 0);
    signal ones_dig : std_logic_vector(8 downto 0);
    --end of signals

    --CONSTANTS
    constant ZERO : std_logic_vector(6 downto 0) := "1000000";
    constant NINE : std_logic_vector(6 downto 0) := "0011000";
    constant EIGHT :  std_logic_vector(6 downto 0) := "0000000";
    constant SEVEN : std_logic_vector(6 downto 0) := "1111000";
    constant SIX : std_logic_vector(6 downto 0) := "0000010";
    constant FIVE : std_logic_vector(6 downto 0) := "0010010";
    constant FOUR : std_logic_vector(6 downto 0) := "0011001";
    constant THREE : std_logic_vector(6 downto 0) := "0110000";
    constant TWO : std_logic_vector(6 downto 0) := "0100100";
    constant ONE : std_logic_vector(6 downto 0) := "1111001";
    constant DASH : std_logic_vector(6 downto 0) := "0111111";
    constant BLANK : std_logic_vector(6 downto 0) := "1111111";
    --end of constants

    --COMPONENTS

    --start of convert_to_constant
    component convert_to_constant is
        port(
            --INPUTS a _dig value
            dig : in std_logic_vector(3 downto 0);

            --OUTPUTS to a hex display value
            hexx : out std_logic_vector(6 downto 0)
        );
    end component;
    --end of convert_to_constant

    --END OF COMPONENTS	    
	    
--architecture actually begins
begin

    --PORT MAPS
	
	--SIGNAL ASSIGNING
	--assign values for each digit for the hundreds, tens, and ones places
	hundreds_dig <= std_logic_vector(unsigned(in_num) / "0001100100");
	tens_dig <=  std_logic_vector((unsigned(in_num) rem "0001100100")/"000001010");
	ones_dig <= std_logic_vector((unsigned(in_num) rem "0001100100")rem "000001010");

    --hundreds digit portmap
    h_dig : convert_to_constant
    port map(
	dig => hundreds_dig(3 downto 0),
	hexx => hex2
    );
    --tens digit portmap
    t_dig : convert_to_constant
    port map(
	dig => tens_dig(3 downto 0),
	hexx => hex1
    );
    --ones digit portmap
    o_dig : convert_to_constant
    port map(
        dig => ones_dig(3 downto 0),
	hexx => hex0
    );
	    
--END OF PORT MAPS

end structure;
--END OF ARCHITECTURE


