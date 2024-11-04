ENTITY test_integrator IS
END ENTITY test_integrator;

architecture test of test_integrator is
    signal data, integral : real := 0.0;
    signal clk : bit;
begin

    dut : entity work.integrator(behav)
    port map (data, clk, integral);
    
    clock : process is
    begin
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
    end process clock;
    
    stimulus : process is
    begin
        data <= 0.01; wait for 20 ns;
        data <= 0.1; wait for 20 ns;
        data <= (-0.09); wait for 20 ns;
    end process stimulus;

end architecture;