--Section: 02
--Lab: 02
--Assignment: Calculator - Lab five


--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity
entity calculator is
    port(
       --inputs
	in_A: in std_logic_vector(3 downto 0);	
	in_B: in std_logic_vector(3 downto 0);
	Op: in std_logic_vector(1 downto 0); --operation selection

       --outputs
       Result: out std_logic_vector(7 downto 0)
    );
end calculator;

--architecture
architecture model of calculator is 

--signed a b signals
signal a_signed, b_signed : signed(3 downto 0);
 

begin
	
	--assign signed a and b
	a_signed <= signed(in_A);
	b_signed <= signed(in_B);
 
    --case statement 
    calculator_case: process(in_A, in_B, Op)
    begin
        case op is 
	--addition
        when "00" => result <= std_logic_vector((a_signed(3) & a_signed(3) & a_signed(3) & a_signed) + b_signed);
	--subtraction
        when "01" => result <= std_logic_vector((a_signed(3) & a_signed(3) & a_signed(3) & a_signed) - b_signed);
	--multiplication
        when "10" => result <= std_logic_vector((a_signed(3) & a_signed(3) & a_signed(3) & a_signed) * b_signed);
	--division
        when "11" => result <= std_logic_vector((a_signed(3) & a_signed(3) & a_signed(3) & a_signed) / ( b_signed(3) & b_signed(3) & b_signed(3) & b_signed));
	
	end case;
    end process calculator_case;
    --end of case statement

end model;
--end of architecture
