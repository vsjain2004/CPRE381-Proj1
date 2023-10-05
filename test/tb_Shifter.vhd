library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_Shifter is
	generic(gCLK_HPER   : time := 50 ns);
end tb_Shifter;

architecture test of tb_Shifter is

component Shifter
	port(data : in std_logic_vector(31 downto 0);
        shamt : in std_logic_vector(4 downto 0);
        shdir : in std_logic;
        shtype : in std_logic;
        output : out std_logic_vector(31 downto 0));
end component;

signal data : std_logic_vector(31 downto 0) := x"00000000";
signal shamt : std_logic_vector(4 downto 0) := "00000";
signal shdir : std_logic := '0';
signal shtype : std_logic := '0';
signal output : std_logic_vector(31 downto 0);

begin

	test_Shifter: Shifter
	port MAP(data => data,
            shamt => shamt,
            shdir => shdir,
            shtype => shtype,
            output => output);

	Test_cases: process
	begin
		wait for gCLK_HPER/2;

		--Case 1: sll 0x00000020 by 4
        data <= x"00000020";
        shamt <= "00100";
		wait for gCLK_HPER*2;
		
		--Case 2: srl 0x00000020 by 5
        shamt <= "00101";
        shdir <= '1';
        wait for gCLK_HPER*2;
		
		--Case 3: sra 0x00000020 by 5
		shtype <= '1';
		wait for gCLK_HPER*2;

        --Case 4: sra 0x80000000 by 5
        data <= x"80000000";
        wait for gCLK_HPER*2;

        wait;

	end process;

end test;