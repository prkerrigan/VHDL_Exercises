ENTITY test_trace IS
END ENTITY test_trace;

ARCHITECTURE test OF test_trace IS
    SIGNAL source : bit_vector(1 TO 10);
    SIGNAL sum : NATURAL;
BEGIN

    dut : ENTITY work.trace(behav)
        PORT MAP(source, sum);

    stimulus : PROCESS IS
    BEGIN
        source <= (OTHERS => '1');
        WAIT FOR 5 ns;
        source <= ('1', OTHERS => '0');
        WAIT FOR 5 ns;
        source <= ('1', '1', '1', OTHERS => '0');
        WAIT FOR 5 ns;
    END PROCESS stimulus;

END ARCHITECTURE;
