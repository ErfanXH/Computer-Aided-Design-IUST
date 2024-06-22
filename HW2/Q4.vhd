library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AlarmClock is
    Port (
        clk : in  std_logic;
        rst : in  std_logic;
        clock_set : in  std_logic;
        alarm_set : in  std_logic;
        alarm_stop : in  std_logic;	
		
		alarm_minute : in std_logic_vector(7 downto 0 ) ; 
		alarm_hour : in std_logic_vector( 5 downto 0 ) ;  
		set_minute : in std_logic_vector(7 downto 0 ) ; 
		set_hour : in std_logic_vector( 5 downto 0 ) ;   
		
        alarm_on : out std_logic;
        hour_low : out std_logic_vector(3 downto 0);
        hour_high : out std_logic_vector(1 downto 0);
        minute_low : out std_logic_vector(3 downto 0);
        minute_high : out std_logic_vector(3 downto 0) ; 
		second_out : out integer  
    );	
	
end AlarmClock;

architecture Behavioral of AlarmClock is
    signal hour_low_reg : unsigned(3 downto 0) := (others => '0');
    signal hour_high_reg : unsigned(1 downto 0) := (others => '0');
    signal minute_low_reg : unsigned(3 downto 0) := (others => '0');
    signal minute_high_reg : unsigned(3 downto 0) := (others => '0');
    signal alarm_triggered : std_logic := '0';
begin
    process(clk, rst)	
	variable second : integer range 0 to 59 := 0 ; 
    begin
        if rst = '1' then
            hour_low_reg <= (others => '0');
            hour_high_reg <= (others => '0');
            minute_low_reg <= (others => '0');
            minute_high_reg <= (others => '0');
            alarm_triggered <= '0';	  
			second := 0 ; 
        elsif rising_edge(clk) then
            -- Clock set
             if clock_set = '1' then
                hour_low_reg <= unsigned(set_hour(3 downto 0 ));
                hour_high_reg <= unsigned(set_hour(5 downto 4 ));
                minute_low_reg <= unsigned(set_minute(3 downto 0));
                minute_high_reg <= unsigned(set_minute(7 downto 4 ));
            else
                -- Update time 
				 if second = 59 then 
	                if minute_low_reg = "1001" then -- Check if low minute digit is 9
	                    minute_low_reg <= (others => '0'); -- Reset low minute digit
	                    if minute_high_reg = "0101" then -- Check if high minute digit is 5
	                        minute_high_reg <= (others => '0'); -- Reset high minute digit 
							
							if (hour_low_reg = "0011" and hour_high_reg = "10" ) then 	 --check  the hour is 23
								hour_low_reg <= (others => '0'); -- Reset low hour digit
								hour_high_reg <= (others => '0'); -- Reset high hour digit
							else 
		                        if (hour_low_reg = "1001") then -- Check if low hour digit is 9 
		                            hour_low_reg <= (others => '0'); -- Reset low hour digit
		                            hour_high_reg <= hour_high_reg + "01"; -- Increment high hour digit
		                        else
		                            hour_low_reg <= hour_low_reg + "0001"; -- Increment low hour digit
		                        end if;
							end if ; 
							
	                    else
	                        minute_high_reg <= minute_high_reg + "0001"; -- Increment high minute digit
	                    end if;
	                else
	                    minute_low_reg <= minute_low_reg + "0001"; -- Increment low minute digit
	                end if;
					second := 0 ; 
				else 
					second := 1 + second ; 
	            end if;
				
				
            -- Alarm check
	            if alarm_set = '1' and hour_low_reg = unsigned(alarm_hour(3 downto 0)) and 
	               hour_high_reg = unsigned(alarm_hour(5 downto 4)) and minute_low_reg = unsigned(alarm_minute(3 downto 0)) and 
	               minute_high_reg = unsigned(alarm_minute(7 downto 4)) then
	                alarm_triggered <= '1';
	            --elsif alarm_stop = '1' then
--	                alarm_triggered <= '0';
				elsif alarm_stop = '1' then  
					 alarm_triggered <= '0';
	            end if;
			    
					
			end if ; 
        end if;	
		
	second_out <= second ; 
    end process;

    -- Output signals
    alarm_on <= alarm_triggered;
    hour_low <= std_logic_vector(hour_low_reg);
    hour_high <= std_logic_vector(hour_high_reg);
    minute_low <= std_logic_vector(minute_low_reg);
    minute_high <= std_logic_vector(minute_high_reg);

end Behavioral;
