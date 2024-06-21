library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package matrix_pkg is
    type matrix is array (natural range <>, natural range <>) of UNSIGNED(7 downto 0);
end package matrix_pkg;