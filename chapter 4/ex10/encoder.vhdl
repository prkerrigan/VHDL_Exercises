ENTITY encoder IS
    PORT (
        bytes : IN bit_vector(0 TO 15);
        first : OUT NATURAL RANGE 0 TO 15;
        any : OUT BIT
    );
END ENTITY encoder;

ARCHITECTURE behav OF encoder IS

BEGIN

    search : PROCESS (bytes) IS
        VARIABLE buf : BIT;
    BEGIN

        buf := OR bytes;

        IF buf THEN
            FOR i IN bytes'RANGE LOOP
                IF bytes(i) THEN
                    first <= i;
                    EXIT;
                END IF;
            END LOOP;
        END IF;

        any <= buf;

    END PROCESS search;

END ARCHITECTURE;
