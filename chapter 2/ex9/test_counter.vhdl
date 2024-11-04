entity test_counter is
end entity test_counter;

architecture test of test_counter is
    signal clk : BIT := '0';
    signal count : INTEGER;
begin
    
    dut : entity work.counter(behav)
    port map(clk, count);
    
    stimulus : process is
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process stimulus;
    
end architecture;