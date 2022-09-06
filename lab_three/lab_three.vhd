--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity
entity lab3 is
    port(
        --inputs
        w, x, y, z : in std_logic;

        --outputs
        a, b, c, d, e, f, g : out std_logic;
        a_cond, b_cond, c_cond, d_cond, e_cond, f_cond, g_cond : out std_logic;
        a_sel, b_sel, c_sel, d_sel, e_sel, f_sel, g_sel : out std_logic 
    );
end lab3;

--architecture
architecture model of lab3 is 
    signal inputs : std_logic_vector(3 downto 0);
begin
    --inputs
    inputs <= w & x & y & z;

    --letter outputs
    a <= ((w AND x) OR (y AND z) OR (w AND NOT Y AND NOT Z));
    b <= ((w AND x) OR (NOT w AND NOT X AND NOT z) OR (NOT w AND y AND z) OR (NOT w AND NOT x AND y) OR (x AND NOT y AND z));
    c <= ((w AND x) OR (NOT w AND y AND z) OR (x AND NOT y AND NOT z));
    d <= ((w AND x) OR (y AND z) OR (w AND NOT Y AND NOT Z));
    e <= ((w AND x) OR (y AND z) OR (NOT w AND NOT x AND NOT z) OR (w AND NOT x AND NOT y));
    f <= ((w AND x) OR (NOT w AND y AND z) OR (w AND NOT x AND NOT y) OR ( x AND NOT y AND NOT z));
    g <= ((w AND x) OR (w AND NOT y AND NOT z) OR (x AND y AND NOT z));

    --cond outputs
        a_cond <= '1' when inputs = ("1100") OR inputs = ("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0011") OR inputs =("1011") OR inputs =("0111") OR inputs =("1000")
        else '0';
        b_cond <= '1' when inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0000") OR inputs =("0010") OR inputs =("0111") OR inputs =("0011") OR inputs =("0101")
        else '0';
        c_cond <= '1' when inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0011") OR inputs =("0111") OR inputs =("0100")
        else '0';
        d_cond <= '1' when inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0011") OR inputs =("0111") OR inputs =("1011") OR inputs =("1000")
        else '0';
        e_cond <= '1' when inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0011") OR inputs =("0111") OR inputs =("1011") OR inputs =("0000") OR inputs =("0010") OR inputs =("1000") OR inputs =("1001")
        else '0';
        f_cond <= '1' when inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("0011")  OR inputs =("0111") OR inputs =("1000") OR inputs =("0100") OR inputs =("1001")
        else '0';
        g_cond <= '1' when inputs = ("1100") OR inputs =("1101") OR inputs =("1110") OR inputs =("1111") OR inputs =("1000") OR inputs =("0110") OR inputs =("1110")
        else '0';
        
    --sel outputs
    with inputs select 
    a_sel <= '1' when "1100" | "1101" | "1110" | "1111" | "0011" | "1011" | "0111" | "1000",
        '0' when others;
	with inputs select
    b_sel <= '1' when "1100" | "1101" | "1110" | "1111" | "0000" | "0010" | "0111" | "0011" | "0101",
        '0' when others;
    with inputs select
	 c_sel <= '1' when "1100" | "1101" | "1110" | "1111" | "0011" | "0111" | "0100",
        '0' when others;
    with inputs select
	 d_sel <= '1' when "1100" | "1101" | "1110" | "1111" | "0011" | "1011" | "0111" | "1000",
        '0' when others;
    with inputs select
	 e_sel <= '1' when "1100" | "1101" | "1110" | "1111" | "0011" | "0111" | "1011" | "0000" | "0010" | "1000" | "1001",
        '0' when others;
    with inputs select
	 f_sel <= '1' when "1100" | "1101" | "1110" | "1111" | "0011" | "0111" | "1000" | "0100" | "1001",
        '0' when others;
    with inputs select
	 g_sel <= '1' when "1100" | "1101" | "1110" | "1111" | "1000" | "0110",
        '0' when others;
    
end model;
