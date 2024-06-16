ENTITY priority_encoder IS
    PORT (x: IN BIT VECTOR (7 DOWNTO 1); 
          y: OUT BIT VECTOR (2 DOWNTO 0));
END priority_encoder;

ARCHITECTURE encoder OF priority_encoder IS
BEGIN
    y(2) <= x(7) OR x(6) OR x(5) OR x(4); 
    y(1) <= x(7) OR x(6) OR ((NOT x(5) AND NOT x(4)) AND (x(3) OR x(2))); 
    y(0) <= x(7) OR (NOT x(6) AND (x(5) OR (NOT x(4) AND (x(3) OR (NOT x(2) AND x(1))))));
END encoder;
