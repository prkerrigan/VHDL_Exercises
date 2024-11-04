LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decoder IS
    PORT (
        code : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        selection : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behav OF decoder IS
BEGIN

    decode : PROCESS (code) IS
        VARIABLE index : INTEGER RANGE 7 DOWNTO 0;
    BEGIN

        selection <= (OTHERS => '0');

        index := to_integer(unsigned(code));

        selection(index) <= '1';

    END PROCESS decode;

END ARCHITECTURE;
