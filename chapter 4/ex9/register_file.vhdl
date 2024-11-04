PACKAGE dtypes IS
    SUBTYPE word IS bit_vector(0 TO 31);
    CONSTANT default_word : word := (others => '0');
    SUBTYPE address IS INTEGER RANGE 0 TO 15;
    TYPE the_file IS ARRAY (address) OF word;
END PACKAGE dtypes;

USE work.dtypes.ALL;

ENTITY register_file IS
    PORT (
        din : IN word;
        w_adr : IN address;
        r_adr : IN address;
        w_en : IN BIT;
        dout : OUT word
    );
END ENTITY register_file;

ARCHITECTURE behav OF register_file IS
BEGIN

    read_write : PROCESS (ALL) IS
        VARIABLE state : the_file := (OTHERS => default_word);
    BEGIN

        IF w_en THEN
            state(w_adr) := din;
        END IF;

        dout <= state(r_adr);

    END PROCESS read_write;

END ARCHITECTURE;
