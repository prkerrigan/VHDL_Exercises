entity test_repack is
end entity test_repack;

architecture test of test_repack is
    signal v1 : BIT_VECTOR(0 to 7);
    signal v2 : BIT_VECTOR(0 to 31);
begin

    dut : entity work.repack8to32a(cycle)
    port map (v1, v2);
    
    stimulus : process is
    begin
        v1 <= (others => '1'); wait for 5 ns;
        v1 <= ('0', others => '1'); wait for 5 ns;
        v1 <= (others => '0'); wait for 5 ns;
        v1 <= ('1', '1', '1', others => '0'); wait for 5 ns;
    end process stimulus;

end architecture;