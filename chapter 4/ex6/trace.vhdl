ENTITY trace IS
    PORT (
        v : IN bit_vector;
        sum : OUT NATURAL
    );
END ENTITY trace;

ARCHITECTURE behav OF trace IS

BEGIN

    summing : PROCESS (v) IS
        VARIABLE accum : NATURAL;
    BEGIN
        accum := 0;
        FOR i IN v'RANGE LOOP
            accum := accum + 1 WHEN v(i);
        END LOOP;
        sum <= accum;
    END PROCESS summing;

END ARCHITECTURE;
