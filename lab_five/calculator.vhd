
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
	a: in std_logic_vector(3 downto 0);	
	b: in std_logic_vector(3 downto 0);
	op: in std_logic_vector(1 downto 0); --operation selection

       --outputs
       r: out std_logic_vector(7 downto 0)
    );
end calculator;

--architecture
architecture model of calculator is 

--signed a b signals
signal a_signed, b_signed : signed(3 downto 0);
 

begin
	
	--assign signed a and b
	a_signed <= signed(a);
	b_signed <= signed(b);
 
    --case statement 
    calculator_case: process(a, b, op)
    begin
        case op is 
	--addition
        when "00" => r <= std_logic_vector(a_signed + b_signed);
	--subtraction
        when "01" => r <= std_logic_vector(a_signed - b_signed);
	--multiplication
        when "10" => r <= std_logic_vector(a_signed * b_signed);
	--division
        when others => r <= std_logic_vector(a_signed / b_signed);

        end case;
    end process calculator_case;
    --end of case statement

end model;
--end of architecture
