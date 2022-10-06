--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Homework Five - Question One

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity start
entity question_two is
    port(
        --inputs
        a, b : in std_logic_vector(7 downto 0);
        a_s : in std_logic;
        
        --outputs
        sum : out std_logic_vector(8 downto 0)
    );
end question_two;
--entity end


--architecture start
architecture model of question_two is

    --signals
    signal a_signed, b_signed : signed(7 downto 0);
    
begin
    
    a_signed <= signed(a);
    b_signed <= signed(b);

    --if then else statement 
    if_statement: process(a_signed, b_signed, a_s)
    begin
        --a_s is one, it takes the two's complement of b 
        if (a_s = '0') then
           
			sum <= std_logic_vector((a_signed(7) & a_signed) + b_signed);
        --else, the sum is just a + b
        else
           sum <= std_logic_vector((a_signed(7) & a_signed) + ((not(b_signed) + "00000001"))); 
        end if;
    end process;        
    --end of if statement


end model;
--architecture end
