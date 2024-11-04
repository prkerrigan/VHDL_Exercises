LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY test_ALU IS
END ENTITY test_ALU;

ARCHITECTURE test OF test_ALU IS
    SIGNAL a, b : SIGNED(7 DOWNTO 0);
    SIGNAL op : BIT;
    SIGNAL z : SIGNED(8 DOWNTO 0);
BEGIN

    dut : ENTITY work.ALU(behav)
        PORT MAP(a, b, op, z);

    stimulus : PROCESS IS
    BEGIN
        a <= X"FF";
        b <= X"01";
        op <= '0';
        WAIT FOR 5 ns;
        op <= '1';
        WAIT FOR 5 ns;
        a <= X"7F";
        b <= X"90";
        WAIT FOR 5 ns;
        op <= '0';
        WAIT FOR 5 ns;
        a <= X"80";
        b <= X"80";
        WAIT FOR 5 ns;
        op <= '1';
        WAIT FOR 5 ns;
    END PROCESS stimulus;

END ARCHITECTURE test;
