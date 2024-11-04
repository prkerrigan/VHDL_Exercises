entity test_mux2x4 is
end entity test_mux2x4;

architecture test of test_mux2x4 is
    signal a0, a1, a2, a3, b0, b1, b2, b3, sel, z0, z1, z2, z3 : bit;
begin
    dut : entity work.mux2x4(struct)
    port map (a0, a1, a2, a3, b0, b1, b2, b3, sel, z0, z1, z2, z3);
    stimulus : process is
    begin
        a0 <= '1'; a1 <= '0'; a2 <= '1'; a3 <= '1';
        b0 <= '0'; b1 <= '1'; b2 <= '1'; b3 <= '0';
        sel <= '0'; wait for 20 ns;
        sel <= '1'; wait for 20 ns;
        a0 <= '0'; a1 <= '0'; a2 <= '0'; a3 <= '0';
        b0 <= '1'; b1 <= '1'; b2 <= '1'; b3 <= '1';
        sel <= '0'; wait for 20 ns;
        sel <= '1'; wait for 20 ns;
        wait;
    end process stimulus;
end architecture test;