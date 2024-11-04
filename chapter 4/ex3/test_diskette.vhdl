ENTITY test_diskette IS
END ENTITY test_diskette;

USE work.diskette.ALL;

ARCHITECTURE test OF test_diskette IS
    SIGNAL state : occupied := (OTHERS => (OTHERS => (OTHERS => '0')));
    SIGNAL ix : index := (OTHERS => 0);
    SIGNAL sector, track, sides : NATURAL;
BEGIN

    dut : ENTITY work.sector_tracker(behav)
        PORT MAP(state, ix);

    stimulus : PROCESS IS
    BEGIN
        state <= (OTHERS => (OTHERS => (OTHERS => '0')));
        WAIT FOR 1 ns;
        sector <= ix.sector;
        track <= ix.track;
        sides <= ix.sides;
        WAIT FOR 4 ns;

        state <= (
                 9 => (
                 40 => (
                 1 => '1',
                 OTHERS => '0'
                 ),
                 OTHERS => (OTHERS => '0')
                 ),
                 OTHERS => (OTHERS => (OTHERS => '0')));
        WAIT FOR 1 ns;
        sector <= ix.sector;
        track <= ix.track;
        sides <= ix.sides;
        WAIT FOR 4 ns;

        state <= (
                 1 TO 10 => (
                 3 TO 40 => (
                 1 => '1',
                 OTHERS => '0'),
                 OTHERS => (OTHERS => '0')
                 ),
                 OTHERS => (OTHERS => (OTHERS => '0')));
        WAIT FOR 1 ns;
        sector <= ix.sector;
        track <= ix.track;
        sides <= ix.sides;
        WAIT FOR 4 ns;

    END PROCESS stimulus;

END ARCHITECTURE;
