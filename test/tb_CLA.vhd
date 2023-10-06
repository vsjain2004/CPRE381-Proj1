library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_CLA_32 is
	generic(gCLK_HPER   : time := 50 ns);
end tb_CLA_32;

architecture test of tb_CLA_32 is

component CLA_32 is
	port(X : in std_logic_vector(31 downto 0);
        Y : in std_logic_vector(31 downto 0);
        AddSub : in std_logic;
        S : out std_logic_vector(31 downto 0);
        zero : out std_logic;
        negative : out std_logic;
        overflow : out std_logic;
        carry : out std_logic);
end component;

signal i_X: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal i_Y : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal nAddSub : std_logic := '0';
signal o_S : std_logic_vector(31 downto 0);
signal o_C : std_logic;
signal o_Z : std_logic;
signal o_N : std_logic;
signal o_O : std_logic;

begin
			
	addsub1 : CLA_32
	port MAP(X => i_X,
            Y => i_Y,
            AddSub => nAddSub,
            S => o_S,
            zero => o_Z,
            negative => o_N,
            overflow => o_O,
            carry => o_C);

	Test_cases: process
	begin
		wait for gCLK_HPER/2;
		
		--Case 1: Add 34 and 66; expect 100 with no carry
		i_Y <= "00000000000000000000000000100010";
		i_X <= "00000000000000000000000001000010";
		nAddSub <= '0';
		wait for gCLK_HPER*2;
		
		--Case 2: Sub 34 from 66; expect 32 with carry
		nAddSub <= '1';
		wait for gCLK_HPER*2;
		
		--Case 3: Add -1 with -1; expect -2 with carry, negative
		i_Y <= "00000000000000000000000000000001";
		i_X <= "11111111111111111111111111111111";
		nAddSub <= '1';
		wait for gCLK_HPER*2;

        --Case 4: Add -1 with 0; expect 0 with carry, zero
        nAddSub <= '0';
		wait for gCLK_HPER*2;

		--Case 5: Add 1 with 2; expect 3 with no carry
		i_X <= "00000000000000000000000000000010";
		i_Y <= "11111111111111111111111111111111";
		nAddSub <= '1';
		wait for gCLK_HPER*2;

        --Case 6: Add 0x80000000 with itself; expect 0 with carry, overflow, zero
        i_X <= x"80000000";
        i_Y <= x"80000000";
        nAddSub <= '0';
        wait;
	end process;

end test;