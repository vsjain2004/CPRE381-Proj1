library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_PC is
	generic(gCLK_HPER   : time := 50 ns);
end tb_PC;

architecture test of tb_PC is

component PC
	port(linkr : in std_logic_vector(31 downto 0);
        JAddr : in std_logic_vector(25 downto 0);
        BAddr : in std_logic_vector(31 downto 0);
        pc_sel_1 : in std_logic;
        pc_sel_0 : in std_logic;
        clk : in std_logic;
        reset : in std_logic;
        halt : in std_logic;
        o_PC : out std_logic_vector(31 downto 0);
        o_PC4 : out std_logic_vector(31 downto 0));
end component;

signal linkr : std_logic_vector(31 downto 0) := x"00000000";
signal JAddr : std_logic_vector(25 downto 0) := x"000000" & "00";
signal BAddr : std_logic_vector(31 downto 0) := x"00000000";
signal pc_sel_1 : std_logic := '0';
signal pc_sel_0 : std_logic := '0';
signal halt : std_logic := '0';
signal o_PC : std_logic_vector(31 downto 0);
signal o_PC4 : std_logic_vector(31 downto 0);
signal reset : std_logic := '0';
signal s_clk : std_logic := '0';

begin

	test_pc: PC
	port MAP(linkr => linkr,
            JAddr => JAddr,
            BAddr => BAddr,
            pc_sel_1 => pc_sel_1,
            pc_sel_0 => pc_sel_0,
            halt => halt,
            reset => reset,
            clk => s_clk,
            o_PC => o_PC,
            o_PC4 => o_PC4);

    P_CLK: process
    begin
        s_clk <= '0';
        wait for gCLK_HPER;
        s_clk <= '1';
        wait for gCLK_HPER;
    end process;

	Test_cases: process
	begin
		wait for gCLK_HPER/2;
        --clear PC
		reset <= '1';
        wait for gCLK_HPER/2;
        reset <= '0';

		--Case 1: PC+4
        wait for gCLK_HPER/2;
		wait for gCLK_HPER*2;
		
		--Case 2: linkr
        linkr <= x"40320100";
        pc_sel_0 <= '1';
        wait for gCLK_HPER*2;
		
		--Case 3: JAddr
		JAddr <= x"000000" & "01";
        pc_sel_1 <= '1';
        pc_sel_0 <= '0';
		wait for gCLK_HPER*2;

        --Case 4: BAddr
        BAddr <= x"00000001";
        pc_sel_0 <= '1';
        wait for gCLK_HPER*2;

        --Case 5: halt
        halt <= '1';
        wait for gCLK_HPER*2;
        wait for gCLK_HPER*2;
        wait for gCLK_HPER*2;

        wait;

	end process;

end test;