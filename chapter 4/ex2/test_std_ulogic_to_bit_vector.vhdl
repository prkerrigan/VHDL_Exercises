ENTITY test_std_ulogic_to_bit_vector IS
END ENTITY test_std_ulogic_to_bit_vector;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ARCHITECTURE test OF test_std_ulogic_to_bit_vector IS
    SIGNAL v1 : STD_ULOGIC_VECTOR(0 TO 15) := (OTHERS => '-');
    SIGNAL v2 : bit_vector(0 TO 15) := (OTHERS => '0');
BEGIN

    dut : ENTITY work.vector_std_ulogic_to_bit(behav)
    PORT MAP(v1, v2);

    stimulus : PROCESS IS
    BEGIN
        v1 <= ('U', '0', '1', 'L', 'H', 'X', 'W', 'Z', OTHERS => '-');
        WAIT FOR 10 ns;
        v1 <= (OTHERS => 'X');
        WAIT FOR 10 ns;
        v1 <= (OTHERS => 'H');
        WAIT FOR 10 ns;
        v1 <= (OTHERS => '1');
        WAIT FOR 10 ns;
        v1 <= (OTHERS => '0');
        WAIT FOR 10 ns;
    END PROCESS stimulus;

END ARCHITECTURE;
