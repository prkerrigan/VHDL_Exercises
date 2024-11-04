ENTITY average_30 IS
    PORT (
        samples : IN INTEGER_VECTOR(1 TO 30);
        average : OUT REAL
    );
END ENTITY average_30;

ARCHITECTURE behavioral OF average_30 IS

BEGIN

    compute : PROCESS (samples) IS
        VARIABLE sum : INTEGER;
    BEGIN
        sum := 0;
        FOR i IN samples'RANGE LOOP
            sum := sum + samples(i);
        END LOOP;
        average <= REAL(sum) / 30.0;
    END PROCESS compute;

END ARCHITECTURE;