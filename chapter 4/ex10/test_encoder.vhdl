ENTITY test_encoder IS
END ENTITY test_encoder;

ARCHITECTURE test OF test_encoder IS
    SIGNAL bytes : bit_vector(0 TO 15);
    SIGNAL first : NATURAL RANGE 0 TO 15;
    SIGNAL any : BIT;
BEGIN

    dut : ENTITY work.encoder(behav)
        PORT MAP(bytes, first, any);

    stimulus : PROCESS IS
    BEGIN

        bytes <= (OTHERS => '0');
        WAIT FOR 5 ns;
        bytes <= ('1', OTHERS => '0');
        WAIT FOR 5 ns;
        bytes <= ('0', OTHERS => '1');
        WAIT FOR 5 ns;
        bytes <= (14 => '1', OTHERS => '0');
        WAIT FOR 5 ns;

    END PROCESS stimulus;

END ARCHITECTURE;
