--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Eight - Counter
--Summary: Keeps count of how many times delay unit has been activated. 

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--START OF ENTITY
entity counter is
	port(
		--inputs
		set_n, clk, reset_n, enable : in std_logic;
		timed : in std_logic_vector(9 downto 0);
		
		--outputs
		count : out std_logic_vector(9 downto 0)
	);
end counter;
--END OF ENTITY

--START OF ARCHITECTURE
architecture behavior of counter is
	
	--constants
	constant max_v : unsigned(9 downto 0) := "1111100111";--999 is the max value we can have as a count since we have three hex cells

	--signals
	signal int_count : unsigned(9 downto 0);
	--signal s_timed : unsigned(9 downto 0) := unsigned(timed); -- *unwanted signal; caused issues.

--actual start of architecture
begin

	--if statement process
	process(clk, reset_n, enable, set_n)
	begin
		
		if (reset_n = '0') then 
			int_count <= "0000000000"; --if resetn is zero reset int count
		
		elsif (rising_edge(clk)) then --when there is a rising edge;
			
			if(set_n = '0') then
				int_count <= unsigned(timed); --if setn is zero then intcount is set to timed
			
			elsif (enable = '1') then --when enable is 1;
				
				if (int_count = max_v) then
					int_count <= "0000000000"; --if int count is at 999 set it to zero
				
				else
					int_count <= int_count + "0000000001"; --else add one to int count
				
				end if; --close elsiif's embedded if
					
			end if; --close total inner if
				
		end if; --close if
			
	end process; --close process
count <= std_logic_vector(int_count); --SET COUNT TO INT_COUNT 

end behavior;
--END OF ARCHITECTURE
