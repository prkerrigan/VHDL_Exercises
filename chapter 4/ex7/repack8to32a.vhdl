ENTITY repack8to32a IS
    PORT (
        v1 : IN bit_vector(0 TO 7);
        v2 : OUT bit_vector(0 TO 31)
    );
END ENTITY repack8to32a;

ARCHITECTURE cycle OF repack8to32a IS
BEGIN
    place_and_shift : PROCESS (v1) IS
        VARIABLE v : bit_vector(0 TO 31);
    BEGIN
        -- Initialize v with all zeros
        v := (OTHERS => '0');

        -- Assign v1 to the upper part of v
        FOR i IN v1'RANGE LOOP
            v(i + 24) := v1(i);
        END LOOP;

        -- Perform arithmetic fill left by 24 bits
        v(0 TO 24) := (OTHERS => v1(0));

        v2 <= v;
    END PROCESS place_and_shift;
END ARCHITECTURE cycle;
