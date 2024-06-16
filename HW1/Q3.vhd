library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity ALU is
	port (
	a: in std_logic_vector (7 downto 0);
	b: in std_logic_vector (7 downto 0);
	sel: in std_logic_vector (2 downto 0);
	y: out std_logic_vector (7 downto 0);
	cin: in std_logic
		);
end ALU;		

architecture behavioral of ALU is 

begin  
	Y <= a + '1' when sel = "000" else
	std_logic_vector(unsigned(a) + unsigned(b)) when sel = "001" else
	std_logic_vector(signed(a) + signed(b)) when sel = "010" else
	a + b + cin when sel = "011" else
	(not a) when sel = "100" else
	((not a) + '1') when sel = "101" else
	a nand b when sel = "110" else
	a xor b when sel = "111" else
	"00000000";
									       
end behavioral;
				
