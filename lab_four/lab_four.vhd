--Section: 02
--Lab: 02
--Assignment: Lab Four


--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity
entity lab_four is
    port(
       --inputs
       w, x, y, z : in std_logic;

       --outputs
       cases: out std_logic_vector(6 downto 0);
       ifthenelse: out std_logic_vector(6 downto 0)
    );
end lab_four;

--architecture
architecture model of lab_four is 

    --signals
    signal inputs : std_logic_vector(3 downto 0);
    --end of signals

    --constants
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

begin
    --inputs
    inputs <= w & x & y & z; 
    --case statement implementation
    case_statement: process(inputs)
    begin
        case inputs is 
        when "0000" | "0010" => cases <= FIVE;
        when "0001" | "1010" => cases <= EIGHT;
        when "0100" => cases <= TWO;
        when "0101" => cases <= SIX;
        when "0110" => cases <= ZERO;
        when "1000" => cases <= ONE;
        when "1001" => cases <= THREE;
        when "1011"  => cases <= FOUR;
        when "0011" | "0111" => cases <= DASH;
        when others => cases <= BLANK;
        end case;

    end process case_statement;
    --end of case statement

	--if then else statement implementation
    if_statement: process(inputs)
    begin
        --five
        if (inputs = "0000" OR inputs = "0010") then
            ifthenelse <= FIVE;
        
        elsif (inputs = "0001" OR inputs = "1010") then
            ifthenelse <= EIGHT;

        elsif (inputs = "0100") then
            ifthenelse <= TWO;

        elsif (inputs = "0101") then
            ifthenelse <= SIX;

        elsif (inputs = "0110") then   
            ifthenelse <= ZERO;

        elsif (inputs = "1000") then 
            ifthenelse <= ONE;

        elsif (inputs = "1001") then 
            ifthenelse <= THREE;

        elsif (inputs = "1011") then 
            ifthenelse <= FOUR;

        elsif (inputs = "0011" OR inputs = "0111") then
            ifthenelse <= DASH;
 
        else
            ifthenelse <= BLANK;

        end if;
    end process;        
    --end of if statement


end model;
--end of architecture
