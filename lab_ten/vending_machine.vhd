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
	nickel_in, dime_in, quarter_in, dispense_in, coin_return : in std_logic;

        --OUTPUTS
	RedBull_out, change_back : out std_logic;
	hex0, hex1 : out std_logic_vector(6 downto 0)

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
	--money needs to have an initial value because if it doesnt you are adding or subtratcing from a value that does not exist, which is a nono
	signal money : unsigned(7 downto 0) := "00000000"; --for keeping track of the total money in the machine
	signal tens_dig : std_logic_vector(7 downto 0); --signal used in determining hex1
   signal ones_dig : std_logic_vector(6 downto 0); --signal used in determining hex0
    --end of signals
	 
	   --constants for assigning to a hex display
    constant ZERO : std_logic_vector(6 downto 0) := "1000000";
    constant ONE : std_logic_vector(6 downto 0) := "1111001";
    constant TWO : std_logic_vector(6 downto 0) := "0100100";
    constant THREE : std_logic_vector(6 downto 0) := "0110000";
    constant FOUR : std_logic_vector(6 downto 0) := "0011001";
    constant FIVE : std_logic_vector(6 downto 0) := "0010010";
    constant SIX : std_logic_vector(6 downto 0) := "0000010";
    constant SEVEN : std_logic_vector(6 downto 0) := "1111000";
    constant EIGHT :  std_logic_vector(6 downto 0) := "0000000";
    constant NINE : std_logic_vector(6 downto 0) := "0011000";
	 constant FF : std_logic_vector(6 downto 0) := "0001110"; --used here for errors because i had trouble debugging for a bit
	 --end of constants


--architecture actually begins
begin

--sync process

sync : process(clk, reset_n)
begin
	
	if(reset_n = '0') then
		current_state <= WAIT1; --if reset is low (active low) it goes to the default state, which is WAIT1

	elsif(clk'event and clk = '1') then
		current_state <= next_state; --or we can advance the machines state if we are at a rising clock edge

	end if; --close if statement

end process; --close if process

--end of sync process

--comb process
--decides the next state

comb : process(current_state, nickel_in, dime_in, quarter_in, dispense_in, coin_return, money)
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
	when NICKEL =>

		if ( money >= 75 ) then--if there is enough money, go to enough
			next_state <= ENOUGH;
		else --otherwise wait
			next_state <= wait1;
		end if;
	--END OF NICKEL

	--when in DIME
	when DIME =>

	

		if ( money >= 75 ) then--if there is enough money, go to enough
			next_state <= ENOUGH;
			else --otherwise wait
			next_state <= wait1;
		end if;
	--END OF DIME


	--when in QUARTER
	when QUARTER =>

		if ( money >= 75 ) then--if there is enough money, go to enough
			next_state <= ENOUGH;
			else --otherwise go to wait
			next_state <= wait1; 
		end if;
	--END OF QUARTER

		--END OF ADDITION STATES

    --when in enough
	when ENOUGH =>
			if(dime_in = '1' or nickel_in = '1' or quarter_in = '1') then
				next_state <= EXCESS;
			elsif(coin_return = '1') then --go to change when we ask for a coin return
				next_state <= CHANGE;
			elsif(dispense_in = '1') then --give a redbull when dispense button is pressed
				next_state <= VEND;
			else --otherwise just remain in enough
				next_state <= ENOUGH;
			end if;
	
	--when in excess
	when EXCESS =>
				if(coin_return = '1') then --go to change when we ask for a coin return
					next_state <= CHANGE;
				elsif (dispense_in = '1') then--give a redbull when dispense button is pressed
					next_state <= VEND;
				else --otherwise we can just go back to enough
					next_state <= ENOUGH;
				end if;

	--when in vend
	when VEND =>
				if(money > 0) then --go to change since the item was dispensed
					next_state <= CHANGE;
				else --otherwise there is no money so go to wait
					next_state <= wait1;
				end if;

	--when in change	
	when CHANGE =>  --there is no money so we will wait
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
        if (next_state = WAIT1)          	then money <= money; --money is still the same
        elsif (next_state = DIME)       	then money <= money + "1010"; --money increases by 10 since a dime was inserted
        elsif (next_state = NICKEL)    	then money <= money + "0101"; --money increases by 5 since a nickel was inserted
        elsif (next_state = QUARTER)      then money <= money + "00011001"; --money increases by 25 since a quarter was inserted
        elsif (next_state = ENOUGH)      	then money <= money; --money is still the same
        elsif (next_state = EXCESS)     	then money <= money; --money is still the same
		  elsif (next_state = VEND)       	then money <= money - "01001011"; --money is 75 less than before since vend was pressed
		  elsif (next_state = CHANGE)     	then money <= "00000000";
        else money <= "00000000"; --DEFAULT money is zero
    
        end if;
    end if;
end process;

red_bull_out : process(clk) --determines if a redbull should be dispensed
begin
    if(rising_edge(clk)) then
        if (next_state = WAIT1)          	then RedBull_out <= '0'; --redbull is not dispensed
        elsif (next_state = DIME)       	then RedBull_out <= '0'; --redbull is not dispensed
        elsif (next_state = NICKEL)    	then RedBull_out <= '0'; --redbull is not dispensed
        elsif (next_state = QUARTER)      then RedBull_out <= '0'; --redbull is not dispensed
        elsif (next_state = ENOUGH)      	then RedBull_out <= '0'; --redbull is not dispensed
        elsif (next_state = EXCESS)     	then RedBull_out <= '0'; --redbull is not dispensed
		  elsif (next_state = VEND)       	then RedBull_out <= '1'; --redbull is dispensed
		  elsif (next_state = CHANGE)     	then RedBull_out <= '0'; --redbull is not dispensed
        else RedBull_out <= '0'; --DEFAULT no redbull is sent
    
        end if;
    end if;
end process;

change_back_out : process(clk) --determines if change should be sent out 
begin
    if(rising_edge(clk)) then
        if (next_state = WAIT1)          	then change_back <= '0'; --change is not given back to the user
        elsif (next_state = DIME)       	then change_back <= '0'; --change is not given back to the user
        elsif (next_state = NICKEL)    	then change_back <= '0'; --change is not given back to the user
        elsif (next_state = QUARTER)      then change_back <= '0'; --change is not given back to the user
        elsif (next_state = ENOUGH)      	then change_back <= '0'; --change is not given back to the user
        elsif (next_state = EXCESS)     	then change_back <= '1'; --change is given back to the user
		  elsif (next_state = VEND)       	then change_back <= '0'; --change is not given back to the user
		  elsif (next_state = CHANGE)     	then change_back <= '1'; --change is  given back to the user
        else change_back <= '0'; --DEFAULT no change sent out
    
        end if;
    end if;
end process;
	    
	    --END OF OUTPUT PROCESSES For leds

	    --used to find what to display in the hex assigner processes
	 tens_dig <=  std_logic_vector((money rem "01100100")/"0001010");
	 ones_dig <= std_logic_vector((money rem "01100100")rem "0001010");
	
	   --assigns the constant for hex1 
	 tens_hex_assigner: process(tens_dig)
    begin
        case tens_dig is 
        when "00000000" => hex1 <= ZERO;
        when "00000001" => hex1 <= ONE;
        when "00000010" => hex1 <= TWO;
        when "00000011" => hex1 <= THREE;
        when "00000100" => hex1 <= FOUR;
        when "00000101" => hex1 <= FIVE;
        when "00000110" => hex1 <= SIX;
        when "00000111" => hex1 <= SEVEN;
        when "00001000" => hex1 <= EIGHT;
        when "00001001" => hex1 <= NINE;
        --WHEN OTHER values of inputs fed in, constant ff is returned.
        when others => hex1 <= FF;
        end case;
		 end process;

	--assigns the constant for hex0
    ones_hex_assigner: process(ones_dig)
    begin
        case ones_dig is 
        when "0000000" => hex0 <= ZERO;
        when "0000001" => hex0 <= ONE;
        when "0000010" => hex0 <= TWO;
        when "0000011" => hex0 <= THREE;
        when "0000100" => hex0 <= FOUR;
        when "0000101" => hex0 <= FIVE;
        when "0000110" => hex0 <= SIX;
        when "0000111" => hex0 <= SEVEN;
        when "0001000" => hex0 <= EIGHT;
        when "0001001" => hex0 <= NINE;
        --WHEN OTHER values of inputs fed in, constant ff is returned.
        when others => hex0 <= FF;
        end case;

    end process ones_hex_assigner;



--end of output processes

end structure;
--END OF ARCHITECTURE


