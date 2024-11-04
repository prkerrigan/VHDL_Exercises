entity test_exp is
end entity test_exp;
architecture test of test_exp is
    signal x, s_result, b_result : REAL := 0.0;
begin
    dut_series : entity work.exp(series)
    port map (x, s_result);
    dut_bounded : entity work.exp(bounded)
    port map (x, b_result);
    
    stimulus : process is
    begin
        x <= 1.0; wait for 5 ns;
        x <= 2.0; wait for 5 ns;
        x <= 0.0; wait for 5 ns;
        x <= (-1.0); wait for 5 ns;
        x <= (-3.0); wait for 5 ns;
        x <= 10.0; wait for 5 ns;
    end process stimulus;
end architecture test;