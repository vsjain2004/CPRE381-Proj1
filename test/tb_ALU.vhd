library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_ALU is
	generic(gCLK_HPER   : time := 50 ns);
end tb_ALU;

architecture test of tb_ALU is

component ALU is
	port(X : in std_logic_vector(31 downto 0);
        Y : in std_logic_vector(31 downto 0);
        astype : in std_logic;
        shamt : in std_logic_vector(4 downto 0);
        shdir : in std_logic;
        ivu_sel : in std_logic;
        alu_sel_0 : in std_logic;
        alu_sel_1 : in std_logic;
        alu_sel_2 : in std_logic;
        result : out std_logic_vector(31 downto 0);
        zero : out std_logic;
        negative : out std_logic;
        overflow : out std_logic);
end component;

signal i_X: std_logic_vector(31 downto 0) := x"0000000F";
signal i_Y : std_logic_vector(31 downto 0) := x"F0FFFFFF";
signal nAddSub : std_logic := '0';
signal shamt : std_logic_vector(4 downto 0) := "00100";
signal shdir : std_logic := '0';
signal ivu_sel : std_logic := '0';
signal alu_sel_0 : std_logic := '0';
signal alu_sel_1 : std_logic := '0';
signal alu_sel_2 : std_logic := '0';
signal o_S : std_logic_vector(31 downto 0);
signal o_Z : std_logic;
signal o_N : std_logic;
signal o_O : std_logic;

begin
			
	alu1 : ALU
	port MAP(X => i_X,
            Y => i_Y,
            astype => nAddSub,
            shamt => shamt,
            shdir => shdir,
            ivu_sel => ivu_sel,
            alu_sel_0 => alu_sel_0,
            alu_sel_1 => alu_sel_1,
            alu_sel_2 => alu_sel_2,
            result => o_S,
            zero => o_Z,
            negative => o_N,
            overflow => o_O);

	Test_cases: process
	begin
		wait for gCLK_HPER/2;
		
		--Case 1: Add. Expect 0xF100000E
		wait for gCLK_HPER*2;

        --Case 2: Sub. Expect 0x0F000010
        nAddSub <= '1';
        wait for gCLK_HPER * 2;
		
		--Case 3: sll. Expect 0x0FFFFFF0
        nAddSub <= '0';
		alu_sel_0 <= '1';
		wait for gCLK_HPER*2;

        --Case 4: srl. Expect 0x0F0FFFFF
        shdir <= '1';
        wait for gCLK_HPER*2;

        --Case 5: sra. Expect 0xFF0FFFFF
        nAddSub <= '1';
        wait for gCLK_HPER*2;
		
		--Case 6: lui. Expect 0xFFFF0000
		alu_sel_0 <= '0';
        alu_sel_1 <= '1';
		wait for gCLK_HPER*2;

        --Case 7: nor. Expect 0x0F000000
        alu_sel_0 <= '1';
		wait for gCLK_HPER*2;

		--Case 8: or. Expect 0xF0FFFFFF
		alu_sel_0 <= '0';
        alu_sel_1 <= '0';
        alu_sel_2 <= '1';
		wait for gCLK_HPER*2;

        --Case 9: xor. expect 0xF0FFFFF0
        alu_sel_0 <= '1';
        wait for gCLK_HPER*2;

        --Case 10: and. Expect 0x0000000F
        alu_sel_0 <= '0';
        alu_sel_1 <= '1';
        wait for gCLK_HPER*2;

        --Case 11: slt. Expect 0x00000000
        alu_sel_0 <= '1';
        wait;
	end process;

end test;