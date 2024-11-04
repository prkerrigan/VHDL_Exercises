ENTITY test_register IS
END ENTITY test_register;

USE work.dtypes.ALL;

ARCHITECTURE test OF test_register IS
    SIGNAL din, dout : word;
    SIGNAL w_adr, r_adr : address;
    SIGNAL w_en : BIT;
BEGIN

    dut : ENTITY work.register_file(behav)
        PORT MAP(din, w_adr, r_adr, w_en, dout);

    stimulus : PROCESS IS
    BEGIN

        din <= ('1', '1', others => '0');
        w_adr <= 6;
        r_adr <= 1;
        w_en <= '1';
        WAIT FOR 5 ns;

        din <= ('0', '1', '1', others => '0');
        w_adr <= 1;
        r_adr <= 6;
        WAIT FOR 5 ns;

        din <= (others => '1');
        w_en <= '0';
        r_adr <= 1;
        WAIT FOR 5 ns;

        w_adr <= 15;
        r_adr <= 15;
        WAIT FOR 5 ns;
        
        w_en <= '1';
        wait for 5 ns;
        
        r_adr <= 2;
        wait for 5 ns;

    END PROCESS stimulus;

END ARCHITECTURE;
