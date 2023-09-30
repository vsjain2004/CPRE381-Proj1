library IEEE;
use IEEE.std_logic_1164.all;

entity CLA_32 is
    port(X : in std_logic_vector(31 downto 0);
        Y : in std_logic_vector(31 downto 0);
        AddSub : in std_logic;
        S : out std_logic_vector(31 downto 0);
        zero : out std_logic;
        negative : out std_logic;
        overflow : out std_logic;
        carry : out std_logic);
end CLA_32;

architecture structural of CLA_32 is

    component CLA_8_ext
        port(X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        Cin : in std_logic;
        S : out std_logic_vector(7 downto 0);
        P : out std_logic;
        G : out std_logic;
        C : out std_logic);
    end component;

    signal c8 : std_logic;
    signal g8 : std_logic;
    signal p8 : std_logic;
    signal c16 : std_logic;
    signal g16 : std_logic;
    signal p16 : std_logic;
    signal c24 : std_logic;
    signal g24 : std_logic;
    signal p24 : std_logic;
    signal c31 : std_logic;
    signal c32 : std_logic;
    signal g32 : std_logic;
    signal p32 : std_logic;
    signal Y_xor : std_logic_vector(31 downto 0);
begin
    Yxor : for i in 0 to 31 generate
        Y_xor(i) <= Y xor AddSub;
    end generate;

    CLA1 : CLA_8_ext
    port MAP(X => X(7 downto 0),
            Y => Y_xor(7 downto 0),
            Cin => AddSub,
            S => S(7 downto 0),
            P => p8,
            G => g8,
            C => open);
    
    c8 <= g8 or (p8 and AddSub);

    CLA2 : CLA_8_ext
    port MAP(X => X(15 downto 8),
            Y => Y_xor(15 downto 8),
            Cin => AddSub,
            S => S(15 downto 8),
            P => p16,
            G => g16,
            C => open);
    
    c16 <= g16 or (p16 and g8) or (p16 and p8 and AddSub);

    CLA3 : CLA_8_ext
    port MAP(X => X(23 downto 16),
            Y => Y_xor(23 downto 16),
            Cin => AddSub,
            S => S(23 downto 16),
            P => p24,
            G => g24,
            C => open);
    
    c24 <= g24 or (p24 and g16) or (p24 and p16 and g8) or (p24 and p16 and p8 and AddSub);

    CLA4 : CLA_8_ext
    port MAP(X => X(31 downto 24),
            Y => Y_xor(31 downto 24),
            Cin => AddSub,
            S => S(31 downto 24),
            P => p32,
            G => g32,
            C => c31);
    
    c32 <= g32 or (p32 and g24) or (p32 and p24 and g16) or (p32 and p24 and p16 and g8) or (p32 and p24 and p16 and p8 and AddSub);

    zero = not(S(31) or S(30) or S(29) or S(28) or S(27) or S(26) or S(25) or S(24) or S(23) or S(22) or S(21) or S(20) or S(19) or S(18) or S(17) or S(16) or S(15) or S(14) or S(13) or S(12) or S(11) or S(10) or S(9) or S(8) or S(7) or S(6) or S(5) or S(4) or S(3) or S(2) or S(1) or S(0));
    negative = S(31);
    overflow = c31 xor c32;
    carry <= c32;

end