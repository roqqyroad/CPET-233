--Section: 02
--Lab: 02
--Assignment: Homework 8

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity shift_reg is
port(
	clk, reset_n : in std_logic;
	serial_in : in std_logic;
	serial_out : out std_logic
	);
end shift_reg;

architecture rtl of shift_reg is
	signal shift : std_logic_vector(3 downto 0);
begin
	shifter: process(clk, reset_n)
	begin
		if(reset_n = '0') then
			shift <= "0000";
		elsif (clk'event and clk = '1') then
			shift(3 downto 1) <= shift(2 downto 0);
			shift(0) <= serial_in;
		end if;
	end process;
	serial_out <= shift(3);
end rtl;