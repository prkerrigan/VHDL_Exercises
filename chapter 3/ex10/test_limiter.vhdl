entity test_limiter is
end entity test_limiter;

architecture test of test_limiter is
    signal data_in, lower, upper, data_out : integer := 0;
    signal out_of_limit : bit := '0';
begin
    dut : entity work.limiter(behav)
    port map (data_in, lower, upper, data_out, out_of_limit);
    stimulus : process is
    begin
        data_in <= 0; lower <= (-10); upper <= 10; wait for 10 ns;
        data_in <= (-9); wait for 10 ns;
        data_in <= (-10); wait for 10 ns;
        data_in <= (-11); wait for 10 ns;
        data_in <= integer'low; wait for 10 ns;
        data_in <= 9; wait for 10 ns;
        data_in <= 10; wait for 10 ns;
        data_in <= 11; wait for 10 ns;
        data_in <= integer'high; wait for 10 ns;
        wait;
    end process stimulus;
end architecture test;