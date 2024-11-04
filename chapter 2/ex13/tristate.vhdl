LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tristate_buffer IS
    PORT (
        en, din : IN STD_ULOGIC;
        dout : OUT STD_ULOGIC := 'X');
END ENTITY tristate_buffer;

ARCHITECTURE behav OF tristate_buffer IS

BEGIN

    fix : PROCESS IS
        VARIABLE state : STD_ULOGIC := 'X';
    BEGIN
        IF en ?= '0' THEN
            state := 'Z';
        ELSIF en ?= '1' THEN

            IF din ?= '0' THEN
                state := '0';
            ELSIF din ?= '1' THEN
                state := '1';
            ELSE
                state := 'X';
            END IF;

        ELSE
            state := 'X';
        END IF;
        dout <= state;
        WAIT FOR 1 ns;
    END PROCESS fix;

END ARCHITECTURE;