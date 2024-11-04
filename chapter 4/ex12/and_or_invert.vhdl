LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY and_or_invert IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR;
        y : OUT STD_LOGIC
    );
END ENTITY and_or_invert;

ARCHITECTURE behav OF and_or_invert IS

BEGIN

    aoi : PROCESS (a, b) IS
    BEGIN

        y <= NOT ( OR (a AND b));

    END PROCESS aoi;

END ARCHITECTURE;
