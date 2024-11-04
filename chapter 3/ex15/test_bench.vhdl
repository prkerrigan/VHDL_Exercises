entity test_bench is
end entity test_bench;

architecture test_clk of test_bench is
    signal clk : bit;
begin

    clock_gen : process is
    begin
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
    end process clock_gen;

end architecture;

architecture test_clk_errors of test_bench is
    signal clk : bit;
begin

    clock_gen : process is
    begin
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
        assert FALSE report "NOTE" severity NOTE;
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
        assert FALSE report "WARNING" severity WARNING;
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
        assert FALSE report "ERROR" severity ERROR;
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
        assert FALSE report "FAILURE" severity FAILURE;
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
    end process clock_gen;

end architecture;