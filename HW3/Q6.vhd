library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity serial_communication is
    port (
        clk    : in  STD_LOGIC;
        input  : in  STD_LOGIC;
        output : out STD_LOGIC_VECTOR (9 downto 0)
    );
end serial_communication;

architecture Behavioral of serial_communication is
    signal one_cnt, zero_cnt : INTEGER range 0 to 8 := 0;
    signal flag : STD_LOGIC := '0';				  
	signal count : INTEGER range 0 to 8 := 8;
begin	
	-- detect falling edge
    process(input)
    begin
        if falling_edge(input) then
            flag <= '1';
        else
            flag <= '0';
        end if;
    end process;

    process(input, clk)
    begin
        if rising_edge(clk) then  
			if count = 8 and flag = '1'then 
				zero_cnt <= 0;
                one_cnt  <= 0;
                count    <= 0;
            elsif count < 8 then
                if input = '0' then
                	zero_cnt <= zero_cnt +1 ;     
                else
					one_cnt <= one_cnt + 1;
                end if;
                count <= count + 1;
            else
                output(4) <= '0';
                output(3 downto 0) <= std_logic_vector(to_unsigned(zero_cnt, 4));
				output(9) <= '1';
                output(8 downto 5) <= std_logic_vector(to_unsigned(one_cnt, 4));
            end if;
        end if;
    end process;
end Behavioral;
