entity test_mux2 is
end entity test_mux2;

architecture test of test_mux2 is
signal a, b, sel, z : bit;
begin
    
    dut : entity work.mux2(behav)
    port map (a, b, sel, z);
    
    stimulus : process is
    begin
        a <= '1'; b <= '0';
        sel <= '0'; wait for 20 ns;
        sel <= '1'; wait for 20 ns;
        a <= '0'; b <= '1';
        sel <= '0'; wait for 20 ns;
        sel <= '1'; wait for 20 ns;
        wait;
    end process stimulus;
    
end architecture test;