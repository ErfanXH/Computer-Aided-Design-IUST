-- The Component (FAU) --
ENTITY FAU IS
    PORT (a, b, cin: IN BIT;
          s, cout: OUT BIT );
END FAU;

ARCHITECTURE full_adder OF FAU IS
BEGIN
    s <= a XOR b XOR cin;
    cout <= (a AND b) OR (a AND cin) OR (b AND cin);
END full_adder;
--

-- Main Code --
ENTITY carry_ripple_adder IS
    GENERIC (N: INTEGER := 8);
    PORT ( a, b: IN BIT_VECTOR(N-1 DOWNTO 0);
           cin: IN BIT;
           s: OUT BIT_VECTOR(N-1 DOWNTO 0);
           cout: OUT BIT);
END carry_ripple_adder;

ARCHITECTURE structural OF carry_ripple_adder IS
    SIGNAL carry: BIT_VECTOR(N DOWNTO 0);
    COMPONENT FAU IS
        PORT (a, b, cin: IN BIT; s, cout: OUT BIT);
    END COMPONENT;
BEGIN
    carry(0) <= cin;
    generate_adder: FOR i IN a'RANGE GENERATE 
        adder: FAU PORT MAP (a(i), b(i), carry(i), s(i), carry(i+1));
    END GENERATE;
    cout <= carry(N);
END structural;