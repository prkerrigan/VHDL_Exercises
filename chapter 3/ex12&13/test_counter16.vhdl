entity test_counter16 is 
end entity test_counter16;

use work.int_types.all;

architecture test_count of test_counter16 is
    signal clk, load : bit := '0';
    signal counter, data : count16 := 15;
begin
    dut : entity work.count_down_16(behav)
    port map (clk, load, data, counter);
    stimulus : process is
    begin
        for n in count21 loop
            clk <= '0'; wait for 5 ns;
            clk <= '1'; wait for 5 ns;
            load <= '0' when n = 20;
        end loop;
        clk <= '0'; wait for 2 ns;
        load <= '1';
        data <= 6; wait for 3 ns;
        clk <= '1'; wait for 5 ns;
    end process stimulus;
end architecture test_count;