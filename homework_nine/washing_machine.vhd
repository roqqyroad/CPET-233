--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Homework Nine - Washing Machine
--Summary: 

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--START OF ENTITY
entity washing_machine is
    port(

        --INPUTS
	clk, reset_n : in std_logic;
	start, full, empty, minute_timer : in std_logic; --minute_timer is an assumed file

        --OUTPUTS
	fill_valve, drum_motor, empty_valve : in std_logic

    );
end washing_machine;
--END OF ENTITY

--START OF ARCHITECTURE
architecture structure of washing_machine is

    --ENUMS
    type state_type is (IDLE, FILL, AGITATE, DRAIN, RINSE, SPIN);
    --end of enums

    --SIGNALS
	signal current_state, next_state : state_type;
	signal s_fill_valve, s_drum_motor, s_empty_valve : std_logic; 
    --end of signals

    --CONSTANTS

    --end of constants

--architecture actually begins
begin

--sync process

sync : process(clk, reset_n)
begin
	
	if(reset_n = '0') then
		current_state <= IDLE; --if reset is low (active low) it goes to the default state, which is IDLE

	elseif(rising_edge(clk)) then
		current_state <= next_state; --or we can advance the machines state if we are at a rising clock edge

	end if; --close if statement

end process; --close if process

--end of sync process

--comb process
--decides the next state

comb : process(current_state, nickel_in, dime_in, quarter_in, dispense, coin_return)
    begin
	case (current_state) is

    --START OF IDLE
	    when IDLE => --WHEN CURRENT STATE IS idle
		    if (start = '1') then --when the start button is pressed
			    next_state <= FILL; --we go to fill state

		    else --when nothing is pressed it stays in idle
			    next_state <= IDLE;		
		    end if; --end of idle if
    --END OF IDLE

    --START OF FILL
	    when FILL --fill is active until
		    if(full = '1') then --the machine is full of water
			    next_state <= AGITATE;

		    else --otherwise it will stay in fill
			    next_state <= FILL;
            end if;
    --END OF FILL

    --START OF AGITATE
	    when AGITATE --agittate is active until
		    if((minute_timer) = 7 OR (minute_timer > 7)) then --the timer is greater than or equal to 7
			    next_state <= DRAIN;

		    else --otherwise it will stay in agitate
			    next_state <= AGITATE;
            end if;
    --END OF AGITATE

    --START OF DRAIN
	    when DRAIN --drain is active until
		    if(empty = '1') then --the machine has no water inside it anymore
			    next_state <= RINSE;

		    else --otherwise it will stay in drain
			    next_state <= DRAIN;
            end if;
    --END OF DRAIN

    --START OF RINSE
        when RINSE --rinse is active until
            if(full = '1') then --the machine is full of water
                next_state <= SPIN;

            else --otherwise it will stay in rinse
                next_state <= RINSE;
            end if;
    --END OF RINSE

    --START OF SPIN
        when SPIN --spin is active until
            if(((timer > 10) or (timer = 10)) and (empty = '1')) then --timer is greater than or equal to 10 AND the machine is empty
                next_state <= IDLE;

            else --otherwise it will stay in spin
                next_state <= SPIN;
            end if;
    --END OF SPIN

    --ANYTHING ELSE WILL GIVE US A NEXT STATE OF IDLE since they were unaccounted for	
	    when OTHERS =>
		    next_state <= IDLE;
	end case; --END OF CASE STATEMENT

end process; --END OF COMB STUFF THAT DECIDES WHERE TO GO NEXT
--end of comb process


--OUTPUT PROCESSES--

fill_value_out : process(clk) --determines if the water should be added into
begin
    if(rising_edge(clk)) then
        if (next_state = IDLE)          then fill_valve = '0' --water should not be added into
        elsif (next_state = FILL)       then fill_valve = '1' --water should be added into
        elsif (next_state = AGITATE)    then fill_valve = '0' --water should not be added into
        elsif (next_state = DRAIN)      then fill_valve = '0' --water should not be added into
        elsif (next_state = RINSE)      then fill_valve = '1' --water should be added into
        elsif (next_state = SPIN)       then fill_valve = '0' --water should not be added into
        else fill_valve = '0' --DEFAULT off
    
        end if;
    end if;
end process;

drum_motot_out : process(clk) --determines if the drum motor should be on
begin
    if(rising_edge(clk)) 
        if (next_state = IDLE)          then drum_motor = '0' --drum motor is off
        elsif (next_state = FILL)       then drum_motor = '0' --drum motor is off
        elsif (next_state = AGITATE)    then drum_motor = '1' --drum motor is on
        elsif (next_state = DRAIN)      then drum_motor = '0' --drum motor is off
        elsif (next_state = RINSE)      then drum_motor = '0' --drum motor is off
        elsif (next_state = SPIN)       then drum_motor = '1' --drum motor is on
        else drum_motor = '0' --DEFAULT off
    
        end if;
    end if;
end process;

empty_value_out: process(clk) --determines if the water inside should be emptied out
begin
    if(rising_edge(clk))
        if (next_state = IDLE)          then empty_valve = '0' --should not be emptying
        elsif (next_state = FILL)       then empty_valve = '0' --should not be emptying
        elsif (next_state = AGITATE)    then empty_valve = '0' --should not be emptying
        elsif (next_state = DRAIN)      then empty_valve = '1' --should be emptying
        elsif (next_state = RINSE)      then empty_valve = '0' --should not be emptying
        elsif (next_state = SPIN)       then empty_valve = '1' --should be emptying
        else  empty_valve = '0' --DEFAULT off
    
        end if;
    end if;
end process;


--end of output processes

end structure;
--END OF ARCHITECTURE