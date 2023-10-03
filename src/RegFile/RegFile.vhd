library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.array_types.all;

entity RegFile is
    port(data : in std_logic_vector(31 downto 0);
        i_rs : in std_logic_vector(4 downto 0);
        i_rt : in std_logic_vector(4 downto 0);
        i_rd : in std_logic_vector(4 downto 0);
        reset : in std_logic;
        clk : in std_logic;
        o_rs : out std_logic_vector(31 downto 0);
        o_rt : out std_logic_vector(31 downto 0));
end RegFile;

architecture structural of RegFile is

    component Decoder5t32 is
        port(input : in std_logic_vector(4 downto 0);
            output : out std_logic_vector(31 downto 0));
    end component;

    component RegNBit is
        generic(N : integer := 32);
        port(clk : in std_logic;
            reset : in std_logic;
            we : in std_logic;
            data : in std_logic_vector(N-1 downto 0);
            o_data : out std_logic_vector(N-1 downto 0));
    end component;

    component mux32t1_array is
        port(s : in std_logic_vector(4 downto 0);
            data: in reg_data_array;
            output : out std_logic_vector(31 downto 0));
    end component;

    signal o_dec : std_logic_vector(31 downto 0);

    signal data_array : reg_data_array;
begin
    decoder: Decoder5t32
    port MAP(input => i_rd,
            output => o_dec);
    
    reg0 : RegNBit
    port MAP(clk => clk,
            reset => '1',
            we => '0',
            data => x"00000000",
            o_data => data_array(0));

    Regs : for i in 1 to 31 generate
        RegN : RegNBit
        port MAP(clk => clk,
                reset => reset,
                we => o_dec(i),
                data => data,
                o_data => data_array(i));
    end generate Regs;
    
    muxrs : mux32t1_array
    port MAP(s => i_rs,
            data => data_array,
            output => o_rs);

    muxrt : mux32t1_array
    port MAP(s => i_rt,
            data => data_array,
            output => o_rt);
end;