LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY data_converter IS
    GENERIC (N: INTEGER := 4);
    PORT ( input: IN INTEGER RANGE 0 TO 2**N-1;
           output: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END data_converter;

ARCHITECTURE data_converter OF data_converter IS
    SIGNAL x: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    FUNCTION conv_std_logic (arg: INTEGER; size: INTEGER)
            RETURN STD_LOGIC_VECTOR IS
        VARIABLE temp: INTEGER RANGE 0 TO 2**size-1;
        VARIABLE result: STD_LOGIC_VECTOR(size-1 DOWNTO 0);
    BEGIN
        temp := arg;
        FOR i IN result'RANGE LOOP
            IF (temp>=2**i) THEN
                result(i) := '1';
                temp := temp - 2**i;
            ELSE
                result(i) := '0';
            END IF;
        END LOOP;
        RETURN result;
    END conv_std_logic;
BEGIN
    output <= conv_std_logic(input, N);
END data_converter;