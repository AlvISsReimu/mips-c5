library verilog;
use verilog.vl_types.all;
entity cp0 is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        PC              : in     vl_logic_vector(31 downto 2);
        DIn             : in     vl_logic_vector(31 downto 0);
        HWInt           : in     vl_logic_vector(5 downto 0);
        Sel             : in     vl_logic_vector(4 downto 0);
        Wen             : in     vl_logic;
        EXLSet          : in     vl_logic;
        EXLClr          : in     vl_logic;
        IntReq          : out    vl_logic;
        EPC             : out    vl_logic_vector(31 downto 2);
        DOut            : out    vl_logic_vector(31 downto 0)
    );
end cp0;
