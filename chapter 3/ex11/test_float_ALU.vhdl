entity test_float_ALU is
end entity test_float_ALU;

architecture test of test_float_ALU is
    signal x, y, z : real := 0.0;
    signal f0, f1 : bit := '0';
begin
    dut : entity work.floating_ALU(behav)
    port map (x, y, f0, f1, z);
    stimulus : process is
    begin
        x <= 2.0; y <= 3.0; wait for 10 ns;
        f0 <= '1'; wait for 10 ns;
        f1 <= '1'; wait for 10 ns;
        f0 <= '0'; wait for 10 ns;
        x <= 1.0; y <= 0.0;
        f1 <= '0'; wait for 10 ns;
        f0 <= '1'; wait for 10 ns;
        f1 <= '1'; wait for 10 ns;
        f0 <= '0'; wait for 10 ns;
        x <= 0.0; y <= 1.0;
        f1 <= '0'; wait for 10 ns;
        f0 <= '1'; wait for 10 ns;
        f1 <= '1'; wait for 10 ns;
        f0 <= '0'; wait for 10 ns;
        wait;
    end process stimulus;
end architecture test;
