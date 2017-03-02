library verilog;
use verilog.vl_types.all;
entity mips is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        HWInt           : in     vl_logic_vector(7 downto 2);
        PrDIn           : in     vl_logic_vector(31 downto 0);
        PrDOut          : out    vl_logic_vector(31 downto 0);
        PrAddr          : out    vl_logic_vector(31 downto 2);
        BE              : out    vl_logic_vector(3 downto 0);
        Wen             : out    vl_logic
    );
end mips;
