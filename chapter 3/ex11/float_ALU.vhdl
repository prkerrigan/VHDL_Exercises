ENTITY floating_ALU IS
    PORT (
        x, y : IN REAL;
        f0, f1 : IN BIT;
        z : OUT REAL
    );
END ENTITY floating_ALU;

ARCHITECTURE behav OF floating_ALU IS
BEGIN

    alu : PROCESS (x, y, f0, f1) IS
        VARIABLE result : REAL;
    BEGIN

        result := x + y WHEN NOT f0 AND NOT f1
    ELSE x - y WHEN f0 AND NOT f1
    ELSE x * y WHEN NOT f0 AND f1
    ELSE x / y WHEN y /= 0.0
    ELSE REAL'HIGH;

        z <= result;

    END PROCESS alu;

END ARCHITECTURE behav;