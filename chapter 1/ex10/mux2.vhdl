ENTITY mux2 IS
    PORT (
        a, b, sel : IN BIT;
        z : OUT BIT);
END ENTITY mux2;

ARCHITECTURE behav OF mux2 IS
BEGIN
    selector : PROCESS IS
    BEGIN
        IF sel THEN
            z <= b;
        ELSE
            z <= a;
        END IF;
        WAIT FOR 1 ns;
    END PROCESS selector;
END ARCHITECTURE behav;
