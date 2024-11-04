LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE tests IS

    TYPE three_to_eight IS RECORD
        sample_input : STD_LOGIC_VECTOR(2 DOWNTO 0);
        delay : TIME;
        expected_output : STD_LOGIC_VECTOR(7 DOWNTO 0);
    END RECORD three_to_eight;

    TYPE sample IS ARRAY (NATURAL RANGE <>) OF three_to_eight;

    CONSTANT expected : sample := (
        (sample_input => B"000", delay => 5 ns, expected_output => B"0000_0001"),
        (sample_input => B"001", delay => 5 ns, expected_output => B"0000_0010"),
        (sample_input => B"010", delay => 5 ns, expected_output => B"0000_0100"),
        (sample_input => B"011", delay => 5 ns, expected_output => B"0000_1000"),
        (sample_input => B"100", delay => 5 ns, expected_output => B"0001_0000"),
        (sample_input => B"101", delay => 5 ns, expected_output => B"0010_0000"),
        (sample_input => B"110", delay => 5 ns, expected_output => B"0100_0000"),
        (sample_input => B"111", delay => 5 ns, expected_output => B"1000_0000")
    );

END PACKAGE tests;

ENTITY test_decode3to8 IS
END ENTITY;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.tests.ALL;

ARCHITECTURE test OF test_decode3to8 IS
    SIGNAL code : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL selection : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    dut : ENTITY work.decoder(behav)
        PORT MAP(code, selection);

    stimulus : PROCESS IS
    BEGIN

        FOR i IN expected'RANGE LOOP
            code <= expected(i).sample_input;
            WAIT FOR expected(i).delay;
            ASSERT selection = expected(i).expected_output REPORT "UNEXPECTED OUTPUT" SEVERITY FAILURE;
        END LOOP;

    END PROCESS stimulus;

END ARCHITECTURE;
