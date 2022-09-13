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
       a_case, b_case, c_case, d_case, e_case, f_case, g_case: out std_logic;
       a_if, b_if, c_if, d_if, e_if, f_if, g_if : out std_logic
    );
end lab_four;

--architecture
architecture model of lab_four is 

    --signals
    signal inputs : std_logic_vector(3 downto 0);
    --end of signals

begin
    --inputs
    inputs <= w & x & y & z; 

    --case statement implementation
    case_statement: process(inputs)
    begin
        case inputs is 
        when "1100" | "1101" | "1110" | "1111" | "0011" | "1011" | "0111" | "1000" => a_case <= '1';
		  when others => a_case <= '0';
		  end case;
		  
		  case inputs is 
        when "1100" | "1101" | "1110" | "1111" | "0000" | "0010" | "0111" | "0011" | "0101" => b_case <= '1';
         when others => b_case <= '0';
        end case;
		  
		  case inputs is 
		  when "1100" | "1101" | "1110" | "1111" | "0011" | "0111" | "0100" => c_case <= '1';
         when others => c_case <= '0';
        end case;
		  
		  case inputs is 
		  when "1100" | "1101" | "1110" | "1111" | "0011" | "1011" | "0111" | "1000" => d_case <= '1';
         when others => d_case <= '0';
        end case;
		  
		  case inputs is 
		  when "1100" | "1101" | "1110" | "1111" | "0011" | "0111" | "1011" | "0000" | "0010" | "1000" | "1001" => e_case <= '1';
         when others => e_case <= '0';
        end case;
		  
		  case inputs is 
		  when "1100" | "1101" | "1110" | "1111" | "0011" | "0111" | "1000" | "0100" | "1001" => f_case <= '1';
         when others => f_case <= '0';
        end case;
		  
		  case inputs is 
		  when "1100" | "1101" | "1110" | "1111" | "1000" | "0110" => g_case <= '1';
        when others => g_case <= '0';
        end case;

    end process case_statement;
    --end of case statement

	--if then else statement implementation
    if_statement: process(inputs)
    begin
        if (inputs = ("1100") OR inputs = ("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0011") OR inputs =("1011") OR inputs =("0111") OR inputs =("1000")) then
            a_if <= '1';
			else
			a_if <= '0';
			end if;
        
        if (inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0000") OR inputs =("0010") OR inputs =("0111") OR inputs =("0011") OR inputs =("0101")) then
            b_if <= '1';
				else
			b_if <= '0';
			end if;

        if (inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0011") OR inputs =("0111") OR inputs =("0100")) then
            c_if <= '1';
				else
			c_if <= '0';
			end if;

        if (inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0011") OR inputs =("0111") OR inputs =("1011") OR inputs =("1000")) then
            d_if <= '1';
				else
			d_if <= '0';
			end if;

        if (inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0011") OR inputs =("0111") OR inputs =("1011") OR inputs =("0000") OR inputs =("0010") OR inputs =("1000") OR inputs =("1001")) then   
            e_if <= '1';
				else
			e_if <= '0';
			end if;

        if (inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0011")  OR inputs =("0111") OR inputs =("1000") OR inputs =("0100") OR inputs =("1001")) then
            f_if <= '1';
				else
			f_if <= '0';
			end if;

        if (inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("1000") OR inputs =("0110") OR inputs =("1110")) then 
            g_if <= '1';

        else
           g_if <= '0';

        end if;
    end process;        
    --end of if statement


end model;
--end of architecture