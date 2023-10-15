library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_Control is
	generic(gCLK_HPER   : time := 50 ns);
end tb_Control;

architecture test of tb_Control is

component Control is
	port(opcode : in std_logic_vector(5 downto 0);
        funct : in std_logic_vector(5 downto 0);
        i_rd : in std_logic_vector(4 downto 0);
        o_rd : out std_logic_vector(4 downto 0);
        movz : out std_logic;
        movn : out std_logic;
        beq : out std_logic;
        bne : out std_logic;
        blez : out std_logic;
        bgtz : out std_logic;
        imm_ext : out std_logic;
        sel_y : out std_logic;
        rs_sel : out std_logic;
        ivu_sel : out std_logic;
        astype : out std_logic;
        shdir : out std_logic;
        alu_sel_2 : out std_logic;
        alu_sel_1 : out std_logic;
        alu_sel_0 : out std_logic;
        dmem_we : out std_logic;
        reg_we : out std_logic;
        reg_sel_1 : out std_logic;
        reg_sel_0 : out std_logic;
        rd_sel : out std_logic;
        pc_sel_1 : out std_logic;
        pc_sel_0 : out std_logic;
        det_o : out std_logic;
        halt : out std_logic);
end component;

signal opcode : std_logic_vector(5 downto 0) := "000000";
signal funct : std_logic_vector(5 downto 0) := "000000";
signal i_rd : std_logic_vector(4 downto 0) := "00000";
signal o_rd : std_logic_vector(4 downto 0);
signal movz : std_logic;
signal movn : std_logic;
signal beq : std_logic;
signal bne : std_logic;
signal blez : std_logic;
signal bgtz : std_logic;
signal imm_ext : std_logic;
signal sel_y : std_logic;
signal rs_sel : std_logic;
signal ivu_sel : std_logic;
signal astype : std_logic;
signal shdir : std_logic;
signal alu_sel_2 : std_logic;
signal alu_sel_1 : std_logic;
signal alu_sel_0 : std_logic;
signal dmem_we : std_logic;
signal reg_we : std_logic;
signal reg_sel_1 : std_logic;
signal reg_sel_0 : std_logic;
signal rd_sel : std_logic;
signal pc_sel_1 : std_logic;
signal pc_sel_0 : std_logic;
signal det_o : std_logic;
signal halt : std_logic;

begin
			
	control1 : Control
	port MAP(opcode => opcode,
            funct => funct,
            i_rd => i_rd,
            o_rd => o_rd,
            movz => movz,
            movn => movn,
            beq => beq,
            bne => bne,
            blez => blez,
            bgtz => bgtz,
            imm_ext => imm_ext,
            sel_y => sel_y,
            rs_sel => rs_sel,
            ivu_sel => ivu_sel,
            astype => astype,
            shdir => shdir,
            alu_sel_2 => alu_sel_2,
            alu_sel_1 => alu_sel_1,
            alu_sel_0 => alu_sel_0,
            dmem_we => dmem_we,
            reg_we => reg_we,
            reg_sel_1 => reg_sel_1,
            reg_sel_0 => reg_sel_0,
            rd_sel => rd_sel,
            pc_sel_1 => pc_sel_1,
            pc_sel_0 => pc_sel_0,
            det_o => det_o,
            halt => halt);

	Test_cases: process
	begin
		wait for gCLK_HPER/2;
		
		--Case 1: sll
		wait for gCLK_HPER*2;
		
		--Case 2: srl
		funct <= "000010";
		wait for gCLK_HPER*2;
		
		--Case 3: sra
		funct <= "000011";
		wait for gCLK_HPER*2;

        --Case 4: sllv
        funct <= "000100";
		wait for gCLK_HPER*2;

		--Case 5: srlv
		funct <= "000110";
		wait for gCLK_HPER*2;

        --Case 6: srav
        funct <= "000111";
        wait for gCLK_HPER*2;

        --Case 7: jr
        funct <= "001000";
        wait for gCLK_HPER*2;

        --Case 8: jalr
        funct <= "001001";
        wait for gCLK_HPER*2;

        --Case 9: movz
        funct <= "001010";
        wait for gCLK_HPER*2;

        --Case 10: movn
        funct <= "001011";
        wait for gCLK_HPER*2;

        --Case 11: break
        funct <= "001101";
        wait for gCLK_HPER*2;

        --Case 12: add
        funct <= "100000";
        wait for gCLK_HPER*2;

        --Case 13: addu
        funct <= "100001";
        wait for gCLK_HPER*2;

        --Case 14: sub
        funct <= "100010";
        wait for gCLK_HPER*2;

        --Case 15: subu
        funct <= "100011";
        wait for gCLK_HPER*2;

        --Case 16: and
        funct <= "100100";
        wait for gCLK_HPER*2;

        --Case 17: or
        funct <= "100101";
        wait for gCLK_HPER*2;

        --Case 18: xor
        funct <= "100110";
        wait for gCLK_HPER*2;

        --Case 19: nor
        funct <= "100111";
        wait for gCLK_HPER*2;

        --Case 20: slt
        funct <= "101010";
        wait for gCLK_HPER*2;

        --Case 21: sltu
        funct <= "101011";
        wait for gCLK_HPER*2;

        --Case 22: j
        opcode <= "000010";
        wait for gCLK_HPER*2;

        --Case 23: jal
        opcode <= "000011";
        wait for gCLK_HPER*2;

        --Case 24: beq
        opcode <= "000100";
        wait for gCLK_HPER*2;

        --Case 25: bne
        opcode <= "000101";
        wait for gCLK_HPER*2;

        --Case 26: blez
        opcode <= "000110";
        wait for gCLK_HPER*2;

        --Case 27: bgtz
        opcode <= "000111";
        wait for gCLK_HPER*2;

        --Case 28: addi
        opcode <= "001000";
        wait for gCLK_HPER*2;

        --Case 29: addiu
        opcode <= "001001";
        wait for gCLK_HPER*2;

        --Case 30: slti
        opcode <= "001010";
        wait for gCLK_HPER*2;

        --Case 31 sltiu
        opcode <= "001011";
        wait for gCLK_HPER*2;

        --Case 32: andi
        opcode <= "001100";
        wait for gCLK_HPER*2;

        --Case 33: ori
        opcode <= "001101";
        wait for gCLK_HPER*2;

        --Case 34: xori
        opcode <= "001110";
        wait for gCLK_HPER*2;

        --Case 35: lui
        opcode <= "001111";
        wait for gCLK_HPER*2;

        --Case 36: halt
        opcode <= "010100";
        wait for gCLK_HPER*2;

        --Case 37: lw
        opcode <= "100011";
        wait for gCLK_HPER*2;

        --Case 38: sw
        opcode <= "101011";
        wait;
	end process;

end test;