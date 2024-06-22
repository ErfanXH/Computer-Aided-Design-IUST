-- Define a type for complex numbers
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;	


entity Complex_Number is
    port (
        -- Input ports for the first complex number
        x_real : in std_logic_vector(7 downto 0);
        x_imag : in std_logic_vector(7 downto 0);
        -- Input ports for the second complex number
        y_real : in std_logic_vector(7 downto 0);
        y_imag : in std_logic_vector(7 downto 0);
        -- Input signals to control operations
        do_multiply : in std_logic;
        do_sum : in std_logic;
        do_sub : in std_logic;
        -- Output ports for the result of each operation
        result_real : out std_logic_vector(15 downto 0);
        result_imag : out std_logic_vector(15 downto 0)
    );
end entity Complex_Number;

architecture Behavioral of Complex_Number is

    -- Type definition for complex numbers
    type complex_number is record
        real_part : integer range -128 to 127;
        imag_part : integer range -128 to 127;
    end record;

    -- Signal declarations
    signal x : complex_number;
    signal y : complex_number;
    signal result_real_reg : integer range -32768 to 32767;
    signal result_imag_reg : integer range -32768 to 32767;

begin

    -- Conversion from std_logic_vector to integer
    x.real_part <= to_integer(signed(x_real));
    x.imag_part <= to_integer(signed(x_imag));
    y.real_part <= to_integer(signed(y_real));
    y.imag_part <= to_integer(signed(y_imag));

    -- Multiplication operation
    process(x, y, do_multiply)
    begin		 
		
        if do_multiply = '1' then
            result_real_reg <= (x.real_part * y.real_part) - (x.imag_part * y.imag_part);
            result_imag_reg <= (x.real_part * y.imag_part) + (x.imag_part * y.real_part);	   
		elsif do_sum = '1' then
            result_real_reg <= x.real_part + y.real_part;
            result_imag_reg <= x.imag_part + y.imag_part;
		else
	    	result_real_reg <= x.real_part - y.real_part;
            result_imag_reg <= x.imag_part - y.imag_part;	
        end if;
    end process;

  
    -- Output ports
    result_real <= std_logic_vector(to_signed(result_real_reg , 16));
    result_imag <= std_logic_vector(to_signed( result_imag_reg , 16));

end architecture Behavioral;
