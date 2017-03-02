library verilog;
use verilog.vl_types.all;
entity MUX_MemtoReg is
    port(
        MemtoReg        : in     vl_logic_vector(2 downto 0);
        Aluout          : in     vl_logic_vector(31 downto 0);
        Dr              : in     vl_logic_vector(31 downto 0);
        High            : in     vl_logic_vector(31 downto 0);
        Low             : in     vl_logic_vector(31 downto 0);
        PrDIn           : in     vl_logic_vector(31 downto 0);
        CP0             : in     vl_logic_vector(31 downto 0);
        Wdata           : out    vl_logic_vector(31 downto 0)
    );
end MUX_MemtoReg;
