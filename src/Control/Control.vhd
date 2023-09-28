library IEEE;
use IEEE.std_logic_1164.all;

entity Control is
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
        astype : out std_logic;
        shdir : out std_logic;
        alu_sel_2 : out std_logic;
        alu_sel_1 : out std_logic;
        alu_sel_0 : out std_logic;
        dmem_we : out std_logic;
        reg_we : out std_logic;
        ra_we : out std_logic;
        reg_sel : out std_logic;
        rd_sel : out std_logic;
        pc_sel_1 : out std_logic;
        pc_sel_0 : out std_logic;
        det_o : out std_logic;
        halt : out std_logic);
end Control;

architecture structural of Control is
    component Decoder6t64
        port(input : in std_logic_vector(5 downto 0);
            output : out std_logic_vector(63 downto 0));
    end component;

    signal op_dec : std_logic_vector(63 downto 0);
    signal func_dec : std_logic_vector(63 downto 0);
begin
    o_rd <= "11111" when ()
    movz <= op_dec(0) and func_dec(10);
    movn <= op_dec(0) and func_dec(11);
    beq <= op_dec(4);
    bne <= op_dec(5);
    blez <= op_dec(6);
    bgtz <= op_dec(7);
    imm_ext <= op_dec(4) or op_dec(5) or op_dec(6) or op_dec(7) or op_dec(8) or op_dec(9) or op_dec(10);
    sel_y <= op_dec(8) or op_dec(9) or op_dec(10) or op_dec(12) or op_dec(13) or op_dec(14) or op_dec(15) or op_dec(35) or op_dec(43);
    astype <= (op_dec(0) and (func_dec(3) or func_dec(34) or func_dec(35) or func_dec(42))) or op_dec(4) or op_dec(5) or op_dec(6) or op_dec(7) or op_dec(10);
    shdir <= op_dec(0) and func_dec(2);
    alu_sel_2 <= (op_dec(0) and (func_dec(36) or func_dec(37) or func_dec(38) or func_dec(42))) or op_dec(10) or op_dec(12) or op_dec(13) or op_dec(14);
    alu_sel_1 <= (op_dec(0) and (func_dec(36) or func_dec(39) or func_dec(42))) or op_dec(10) or op_dec(12) or op_dec(15);
    alu_sel_0 <= (op_dec(0) and (func_dec(2) or func_dec(3) or func_dec(38) or func_dec(39) or func_dec(42))) or op_dec(10) or op_dec(14);
    dmem_we <= op_dec(43);
end structural;