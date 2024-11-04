ENTITY average16 IS
    PORT (
        clk : IN BIT;
        datum : IN REAL;
        average : OUT REAL
    );
END ENTITY average16;

ARCHITECTURE behav OF average16 IS
    subtype index is integer range 16 downto 0;
BEGIN

    averaging : PROCESS (clk) IS
        VARIABLE sum : REAL := 0.0;
        VARIABLE count : index;
    BEGIN

        IF count = 0 THEN
            average <= sum / 16.0;
            sum := 0.0;
            count := 16;
        END IF;

        IF RISING_EDGE(clk) THEN
            sum := sum + datum;
            count := index'rightof(count);
        END IF;

    END PROCESS averaging;
END ARCHITECTURE behav;