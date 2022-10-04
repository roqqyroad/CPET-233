--Name: Rachel DuBois
--Section: 02
--Lab: 02
--Assignment: Lab Six - Binary to SSD

--START OF ENTITY
entity binary_to_ssd is
    port(
        --INPUTS
        in_num : in std_logic_vector(7 downto 0);

        --OUTPUTS
        HEX3 : out std_logic_vector(6 downto 0); --for telling neg or pos
        HEX2 : out std_logic_vector(6 downto 0); --for hundreds_dig value
        HEX1 : out std_logic_vector(6 downto 0); --for tens_dig value
        HEX0 : out std_logic_vector(6 downto 0)  --for ones_dig value
    );
end binary_to_ssd;
--END OF ENTITY

--START OF ARCHITECTURE
architecture structure of binary_to_ssd is

    --SIGNALS
    signal abs_num : std_logic_vector(7 downto 0);
    signal hundreds_dig : std_logic_vector();
    signal tens_dig : std_logic_vector();
    signal ones_dig : std_logic_vector();
    signal hex3 : std_logic_vector(6 downto 0);
    signal hex2 : std_logic_vector(6 downto 0);
    signal hex1 : std_logic_vector(6 downto 0);
    signal hex0 : std_logic_vector(6 downto 0);
    
    --end of signals

    --CONSTANTS
    constant ZERO : std_logic_vector(6 downto 0) := "1000000";
    constant NINE : std_logic_vector(6 downto 0) := "0011000";
    constant EIGHT :  std_logic_vector(6 downto 0) := "0000000";
    constant SEVEN : std_logic_vector(6 downto 0) := "1111000";
    constant SIX : std_logic_vector(6 downto 0) := "0000010";
    constant FIVE : std_logic_vector(6 downto 0) := "0010010";
    constant FOUR : std_logic_vector(6 downto 0) := "0011001";
    constant THREE : std_logic_vector(6 downto 0) := "0110000";
    constant TWO : std_logic_vector(6 downto 0) := "0100100";
    constant ONE : std_logic_vector(6 downto 0) := "1111001";
    constant DASH : std_logic_vector(6 downto 0) := "0111111";
    constant BLANK : std_logic_vector(6 downto 0) := "1111111";
    --end of constants

    --COMPONENTS
    --start of is_neg
    component is_neg is
        port(
            --INPUTS
            DASH, BLANK : in std_logic_vector(6 downto 0);
            num: in std_logic;

            --OUTPUTS
            hex : out std_logic_vector(6 downto 0)
        );
    end component;
    --end of is_neg
    
    --start of abs
    component abs is
        port(
            --INPUTS
            num : in std_logic_vector(7 downto 0);

            --OUTPUTS
            abs_num : out std_logic_vector(7 downto 0)
        );
    end component;
    --end of abs

    --start of convert_to_constant
    component convert_to_constant is
        port(
            --INPUTS a _dig value
            dig : in std_logic_vector();

            --OUTPUTS to a hex display value
            hex : out std_logic_vector(6 downto 0)
        );
    end component;
    --end of convert_to_constant

--architecture actually begins
begin

    --PORT MAPS

    is_neg : is_neg
    port map(
        num => in_num(7),
        DASH => DASH,
        BLANK => BLANK,
        hex => hex3
    );

    abs_v : abs
    port map(
        num => in_num,
        abs_num => abs_num
    );

    h_dig : convert_to_constant
    port map(

    );

    t_dig : convert_to_constant
    port map(

    );

    o_dig : convert_to_constant
    port map(
        
    );

end structure;
--END OF ARCHITECTURE

