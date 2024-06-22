library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MyBuffer is
    Port (
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        write : in  STD_LOGIC;
        read  : in  STD_LOGIC;
        data_in : in  STD_LOGIC_VECTOR(7 downto 0);
        data_out : out STD_LOGIC_VECTOR(7 downto 0);
        Full : out STD_LOGIC;
        Empty : out STD_LOGIC
    );
end MyBuffer;

architecture Behavioral of MyBuffer is
	signal readp , writep ,num_data : integer range 0 to 11 ;
	signal limit : integer range 0 to 11 := 11; 
    type buffer_array is array (0 to limit) of std_logic_vector(7 downto 0);
    signal data_buffer : buffer_array;	
begin
    process(clk, rst)
    begin
        if rst = '1' then
            readp <= 0;
            writep <= 0;	
			num_data <= 0 ; 
			limit <= 11 ; 
           data_buffer <= (others => (others => '0')); 
		   data_out <= ( others => '0' ) ; 
		   
        elsif rising_edge(clk) then	  
			
            if write = '1' then	 
			   if( num_data < limit ) then 
				 data_buffer(writep) <= data_in ; 
				 writep <= ((writep + 1) mod limit ) ; 
				 num_data <= num_data + 1 ; 
               end if ; 
            end if;

            if read = '1' then
               if( num_data > 0  ) then 
				  data_out <= data_buffer(readp) ; 
				  readp <= ((readp + 1) mod limit ) ; 
				  num_data <= num_data - 1; 
               end if ;
            end if;	 
			
        end if;
    end process;

    Full <= '1' when (num_data=limit) else '0';
    Empty <= '1' when (num_data=0) else '0';

end Behavioral;
