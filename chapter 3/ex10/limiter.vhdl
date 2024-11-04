ENTITY limiter IS
    PORT (
        data_in, lower, upper : IN INTEGER;
        data_out : OUT INTEGER;
        out_of_bound : OUT BIT);
END ENTITY limiter;

ARCHITECTURE behav OF limiter IS
BEGIN

    limit : PROCESS (data_in, lower, upper) IS
    BEGIN
        IF data_in < lower THEN
            data_out <= lower;
            out_of_bound <= '1';
        ELSIF data_in > upper THEN
            data_out <= upper;
            out_of_bound <= '1';
        ELSE
            data_out <= data_in;
            out_of_bound <= '0';
        END IF;
    END PROCESS limit;

END ARCHITECTURE behav;