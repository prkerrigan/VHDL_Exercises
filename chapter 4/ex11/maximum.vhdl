ENTITY maximum IS
    PORT (
        sample : IN integer_vector;
        max : OUT INTEGER
    );
END ENTITY maximum;

ARCHITECTURE behav OF maximum IS
BEGIN

    find : PROCESS (sample) IS
        VARIABLE partial_max : INTEGER;
    BEGIN

        partial_max := INTEGER'low;

        FOR i IN sample'RANGE LOOP
            IF sample(i) > partial_max THEN
                partial_max := sample(i);
            END IF;
        END LOOP;
        
        max <= partial_max;

    END PROCESS find;

END ARCHITECTURE;
