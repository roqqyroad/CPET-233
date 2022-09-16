--Section: 02
--Lab: 02
--Assignment: Homework Three | Question Two
--Due Date: Sept 15, 2022 @ 11:59PM EST


--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--testbench entity question_one_tb
--NOT question_two_tb due to wording of question at hand. 
entity question_one_tb is   
end entity question_one_tb;  

--***************************************************************************

--begining of test architecture
architecture test of question_one_tb is

    --signals
    --inputs
    signal inputs : std_logic_vector(3 downto 0);
    --outputs
    signal output_hexx_tb : std_logic_vector(6 downto 0); 
    --end of signals

    --component, grab the question one inputs and output
    component question_one_tb  
        port (
            --inputs
            in_3, in_2, in_1, in_0 : in std_logic;
            --outputs
            hexx : out std_logic_vector(6 downto 0)         
            ); 
    end component;
    --end of component

--***************************************************************************    

begin
    --port map of question_one; 
    --in_3, in_2, in_1, in_0 lsb -> msb 
    --hexx is our output here, with 7 slots for the hex display
    uut : question_one port map(
        --INPUTS
        in_3 => inputs(3),       
        in_2 => inputs(2),
        in_1 => inputs(1),
        in_0 => inputs(0),
        --OUTPUTS
        hexx => output_hexx_tb
        );
    --end of port map

--***************************************************************************

    --stim, to create a waveform of question_one
    stim : process
    begin
        for k in 0 to 15 loop --loop goes thru all 16 characters
            inputs <= std_logic_vector(to_unsigned(k,4));
            wait for 20 ns;
        end loop;
        --wait to ensure we don't do more testing than needed. 
        wait;  
    end process stim;
    --end of stim process

end architecture test;
--end of test architecture
