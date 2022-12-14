--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*********  Copyright 2011, Rochester Institute of Technology  ***************
--*****************************************************************************
--
--  DESIGNER NAME: Jeanne Christman
--
--       LAB NAME: State Machines II
--
--      FILE NAME: vending_machine_tb.vhd
--
--   DATE CREATED: 10/30/11
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This test bench will test a vending machine with the following specifications:
--      The machine accepts dimes, nickels and quarters only.  Only one coin can be input at a time.
--       If the dispense button is pushed before there has been $0.75 input, it is ignored.  
--       If the button is pushed after $0.75 has been deposited, the machine outputs the drink and 
--       any change, if applicable.
--       Once $0.75 has been deposited, any further deposits go immediately out on the change_return.
--       If the coin_return input is pressed at any time, all money is returned.
--       Two seven segment displays will always display the current balance in the machine.
-- Inputs:
-- o	Dime_In, Nickel_in, Quarter_in: a logic 1 on these inputs indicate which coin has been deposited.  
-- o	Coin_return: This input indicates that the user would like their money back. 
-- o	Dispense: This input indicates that the user would like their drink.  
-- o	Clk: this is the system clock running at 50 MHz.
-- o	Reset_n:  this is the system reset.

-- Outputs
-- o	Change_back: this output indicates that change is being returned.  
-- o	Red Bull: This output indicates that the drink has been dispensed.  
-- o	HEX1 & HEX0  these are the outputs that turn on the individual segments of the 7-segment displays.
--    1 is the left display and 0 is the right display
--
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 10/30/11 | JWC  | 1.0 | Created
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY vending_tb_vhd IS
END vending_tb_vhd;

ARCHITECTURE behavior OF vending_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT Vending_fsm
	PORT(
	    S         : in std_logic;
		Nickel_in : IN std_logic;
		Dime_in : IN std_logic;
		Quarter_in : IN std_logic;
		Dispense_in : IN std_logic;
		Coin_Return : IN std_logic;
		clk : IN std_logic;
		reset_n : IN std_logic;          
		RedBull_out : OUT std_logic;
		change_back : OUT std_logic;
		hex1 : OUT std_logic_vector(6 downto 0);
		hex0 : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL Nickel_in :  std_logic := '0';
	SIGNAL Dime_in :  std_logic := '0';
	SIGNAL Quarter_in :  std_logic := '0';
	SIGNAL Dispense_in :  std_logic := '0';
	SIGNAL Coin_Return :  std_logic := '0';
	SIGNAL clk :  std_logic := '0';
	SIGNAL reset_n :  std_logic := '0';
	signal s : std_logic := '0';

	--Outputs
	SIGNAL RedBull_out :  std_logic;
	SIGNAL change_back :  std_logic;
	SIGNAL hex1 :  std_logic_vector(6 downto 0);
	SIGNAL hex0 :  std_logic_vector(6 downto 0);
	
	-- signals for test bench control
    SIGNAL sim_done : boolean := false;
    SIGNAL PERIOD_c : time    := 20 ns;  -- 50MHz

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: Vending_fsm PORT MAP(
	    s => s,
		Nickel_in => Nickel_in,
		Dime_in => Dime_in,
		Quarter_in => Quarter_in,
		Dispense_in => Dispense_in,
		Coin_Return => Coin_Return,
		clk => clk,
		reset_n => reset_n,
		RedBull_out => RedBull_out,
		change_back => change_back,
		hex1 => hex1,
		hex0 => hex0
	);
	   -- This creates an clock that will shut off at the end of the Simulation
    -- this makes a clock that you can shut off when you are done.
    clk <= NOT clk AFTER PERIOD_C/2 WHEN (NOT sim_done) ELSE '0';
	
	tb : PROCESS
	BEGIN
    reset_n <= '0';   --assert the reset
	wait for 1 ns;
	 -- now lets sync the stimulus to the clock
    WAIT UNTIL clk = '1';
	reset_n <= '1';  --deassert reset
	wait for 10 ns;
----------------exact change with attempt to put in more money then vend ----------------------------	
	nickel_in <= '1'; --put in a nickel  hex displays should say 05
	wait for 100 ns;
	nickel_in <= '0';
	wait for 100 ns;
	dime_in <= '1'; --put in a dime 15 hex displays should say 15
	wait for 100 ns;
	dime_in <= '0';
	wait for 100 ns;
	quarter_in <= '1';  --put in a quarter  hex displays should say 40
	wait for 100 ns;
	quarter_in <= '0';
	wait for 100 ns;
	quarter_in <= '1';  -- put in another quarter hex displays should say 65
	wait for 100 ns;
	quarter_in <= '0';
	wait for 100 ns;
	dime_in <= '1';  -- put in a dime hex displays should say 75
	wait for 100 ns;
	dime_in <= '0';
	wait for 100 ns;
	dime_in <= '1';   --put in a dime hex displays should say 75 coin_return should be active
	wait for 100 ns;
	dime_in <= '0';
	wait for 100 ns;
	nickel_in <= '1'; --put in a nickel hex displays should say 75 coin_return should be active
	wait for 100 ns;
	nickel_in <= '0';
	wait for 100 ns;
	dispense_in <= '1'; --displense drink hex displays should say 0 red_bull output should be active
	wait for 100 ns;
	dispense_in <= '0';
	wait for 100 ns;
--------------------------------more than $.75 with vend and change return ------------------------------------------
	nickel_in <= '1'; --put in a nickel  hex displays should say 05
	wait for 140 ns;
	nickel_in <= '0';
	wait for 100 ns;
	dime_in <= '1'; --put in a dime 15 hex displays should say 15
	wait for 100 ns;
	dime_in <= '0';
	wait for 100 ns;
	quarter_in <= '1';  --put in a quarter  hex displays should say 40
	wait for 100 ns;
	quarter_in <= '0';
	wait for 100 ns;
	quarter_in <= '1';  -- put in another quarter hex displays should say 65
	wait for 100 ns;
	quarter_in <= '0';
	wait for 100 ns;
	quarter_in <= '1';  -- put in a quarter hex displays should say 90
	wait for 100 ns;
	quarter_in <= '0';
	wait for 100 ns;
	dispense_in <= '1'; --displense drink hex displays should say 15 red_bull output should be active
	wait for 100 ns;     --coin_return will go active and then hex display will say 00.
	dispense_in <= '0';
--------------------------------no vend just change return -----------------------------------------------------------
	nickel_in <= '1';   -- put in nickel hex displays should say 05
	wait for 140 ns;
	nickel_in <= '0';
	wait for 100 ns;
	dime_in <= '1';  -- put in dime hex displays should say 15
	wait for 100 ns;
	dime_in <= '0';
	wait for 100 ns;
	quarter_in <= '1'; -- put in quarter hex displays should say 40
	wait for 100 ns;
	quarter_in <= '0';
	wait for 100 ns;
	quarter_in <= '1';  -- put in quarter hex displays should say 65
	wait for 100 ns;
	quarter_in <= '0';
	wait for 100 ns;
	coin_return <= '1';  -- ask for change back hex displays should say 0 coin_return should be active
	wait for 100 ns;
	coin_return <= '0';
	wait for 200 ns;
	sim_done <= true;
        WAIT FOR 1 us;
	wait;
	END PROCESS;

END;
