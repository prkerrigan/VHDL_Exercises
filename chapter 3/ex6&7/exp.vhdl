ENTITY exp IS
    PORT (
        x : IN REAL;
        result : OUT REAL);
END ENTITY exp;

ARCHITECTURE series OF exp IS
BEGIN

    summation : PROCESS (x) IS
        VARIABLE sum, term : REAL;
        VARIABLE n : NATURAL;
    BEGIN
        sum := 1.0;
        term := 1.0;
        n := 0;
        WHILE ABS term > ABS (sum / 104.0) LOOP
            n := n + 1;
            term := term * x / REAL(n);
            sum := sum + term;
        END LOOP;
        result <= sum;
    END PROCESS summation;

END ARCHITECTURE series;

ARCHITECTURE bounded OF exp IS
BEGIN

    summation : PROCESS (x) IS
        VARIABLE sum, term : REAL;
    BEGIN
        sum := 1.0;
        term := 1.0;
        FOR n IN 1 TO 7 LOOP
            term := term * x / REAL(n);
            sum := sum + term;
        END LOOP;
        result <= sum;
    END PROCESS summation;

END ARCHITECTURE bounded;