entity test_average16 is
end entity test_average16;

architecture test of test_average16 is
    signal clk : BIT := '0';
    signal datum, average : REAL := 0.0;
begin
    
    dut : entity work.average16(behav)
    port map (clk, datum, average);
    stimulus : process is
        variable datum_l : REAL;
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
        datum_l := datum + 1.0;
        datum <= datum_l;
        
    end process stimulus;
end architecture test;