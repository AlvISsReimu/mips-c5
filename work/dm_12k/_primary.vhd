library verilog;
use verilog.vl_types.all;
entity dm_12k is
    port(
        addr            : in     vl_logic_vector(16 downto 2);
        din             : in     vl_logic_vector(31 downto 0);
        we              : in     vl_logic;
        be              : in     vl_logic_vector(3 downto 0);
        clk             : in     vl_logic;
        dout            : out    vl_logic_vector(31 downto 0);
        clr             : in     vl_logic
    );
end dm_12k;
