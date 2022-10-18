--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Seven - Complete Calculator

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--START OF ENTITY
entity full_calculator is
    port(
        --INPUTS
        A, B : in std_logic_vector(3 downto 0);
        Op : in std_logic;

        --OUTPUTS
        HEX3 : out std_logic_vector(6 downto 0); --for telling neg or pos
        HEX2 : out std_logic_vector(6 downto 0); --for hundreds_dig value
        HEX1 : out std_logic_vector(6 downto 0); --for tens_dig value
        HEX0 : out std_logic_vector(6 downto 0)  --for ones_dig value
    );
end full_calculator;
--END OF ENTITY

--START OF ARCHITECTURE
architecture structure of full_calculator is

    --SIGNALS
    signal result : std_logic_vector(7 downto 0);
    --end of signals

    --COMPONENTS

    --start of calculator
    component calculator is
        port(
            --INPUTS
            in_A, in_B : in std_logic_vector(3 downto 0);
            Op : in std_logic;

            --OUTPUTS
            result : out std_logic_vector(7 downto 0)
        );
    end component;
    --end of calculator

    --start of binary_to_ssd 
    component binary_to_ssd is
        port(
            --INPUTS
            in_num : in std_logic_vector(7 downto 0);

            --OUTPUTS
            HEX3 : out std_logic_vector(6 downto 0); --for telling neg or pos
            HEX2 : out std_logic_vector(6 downto 0); --for hundreds_dig value
            HEX1 : out std_logic_vector(6 downto 0); --for tens_dig value
            HEX0 : out std_logic_vector(6 downto 0)  --for ones_dig value
        );
    end component;
    --end of binary_to_ssd
    
--architecture actually begins
begin

    --PORT MAPS

    calc : calculator
    port map(
        --inputs
        A => in_A,
        B => in_B,
        Op => Op,

        --outputs
        result => result

    );

    btssd : binary_to_ssd
    port map(
        --inputs
        in_num => result,

        --outputs
        HEX3 => HEX3,
        HEX2 => HEX2,
        HEX1 => HEX1,
        HEX0 => HEX0
    );

end structure;
--END OF ARCHITECTURE

