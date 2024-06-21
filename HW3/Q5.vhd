library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.matrix_pkg.all;

entity convolution is
    generic (
        ksize  : INTEGER := 4
        csize : INTEGER := 3;
    );
    port (
        clk     : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        KERNEL  : in  matrix(0 to ksize-1, 0 to ksize-1);
        CHANNEL : in  matrix(0 to csize-1, 0 to csize-1);
        RESULT  : out matrix(0 to csize-ksize, 0 to csize-ksize) 
    );
	
end convolution;

architecture Behavioral of convolution is
    constant rsize : INTEGER := csize - ksize + 1;
    signal channel_matrix : matrix(0 to csize-1, 0 to csize-1) := CHANNEL;
    signal kernel_matrix  : matrix(0 to ksize-1, 0 to ksize-1) := KERNEL;
    signal result_matrix  : matrix(0 to csize-ksize, 0 to csize-ksize);
begin
    process(clk, rst)
		variable temp    : UNSIGNED(15 downto 0) := (others => '0');
		variable is_done : STD_LOGIC := '0';
        variable i, j    : INTEGER range 0 to rsize-1 := 0;
        variable k, l    : INTEGER range 0 to ksize-1 := 0;
    begin
        if rst = '1' then
            
			is_done := '0';
			result_matrix <= (others => (others => (others => '0')));
			i := 0; j := 0; k := 0; l := 0;	
			 for i in 0 to rsize-1 loop
                for j in 0 to rsize-1 loop
                    RESULT(i, j) <= (others => '0');
                end loop;
            end loop;

		elsif rising_edge(clk) then
            if (is_done = '0') then
                temp := result_matrix(i, j) + channel_matrix(i+k, j+l) * kernel_matrix(k, l);
                if temp > 255 then
                    result_matrix(i, j) <= (others => '1');
                else
                    result_matrix(i, j) <= temp(7 downto 0);	  
                end if;

                if l < ksize-1 then
                    l := l + 1;
                else
                    l := 0;
                    if k < ksize-1 then
                        k := k + 1;
                    else
                        k := 0;
                        if j < rsize-1 then
                            j := j + 1;
                        else
                            j := 0;
                            if i < rsize-1 then
                                i := i + 1;
                            else
                                i := 0;
                                is_done := '1';
                            end if;
                        end if;
                    end if;
                end if;
             else		
			 	for i in 0 to rsize-1 loop
	                for j in 0 to rsize-1 loop
	                    RESULT(i , j ) <= result_matrix(i, j);
	                end loop;
            	end loop;	
				
            end if;
        end if;
    end process;
end Behavioral;
