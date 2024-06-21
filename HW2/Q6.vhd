LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;						  
use IEEE.NUMERIC_STD.ALL;	 

ENTITY traffic_light IS
    PORT (
        D0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        D1 : OUT STD_LOGIC;
        IS_GREEN : OUT STD_LOGIC;
        IS_YELLOW : OUT STD_LOGIC;
        IS_RED : OUT STD_LOGIC
    );
END traffic_light;

ARCHITECTURE Behavioral OF traffic_light IS
    SIGNAL CLK : STD_LOGIC := '0';
BEGIN
    PROCESS
    BEGIN
        CLK <= '0';
        WAIT FOR 500 ms;
        CLK <= '1';
        WAIT FOR 500 ms;
    END PROCESS;

    PROCESS (CLK)
        VARIABLE S : INTEGER RANGE 0 TO 30 := 0;
    BEGIN
        IF rising_edge(CLK) THEN
            IF S < 15 THEN
                IS_GREEN <= '1';
                IS_YELLOW <= '0';
                IS_RED <= '0';
                IF (S <= 5) THEN
                    D1 <= '1';
                    D0 <= STD_LOGIC_VECTOR(to_unsigned(5 - S, 4));
                ELSE
                    D1 <= '0';
                    D0 <= STD_LOGIC_VECTOR(to_unsigned(15 - S, 4));
                END IF;
            ELSIF S < 20 THEN
                IS_GREEN <= '0';
                IS_YELLOW <= '1';
                IS_RED <= '0';
                D1 <= '0';
                D0 <= STD_LOGIC_VECTOR(to_unsigned(20 - S, 4));
            ELSE
                IS_GREEN <= '0';
                IS_YELLOW <= '0';
                IS_RED <= '1';
                IF (S = 20) THEN
                    D1 <= '1';
                    D0 <= "0000";
                ELSE
                    D1 <= '0';
                    D0 <= STD_LOGIC_VECTOR(to_unsigned(30 - S, 4));
                END IF;
            END IF;
            IF (S = 29) THEN
                S := 0;
            ELSE
                S := S + 1;
            END IF;
        END IF;
    END PROCESS; -- 
END Behavioral;