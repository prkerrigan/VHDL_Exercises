ENTITY test_maximum IS
END ENTITY test_maximum;

ARCHITECTURE test OF test_maximum IS
    SIGNAL sample0 : integer_vector(1 TO 0);
    SIGNAL sample15 : integer_vector(0 TO 15);
    SIGNAL null_max : INTEGER;
    SIGNAL max : INTEGER;
BEGIN

    null_dut : ENTITY work.maximum(behav)
        PORT MAP(sample0, null_max);

    dut : ENTITY work.maximum(behav)
        PORT MAP(sample15, max);

    stimulus : PROCESS IS
    BEGIN

        sample15 <= (0, 0, 0, OTHERS => 1);
        WAIT FOR 5 ns;

        sample15 <= (31, 20, OTHERS => 0);
        WAIT FOR 5 ns;

        sample15 <= (3, 1, 21, 15, 40, 1, (-1), 12, OTHERS => 0);
        WAIT FOR 5 ns;

        sample15 <= ((-1), OTHERS => (-2));
        WAIT FOR 5 ns;

    END PROCESS stimulus;

END ARCHITECTURE;
