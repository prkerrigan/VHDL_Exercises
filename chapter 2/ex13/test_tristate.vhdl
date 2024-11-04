entity test_tristate is
end entity test_tristate;

library ieee;
use ieee.std_logic_1164.all;

architecture test of test_tristate is
    signal en, din, dout : STD_ULOGIC;
begin
    
    dut : entity work.tristate_buffer(behav)
    port map (en, din, dout);
    
    stimulus : process is
    begin
        wait for 5 ns;
        en <= '0'; wait for 5 ns;
        en <= 'L'; wait for 5 ns;
        en <= '1'; din <= '0'; wait for 5 ns;
        din <= 'L'; wait for 5 ns;
        din <= '1'; wait for 5 ns;
        din <= 'H'; wait for 5 ns;
        din <= 'W'; wait for 5 ns;
        din <= 'X'; wait for 5 ns;
        en <= 'X';
        wait;
    end process stimulus;
    
end architecture test;