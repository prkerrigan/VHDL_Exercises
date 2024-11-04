entity test_average_30 is
end entity test_average_30;

architecture test of test_average_30 is
    signal samples : INTEGER_VECTOR(1 to 30) := (others => 0);
    signal average : REAL := 0.0;
begin

    dut : entity work.average_30(behavioral)
    port map (samples, average);
    
    stimulus : process is
    begin
        samples <= (1, others => 0); wait for 10 ns;
        samples <= (1, 1, 1, others => 0); wait for 10 ns;
        samples <= (others => 1); wait for 10 ns;
        samples <= (15 to 29 => 2, others => (-1)); wait for 10 ns;
    end process stimulus;

end architecture;
