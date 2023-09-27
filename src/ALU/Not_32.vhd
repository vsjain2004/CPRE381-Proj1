library IEEE;
use IEEE.std_logic_1164.all;

entity Not_32 is
    port(input : in std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0));
end Not_32;

architecture dataflow of Not_32 is
begin
    Not32: for i in 0 to 31 generate
        output(i) <= not input(i);
    end generate Not32;
end dataflow;