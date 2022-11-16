--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Ten - vending machine
--Summary: 

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--START OF ENTITY
entity vending_machine is
    port(

        --INPUTS
	clk, reset_n : in std_logic;
	nickel_in, dime_in, quarter_in, dispense, coin_return : in std_logic;

        --OUTPUTS
	red_bull, change_back : in std_logic;
	hex0, hex1 : in std_logic_vector(6 downto 0)

    );
end vending_machine;
--END OF ENTITY

--START OF ARCHITECTURE
architecture structure of vending_machine is

    --ENUMS
    type state_type is (WAIT1, NICKEL, DIME, QUARTER, ENOUGH, EXCESS, VEND, CHANGE);
    --end of enums

    --SIGNALS
	signal current_state, next_state : state_type;
	signal money : unsigned(7 downto 0); --for keeping track of the total money in the machine
    --end of signals

    --CONSTANTS

    --end of constants

--architecture actually begins
begin

--sync process

sync : process(clk, reset_n)
begin
	
	if(reset_n = '0') then
		current_state <= WAIT1; --if reset is low (active low) it goes to the default state, which is WAIT1

	elseif(clk'event and clk = '1') then
		current_state <= next_state; --or we can advance the machines state if we are at a rising clock edge

	end if; --close if statement

end process; --close if process

--end of sync process

--comb process
--decides the next state

comb : process(current_state, nickel_in, dime_in, quarter_in, dispense, coin_return)
begin
	case (current_state) is

--START OF WAIT1
	when WAIT1 => --WHEN CURRENT STATE IS WAIT1
		money = money; --money value does not change

		if (coin_return = '1') then --when a coin return is requested
			--money <= 0; --money is set to zero, since all change is spit out
			next_state <= CHANGE; --we go to change state

		elsif (nickel_in = '1') then --when a nickel goes in
			next_state <= NICKEL; --then we go to nickel state

		elsif (dime_in = '1') then --when a dime goes in
			next_state <= DIME; --then we go to dime state 
		
		elsif (quarter_in = '1') then --when a quarter goes in
			next_state <= QUARTER; --then we go to quarter state 

		elsif (money >= 75) then --if money is equal to or greater than 75
			next_state <= ENOUGH; --we have enough to get a redbull

		else
			next_state <= WAIT1;
			--Wait1 doesnt care about if dispense was pressed
		
		end if; --end of wait1 if
--END OF WAIT1

--ADDITION STATES
	
	--START OF NICKEL
	when NICKEL 
		money <= money + 5; --increase money's value by 5

		if(money < 75) then
			next_state <= WAIT1;

		elsif( money >= 75 ) then
			next_state <= ENOUGH;
	--END OF NICKEL

	--START OF DIME
	when DIME
		money <= money + 10; --increase money value by 10

		if(money < 75) then
			next_state <= WAIT1;

		elsif( money >= 75 ) then
			next_state <= ENOUGH;
	--END OF DIME


	--START OF QUARTER
	when QUARTER
		money <= money + 25; --increase money value by 25

		if(money < 75) then
			next_state <= WAIT1;

		elsif( money >= 75 ) then
			next_state <= ENOUGH;
	--END OF QUARTER

--END OF ADDITION STATES

	when ENOUGH
		money = money; --money value does not change 
	

	when EXCESS
	
	when VEND
	money <= money - 75;
	
	when CHANGE


--ANYTHING ELSE WILL GIVE US A NEXT STATE OF WAIT1	
	when OTHERS =>
		next_state <= WAIT1;

	end case; --END OF CASE STATEMENT

end process; --END OF COMB STUFF THAT DECIDES WHERE TO GO NEXT

--end of comb process

--output processes



--end of output processes

end structure;
--END OF ARCHITECTURE


