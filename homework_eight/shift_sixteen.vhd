--NAme: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Homework Eight 
-- Summary: 16 bit universal shift register


--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity
entity shift_sixteen is
    port(
        --inputs
        clk, reset_n, sh_ld, r_l, serial_in: in std_logic;
		din : in std_logic_vector(15 downto 0); --for parallel loading
		--outputs
		serial_out : out std_logic;
		all_out : out std_logic_vector(15 downto 0)
    );
end shift_sixteen;
--end of entity

--architecture
architecture model of shift_sixteen is
	--signals
	signal shifting : std_logic_vector(15 downto 0);
	signal s_serial_out : std_logic;

begin

	--counting if processes
	counting : process(clk, reset_n, sh_ld, r_l)
	begin
		
		--reset is active low, 
		if(reset_n = '0') then
			shifting <= "000000000000000"; --shifting resets to all zero's
		
		--if there is a rising clock edge then
		elsif(rising_edge(clk)) then
		
			--PARALLEL LOAD
			if(sh_ld = '0') then
				shifting <= din; --PARALLEL LOADING for shifting (lack there of, rather)

			elsif(sh_ld = '1') then --SHIFTING for shifting (actually shifting)

				if(r_l = '0') then--LEFT i think...
					shifting(0 to 14) <= shifting(1 to 15); --SHIFT left
					shifting(15) <= serial_in;
					s_serial_out <= shifting(15); --serial out gets 15 place

				else--RIGHT
					shifting(1 to 15) <= shifting(0 to 14); --SHIFT RIGHT
					shifting(0) <= serial_in;
					s_serial_out <= shifting(0); --serial out gets 0 place

				end if;
			end if;
		end if;
	end process;
	--end of processes
	serial_out <= s_serial_out; --serial out !
	all_out <= shifting;--parallel output, just in case...
end model;
--end of architecture