library IEEE;				   
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity stack is
	generic (
        N : integer := 8; 
        M : integer := 4  
    );
	port (
	clock: in std_logic;
	reset: in std_logic;
    push: in std_logic;
    pop: in std_logic;
    data_in: in std_logic_vector(M - 1 downto 0);
    data_out: out std_logic_vector(M - 1 downto 0);
    full: out std_logic;
    empty: out std_logic;
	error: out std_logic
		);
end stack;		

architecture Behavioral of Stack is
    type stack_type is array (0 to N-1) of std_logic_vector(M - 1 downto 0);
    signal stack : stack_type;
    signal count : integer range 0 to N-1 := 0;
begin
    process (clock, reset)
    begin
        if reset = '1' then
            count <= 0;
			error <= '0';
        elsif rising_edge(clock) then
            if push = '1' and full = '0' then
               	stack(count) <= data_in;
                count <= count + 1;	
            elsif pop = '1' and empty = '0' then
            	count <= count - 1;	 
            end if;
        end if;
    end process;

    full <= '1' when count = N else '0';
    empty <= '1' when count = 0 else '0';  
	error <= '1' when (full = '1' and push = '1') or (empty = '1' and pop = '1') else '0';

    data_out <= stack(count - 1) when not empty = '1' else (others => '0');
end Behavioral;