PACKAGE diskette IS
    CONSTANT sector_length : POSITIVE := 18;
    CONSTANT track_length : POSITIVE := 80;
    CONSTANT side_number : POSITIVE := 2;

    TYPE index IS RECORD
        sector : NATURAL RANGE 0 TO sector_length;
        track : NATURAL RANGE 0 TO track_length;
        sides : NATURAL RANGE 0 TO side_number;
    END RECORD index;

    TYPE occupied IS ARRAY (
    1 TO sector_length,
    1 TO track_length,
    1 TO side_number
    ) OF BIT;

END PACKAGE diskette;

USE work.diskette.ALL;
ENTITY sector_tracker IS
    PORT (
        state : IN occupied;
        ix : OUT index
    );
END ENTITY sector_tracker;

ARCHITECTURE behav OF sector_tracker IS
BEGIN

    search : PROCESS (state) IS
        -- for the first free sector and assign its location to ix
        VARIABLE temp : index;
    BEGIN
        temp := (0, 0, 0);
        outer : FOR si IN state'RANGE(1) LOOP
            FOR tr IN state'RANGE(2) LOOP
                FOR sect IN state'RANGE(3) LOOP
                    IF state(si, tr, sect) THEN
                        temp := (si, tr, sect);
                        EXIT outer;
                    END IF;
                END LOOP;
            END LOOP;
        END LOOP;
        ix <= temp;

    END PROCESS search;

END ARCHITECTURE behav;
