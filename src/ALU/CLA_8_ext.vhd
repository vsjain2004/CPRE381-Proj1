library IEEE;
use IEEE.std_logic_1164.all;

entity CLA_8_ext is
    port(X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        Cin : in std_logic;
        S : out std_logic_vector(7 downto 0);
        P : out std_logic;
        G : out std_logic;
        C : out std_logic);
end CLA_8_ext;

architecture dataflow of CLA_8_ext is
    signal g0 : std_logic;
    signal p0 : std_logic;
    signal g1 : std_logic;
    signal p1 : std_logic;
    signal g2 : std_logic;
    signal p2 : std_logic;
    signal g3 : std_logic;
    signal p3 : std_logic;
    signal g4 : std_logic;
    signal p4 : std_logic;
    signal g5 : std_logic;
    signal p5 : std_logic;
    signal g6 : std_logic;
    signal p6 : std_logic;
    signal g7 : std_logic;
    signal p7 : std_logic;
    signal Carry : std_logic_vector(7 downto 0);
begin
    Carry(0) <= Cin;

    g0 <= X(0) & Y(0);
    p0 <= X(0) | Y(0);
    S(0) <= X(0) ^ Y(0) ^ Carry(0);
    Carry(1) <= g0 | (p0 & Cin);

    g1 <= X(1) & Y(1);
    p1 <= X(1) | Y(1);
    S(1) <= X(1) ^ Y(1) ^ Carry(1);
    Carry(2) <= g1 | (p1 & g0) | (p1 & p0 & Cin);
    
    g2 <= X(2) & Y(2);
    p2 <= X(2) | Y(2);
    S(2) <= X(2) ^ Y(2) ^ Carry(2);
    Carry(3) <= g2 | (p2 & g1) | (p2 & p1 & g0) | (p2 & p1 & p0 & Cin);
    
    g3 <= X(3) & Y(3);
    p3 <= X(3) | Y(3);
    S(3) <= X(3) ^ Y(3) ^ Carry(3);
    Carry(4) <= g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & p0 & Cin);
    
    g4 <= X(4) & Y(4);
    p4 <= X(4) | Y(4);
    S(4) <= X(4) ^ Y(4) ^ Carry(4);
    Carry(5) <= g4 | (p4 & g3) | (p4 & p3 & g2) | (p4 & p3 & p2 & g1) | (p4 & p3 & p2 & p1 & g0) | (p4 & p3 & p2 & p1 & p0 & Cin);
    
    g5 <= X(5) & Y(5);
    p5 <= X(5) | Y(5);
    S(5) <= X(5) ^ Y(5) ^ Carry(5);
    Carry(6) <= g5 | (p5 & g4) | (p5 & p4 & g3) | (p5 & p4 & p3 & g2) | (p5 & p4 & p3 & p2 & g1) | (p5 & p4 & p3 & p2 & p1 & g0) | (p5 & p4 & p3 & p2 & p1 & p0 & Cin);
    
    g6 <= X(6) & Y(6);
    p6 <= X(6) | Y(6);
    S(6) <= X(6) ^ Y(6) ^ Carry(6);
    Carry(7) <= g6 | (p6 & g5) | (p6 & p5 & g4) | (p6 & p5 & p4 & g3) | (p6 & p5 & p4 & p3 & g2) | (p6 & p5 & p4 & p3 & p2 & g1) | (p6 & p5 & p4 & p3 & p2 & p1 & g0) | (p6 & p5 & p4 & p3 & p2 & p1 & p0 & Cin);
    
    g7 <= X(7) & Y(7);
    p7 <= X(7) | Y(7);
    S(7) <= X(7) ^ Y(7) ^ Carry(7);

    P <= p7 & p6 & p5 & p4 & p3 & p2 & p1 & p0;
    G <= g7 | (p7 & g6) | (p7 & p6 & g5) | (p7 & p6 & p5 & g4) | (p7 & p6 & p5 & p4 & g3) | (p7 & p6 & p5 & p4 & p3 & g2) | (p7 & p6 & p5 & p4 & p3 & p2 & g1) | (p7 & p6 & p5 & p4 & p3 & p2 & p1 & g0);
    C <= Carry(7);
end