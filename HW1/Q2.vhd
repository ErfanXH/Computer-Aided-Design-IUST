library IEEE;
use IEEE.STD_LOGIC_1164.aLL;

entity Comparator is
	port (
		a, b: in std_logic_vector(3 downto 0);
		gt, eq, lt: out std_logic
	);
end Comparator;

architecture behavioral of Comparator is
begin
	gt <= '1' when (a > b) else '0';
	eq <= '1' when (a = b) else '0';
	lt <= '1' when (a < b) else '0';
end behavioral;