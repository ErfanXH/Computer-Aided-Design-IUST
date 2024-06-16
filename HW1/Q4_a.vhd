ENTITY priority_encoder IS
    PORT (x: IN  BIT_VECTOR (7 DOWNTO 1); 
          y: OUT BIT_VECTOR (2 DOWNTO 0));
END priority_encoder;

ARCHITECTURE encoder OF priority_encoder IS
BEGIN
    y <= "111" WHEN x(7)='1' ELSE 
         "110" WHEN x(6)='1' ELSE 
         "101" WHEN x(5)='1' ELSE
         "100" WHEN x(4)='1' ELSE 
         "011" WHEN x(3)='1' ELSE 
         "010" WHEN x(2)='1' ELSE 
         "001" WHEN x(1)='1' ELSE
         "000";
END encoder;
