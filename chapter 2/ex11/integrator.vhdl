ENTITY integrator IS
    PORT (
        data : IN REAL;
        clk : IN BIT;
        integral : OUT REAL);
END ENTITY integrator;

ARCHITECTURE behav OF integrator IS
BEGIN
    integrate : PROCESS IS
        VARIABLE sum : REAL := 0.0;
    BEGIN
        IF RISING_EDGE(clk) THEN
            sum := sum + data;
        END IF;
        integral <= sum;
        WAIT ON clk;
    END PROCESS integrate;
END ARCHITECTURE;
