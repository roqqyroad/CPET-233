--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Homework Five - Question One

--entity start
entity question_one is
    port(
        --inputs
        in_num : in std_logic_vector(7 downto 0);
        
        --outputs
        out_num : out std_logic_vector(7 downto 0);
        n : out std_logic
    );
end question_one;
--entity end


--architecture start
architecture model of question_one is

begin

    --if then else statement 
    if_statement: process(inputs)
    begin
        --if it is negative, take two's complement of the number && n = 1
        if (in_num(7) = '1') then
        out_num <= ((in_num NAND "00000001") + "00000001");
        n <= '1';    
 
        --else, out_num no change && n = 0
        else
            out_num <= in_num;
            n <= '0';
        end if;
    end process;        
    --end of if statement


end model;
--architecture end
