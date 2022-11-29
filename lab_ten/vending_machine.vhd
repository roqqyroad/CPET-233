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

		if (coin_return = '1') then --when a coin return is requested
			next_state <= CHANGE; --we go to change state

		elsif (nickel_in = '1') then --when a nickel goes in
			next_state <= NICKEL; --then we go to nickel state

		elsif (dime_in = '1') then --when a dime goes in
			next_state <= DIME; --then we go to dime state 
		
		elsif (quarter_in = '1') then --when a quarter goes in
			next_state <= QUARTER; --then we go to quarter state 

		elsif ( money >= 75 ) then --if money is equal to or greater than 75
			next_state <= ENOUGH; --we have enough to get a redbull

		else
			next_state <= WAIT1;
			--Wait1 doesnt care about if dispense was pressed
		
		end if; --end of wait1 if
	--END OF WAIT1

	--ADDITION STATES
	
	--when in NICKEL
	when NICKEL 

		if(money < 75) then
			next_state <= WAIT1;

		elsif ( money >= 75 ) then
			next_state <= ENOUGH;
	--END OF NICKEL

	--when in DIME
	when DIME

		if(money < 75) then
			next_state <= WAIT1;

		elsif ( money >= 75 ) then
			next_state <= ENOUGH;
	--END OF DIME


	--when in QUARTER
	when QUARTER

		if(money < 75) then
			next_state <= WAIT1;

		elsif ( money >= 75 ) then
			next_state <= ENOUGH;
	--END OF QUARTER

		--END OF ADDITION STATES

    --when in enough
	when ENOUGH
			if(dime_in = '1' or nickel_in = '1' or quarter_in = '1') then
				next_state <= EXCESS;
			elsif(coin_return = '1') then
				next_state <= CHANGE;
			elsif(dispense = '1') then
				next_state <= VEND;
			else
				next_state <= ENOUGH;
	
	--when in excess
	when EXCESS
				if(coin_return = '1') then
					next_state <= CHANGE;
				elsif (dispense = '1') then
					next_state <= VEND;
				else
					next_state <= EXCESS;

	--when in vend
	when VEND
				if(money > 0) then
					next_state <= CHANGE;
				else
					next_state <= wait1;

	--when in change	
	when CHANGE
				next_state <= wait1;	
	--ANYTHING ELSE WILL GIVE US A NEXT STATE OF WAIT1	
	when OTHERS =>
		next_state <= WAIT1;

	end case; --END OF CASE STATEMENT

end process; --END OF COMB STUFF THAT DECIDES WHERE TO GO NEXT
--end of comb process

--output processes

money_out : process(clk) --determines money's value
begin
    if(rising_edge(clk)) then
        if (next_state = WAIT1)          	then money = money 
        elsif (next_state = DIME)       	then money = money + 10
        elsif (next_state = NICKEL)    		then money = money + 5 
        elsif (next_state = QUARTER)      	then money = money + 25 
        elsif (next_state = ENOUGH)      	then money = money 
        elsif (next_state = EXCESS)     	then money = money 
		elsif (next_state = VEND)       	then money = money - 75 
		elsif (next_state = CHANGE)     	then money = 0 
        else fill_valve = '0' --DEFAULT money is zero
    
        end if;
    end if;
end process;

red_bull_out : process(clk) --determines if a redbull should be dispensed
begin
    if(rising_edge(clk)) then
        if (next_state = WAIT1)          	then red_bull = '0' --redbull is not dispensed
        elsif (next_state = DIME)       	then red_bull = '0' --redbull is not dispensed
        elsif (next_state = NICKEL)    		then red_bull = '0' --redbull is not dispensed
        elsif (next_state = QUARTER)      	then red_bull = '0' --redbull is not dispensed
        elsif (next_state = ENOUGH)      	then red_bull = '0' --redbull is not dispensed
        elsif (next_state = EXCESS)     	then red_bull = '0' --redbull is not dispensed
		elsif (next_state = VEND)       	then red_bull = '1' --redbull is dispensed
		elsif (next_state = CHANGE)     	then red_bull = '0' --redbull is not dispensed
        else fill_valve = '0' --DEFAULT no redbull is sent
    
        end if;
    end if;
end process;

change_back_out : process(clk) --determines if change should be sent out 
begin
    if(rising_edge(clk)) then
        if (next_state = WAIT1)          	then change_back = '0' --water should not be added into
        elsif (next_state = DIME)       	then change_back = '0' --water should be added into
        elsif (next_state = NICKEL)    		then change_back = '0' --water should not be added into
        elsif (next_state = QUARTER)      	then change_back = '0' --water should not be added into
        elsif (next_state = ENOUGH)      	then change_back = '0' --water should be added into
        elsif (next_state = EXCESS)     	then change_back = '1' --water should not be added into
		elsif (next_state = VEND)       	then change_back = '0' --water should not be added into
		elsif (next_state = CHANGE)     	then change_back = '1' --water should not be added into
        else fill_valve = '0' --DEFAULT no change sent out
    
        end if;
    end if;
end process;

hex0_out : process(clk) --determines if change should be sent out 
begin
    if(rising_edge(clk)) then
        if (next_state = WAIT1)          	then fill_valve = '0' --water should not be added into
        elsif (next_state = DIME)       	then fill_valve = '1' --water should be added into
        elsif (next_state = NICKEL)    		then fill_valve = '0' --water should not be added into
        elsif (next_state = QUARTER)      	then fill_valve = '0' --water should not be added into
        elsif (next_state = ENOUGH)      	then fill_valve = '1' --water should be added into
        elsif (next_state = EXCESS)     	then fill_valve = '0' --water should not be added into
		elsif (next_state = VEND)       	then fill_valve = '0' --water should not be added into
		elsif (next_state = CHANGE)     	then fill_valve = '0' --water should not be added into
        else fill_valve = '0' --DEFAULT no change sent out
    
        end if;
    end if;
end process;

hex1_out : process(clk) --determines if change should be sent out 
begin
    if(rising_edge(clk)) then
        if (next_state = WAIT1)          	then fill_valve = '0' --water should not be added into
        elsif (next_state = DIME)       	then fill_valve = '1' --water should be added into
        elsif (next_state = NICKEL)    		then fill_valve = '0' --water should not be added into
        elsif (next_state = QUARTER)      	then fill_valve = '0' --water should not be added into
        elsif (next_state = ENOUGH)      	then fill_valve = '1' --water should be added into
        elsif (next_state = EXCESS)     	then fill_valve = '0' --water should not be added into
		elsif (next_state = VEND)       	then fill_valve = '0' --water should not be added into
		elsif (next_state = CHANGE)     	then fill_valve = '0' --water should not be added into
        else fill_valve = '0' --DEFAULT no change sent out
    
        end if;
    end if;
end process;





--end of output processes

end structure;
--END OF ARCHITECTURE


