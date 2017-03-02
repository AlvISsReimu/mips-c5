library verilog;
use verilog.vl_types.all;
entity bridge is
    port(
        PrAddr_I        : in     vl_logic_vector(31 downto 2);
        PrWD_I          : in     vl_logic_vector(31 downto 0);
        DEV_RD_I        : in     vl_logic_vector(31 downto 0);
        BE_I            : in     vl_logic_vector(3 downto 0);
        PrRD_O          : out    vl_logic_vector(31 downto 0);
        DEV_Addr_O      : out    vl_logic_vector(1 downto 0);
        DEV_WD_O        : out    vl_logic_vector(31 downto 0)
    );
end bridge;
