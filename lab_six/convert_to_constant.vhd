--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Six - Absolute Value (Homework Three | Question One)

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity
entity abs_v is
    port(
       --inputs
       dig : in std_logic_vector(3 downto 0);

       --outputs
       hexx: out std_logic_vector(6 downto 0)
    );
end abs_v;

--architecture
architecture model of abs_v is 

    --constants for assigning to a hex display
    constant ZERO : std_logic_vector(6 downto 0) := "1000000";
    constant ONE : std_logic_vector(6 downto 0) := "1111001";
    constant TWO : std_logic_vector(6 downto 0) := "0100100";
    constant THREE : std_logic_vector(6 downto 0) := "0110000";
    constant FOUR : std_logic_vector(6 downto 0) := "0011001";
    constant FIVE : std_logic_vector(6 downto 0) := "0010010";
    constant SIX : std_logic_vector(6 downto 0) := "0000010";
    constant SEVEN : std_logic_vector(6 downto 0) := "1111000";
    constant EIGHT :  std_logic_vector(6 downto 0) := "0000000";
    constant NINE : std_logic_vector(6 downto 0) := "0011000";
    --END OF NUMBER-EY VALUES
    constant AA : std_logic_vector(6 downto 0) := "0001000";
    constant BB : std_logic_vector(6 downto 0) := "0000011";
    constant CC : std_logic_vector(6 downto 0) := "1000110";
    constant DD : std_logic_vector(6 downto 0) := "0100001";
    constant EE : std_logic_vector(6 downto 0) := "0000110";
    constant FF : std_logic_vector(6 downto 0) := "0001110";
    --end of constants

begin
    --hex assigner case statement implementation
    hex_assigner: process(dig)
    begin
        case dig is 
        when "0000" => hexx <= ZERO;
        when "0001" => hexx <= ONE;
        when "0010" => hexx <= TWO;
        when "0011" => hexx <= THREE;
        when "0100" => hexx <= FOUR;
        when "0101" => hexx <= FIVE;
        when "0110" => hexx <= SIX;
        when "0111" => hexx <= SEVEN;
        when "1000" => hexx <= EIGHT;
        when "1001" => hexx <= NINE;
        --END OF NUMBER-EY VALUES
        when "1010" => hexx <= AA;
        when "1011" => hexx <= BB;
        when "1100" => hexx <= CC;
        when "1101" => hexx <= DD;
        when "1110" => hexx <= EE;
        --WHEN OTHER values of inputs fed in, constant ff is returned.
        when others => hexx <= FF;
        end case;

    end process hex_assigner;
    --end of hex assigner case statement implementation

    end model;
--end of architecture
