library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PasswordSystem is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        input  : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end PasswordSystem;

architecture Behavioral of PasswordSystem is
    signal count : integer := 0;
    signal password : STD_LOGIC_VECTOR (3 downto 0) := "0110";
    signal entered_password : STD_LOGIC_VECTOR (3 downto 0) := "0000";

    function check_password(entered : STD_LOGIC_VECTOR(3 downto 0)) return BOOLEAN is
    begin
        return (entered = "0110");
    end function;
begin

    process(clk, reset)
    begin
        if reset = '1' then
            count <= 0;
            entered_password <= "0000";
            output <= '0';
        elsif rising_edge(clk) then
            if count < 4 then
                entered_password(count) <= input;
                count <= count + 1;
            end if;
           
            if count = 4 then
                if check_password(entered_password) then
                    output <= '1';
                else
                    count <= 0;
                    entered_password <= "0000";
                    output <= '0';
                end if;
            end if;
        end if;
    end process;

end Behavioral;