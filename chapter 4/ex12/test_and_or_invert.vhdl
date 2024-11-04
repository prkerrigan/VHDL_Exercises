ENTITY test_and_or_invert IS
END ENTITY;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ARCHITECTURE test OF test_and_or_invert IS
    SIGNAL a, b : STD_LOGIC_VECTOR(0 TO 3);
    SIGNAL y : STD_LOGIC;
BEGIN

    dut : ENTITY work.and_or_invert(behav)
        PORT MAP(a, b, y);

    stimulus : PROCESS IS
    BEGIN

        a <= ('1', '1', '0', '0');
        b <= ('0', '0', '1', '1');
        WAIT FOR 5 ns;

        b <= ('1', OTHERS => '0');
        WAIT FOR 5 ns;

        a <= (OTHERS => '1');
        WAIT FOR 5 ns;

        b <= (OTHERS => '1');
        WAIT FOR 5 ns;

        a <= (OTHERS => '0');
        WAIT FOR 5 ns;

    END PROCESS stimulus;

END ARCHITECTURE;
