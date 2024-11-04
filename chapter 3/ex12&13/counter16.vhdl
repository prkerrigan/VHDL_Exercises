PACKAGE int_types IS
    TYPE count16 IS RANGE 15 DOWNTO 0;
    TYPE count21 IS RANGE 20 DOWNTO 0;
END PACKAGE int_types;

USE work.int_types.count16;

ENTITY count_down_16 IS
    PORT (
        clk, load : IN BIT;
        data : IN count16;
        counter : OUT count16
    );
END ENTITY count_down_16;

ARCHITECTURE behav OF count_down_16 IS
BEGIN

    procceed : PROCESS (clk) IS
        VARIABLE count : count16 := 15;
    BEGIN

        IF load THEN
            count := data;
        ELSE
            count := count16'rightof(count) WHEN RISING_EDGE(clk) AND count /= 0
        ELSE 15 WHEN RISING_EDGE(clk);
        END IF;
        counter <= count;

    END PROCESS procceed;
END ARCHITECTURE behav;