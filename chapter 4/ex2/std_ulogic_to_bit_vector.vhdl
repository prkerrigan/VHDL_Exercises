library ieee;
use ieee.std_logic_1164.all;

entity vector_std_ulogic_to_bit is
    port (
        v1 : in std_ulogic_vector;
        v2 : out bit_vector
    );
end entity vector_std_ulogic_to_bit;

architecture behav of vector_std_ulogic_to_bit is
    type std_ulogic_to_bit_type is array (std_ulogic) of bit;
begin
    
    mapping : process (v1) is
        constant std_ulogic_to_bit : std_ulogic_to_bit_type := (
            '1' | 'H' => '1',
            others => '0'
        );
        variable v : bit_vector(v1'range);
    begin
        for i in v1'range loop
            v(i) := std_ulogic_to_bit(v1(i));
        end loop;
        v2 <= v;
    end process mapping;
end architecture behav;
