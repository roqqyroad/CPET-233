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
       cases: out std_logic;
       ifthenelse: out std_logic
    );
end lab_four;

--architecture
architecture model of lab_four is 

    --signals
    signal inputs : std_logic_vector(3 downto 0);
    signal cases_a : std_logic_vector(6 downto 0);
    signal ifthenelse_a : std_logic_vector(6 downto 0);
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
    cases <= cases_a;
    ifthenelse <= ifthenelse_a;

    --case statement implementation
    case_statement: process(inputs)
    begin
        case inputs is 
        when "0000" | "0010" => cases_a <= FIVE;
        when "0001" | "1010" => cases_a <= EIGHT;
        when "0100" => cases_a <= TWO;
        when "0101" => cases_a <= SIX;
        when "0110" => cases_a <= ZERO;
        when "1000" => cases_a <= ONE;
        when "1001" => cases_a <= THREE;
        when "1011"  => cases_a <= FOUR;
        when "0011" | "0111" => cases_a <= DASH;
        when others => cases_a <= BLANK;
        end case;

    end process case_statement;
    --end of case statement

	--if then else statement implementation
    if_statement: process(inputs)
    begin
        --five
        if (inputs = "0000" OR "0010") then
            ifthenelse_a <= FIVE;
        
        elsif (inputs = "0001" OR "1010") then
            ifthenelse_a <= EIGHT;

        elsif (inputs = "0100") then
            ifthenelse_a <= TWO;

        elsif (inputs = "0101") then
            ifthenelse_a <= SIX;

        elsif (inputs = "0110") then   
            ifthenelse_a <= ZERO;

        elsif (inputs = "1000") then 
            ifthenelse_a <= ONE;

        elsif (inputs = "1001") then 
            ifthenelse_a <= THREE;

        elsif (inputs = "1011") then 
            ifthenelse_a <= FOUR;

        elsif (inputs = "0011" OR "0111") then
            ifthenelse_a <= DASH;
 
        else
            ifthenelse_a <= BLANK;

        end if;
    end process;        
    --end of if statement


end model;
--end of architecture