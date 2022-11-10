--NAme: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Homework seven


--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity
entity question_one is
    port(
        --inputs
        clk, reset_n, u_d : in std_logic;
		  --outputs
		  count : out std_logic_vector(3 downto 0)
    );
end question_one;
--end of entity

--architecture
architecture model of question_one is
	--signals
	signal int_count : std_logic_vector(3 downto 0);
	
	--constants
	constant max_val : std_logic_vector(3 downto 0) := "1111";
	constant min_val : std_logic_vector(3 downto 0) := "0000";
begin

	--counting if processes
	counting : process(clk, reset_n, u_d)
	begin
		
		--reset is active low, if reset, intcount is zeros
		if(reset_n = '0') then
			int_count <= "0000";
		
		--if there is a rising clock edge then
		elsif(rising_edge(clk)) then
		
			--if ud is one we are supposed to count up
			if(u_d = '1') then
			
				--but if its already at the max value it stays at the value it is at
				if (int_count = max_val) then
					int_count <= int_count;
				--otherwise it has one added to it 
				else
				int_count <= int_count + 1;
				end if;
			--BUT IF UD IS ZERO we are supposed to count down
			elsif(u_d = '0') then
				--so if intcount is equal to zero it stays the same
				if(int_count = min_val) then
					int_count <= int_count;
				--else it gets one subtracted from it
				else
				int_count <= int_count - 1;
				end if;
			end if;
		end if;
	end process;
	--end of processes
	
	--set output equal to the int_count value
	count <= int_count;
end model;
--end of architecture