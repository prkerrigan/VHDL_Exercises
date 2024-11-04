ENTITY counter IS
    PORT (
        clk : IN BIT;
        count : OUT INTEGER := 0);
END ENTITY counter;

ARCHITECTURE behav OF counter IS

BEGIN
    counting : PROCESS IS
        VARIABLE internal_count : NATURAL;
    BEGIN
        IF RISING_EDGE(clk) THEN
            internal_count := NATURAL'succ(internal_count);
        END IF;
        count <= internal_count;
        WAIT ON clk;
    END PROCESS counting;
END ARCHITECTURE;