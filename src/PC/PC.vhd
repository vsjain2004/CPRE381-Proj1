library IEEE;
use IEEE.std_logic_1164.all;

entity PC is
    port(linkr : in std_logic_vector(31 downto 0);
        JAddr : in std_logic_vector(31 downto 0);
        BAddr : in std_logic_vector(31 downto 0);
        pc_sel_1 : in std_logic;
        pc_sel_0 : in std_logic;
        clk : in std_logic;
        reset : in std_logic;
        halt : in std_logic;
        o_PC : out std_logic_vector(31 downto 0);
        o_PC4 : out std_logic_vector(31 downto 0));
end PC;

architecture structural of PC is

    component RegNBit
        generic(N : integer := 32);
        port(clk : in std_logic;
            reset : in std_logic;
            we : in std_logic;
            data : in std_logic_vector(N-1 downto 0);
            o_data : out std_logic_vector(N-1 downto 0));
    end component;

    component CLA_32
        port(X : in std_logic_vector(31 downto 0);
            Y : in std_logic_vector(31 downto 0);
            AddSub : in std_logic;
            S : out std_logic_vector(31 downto 0);
            zero : out std_logic;
            negative : out std_logic;
            overflow : out std_logic;
            carry : out std_logic);
    end CLA_32;

    signal pc_o : std_logic_vector(31 downto 0);
    signal pc4_o : std_logic_vector(31 downto 0);
    signal jumpaddr : std_logic_vector(31 downto 0);
    signal braddr : std_logic_vector(31 downto 0);
    signal pc_in : std_logic_vector(31 downto 0) := x"00000000";
begin
    progc : RegNBit
        port MAP(clk => clk,
                reset => reset,
                we => (not halt),
                data => pc_in,
                o_data => pc_o);
    
    o_PC <= pc_o;

    Add1 : CLA_32
        port MAP(X => pc_o,
                Y => x"00000004",
                AddSub => '0',
                S => pc4_o,
                zero => open,
                negative => open,
                overflow => open,
                carry => open);
    
    o_PC4 <= pc4_o;
    jumpaddr <= pc4_o(31 downto 28) & JAddr & "00";

    Add2 : CLA_32
    port MAP(X => (BAddr(29 downto 0) & "00"),
            Y => pc4_o,
            AddSub => '0',
            S => braddr,
            zero => open,
            negative => open,
            overflow => open,
            carry => open);

    with {pc_sel_1 & pc_sel_0} select
        pc_in <= pc4_o when "00",
                 linkr when "01",
                 jumpaddr when "10",
                 braddr when "11";

end