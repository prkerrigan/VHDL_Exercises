LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU IS
    PORT (
        a, b : IN SIGNED(7 DOWNTO 0);
        op : IN BIT;
        z : OUT SIGNED(8 DOWNTO 0)
    );
END ENTITY ALU;

ARCHITECTURE behav OF ALU IS
BEGIN
    operate : PROCESS IS
        VARIABLE result : SIGNED(8 DOWNTO 0);
        VARIABLE rs_a, rs_b : SIGNED(8 DOWNTO 0);
    BEGIN
        rs_a := RESIZE(a, 9);
        rs_b := RESIZE(b, 9);
        IF op THEN
            result := rs_a - rs_b;
        ELSE
            result := rs_a + rs_b;
        END IF;
        z <= result;
        WAIT FOR 1 ns;
    END PROCESS operate;
END ARCHITECTURE;
