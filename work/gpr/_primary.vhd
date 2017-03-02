library verilog;
use verilog.vl_types.all;
entity gpr is
    port(
        A1_I            : in     vl_logic_vector(31 downto 0);
        A2_I            : in     vl_logic_vector(31 downto 0);
        clk_I           : in     vl_logic;
        clr_I           : in     vl_logic;
        WD_I            : in     vl_logic_vector(31 downto 0);
        Wreg_I          : in     vl_logic_vector(4 downto 0);
        RegWrite_I      : in     vl_logic;
        RD1_O           : out    vl_logic_vector(31 downto 0);
        RD2_O           : out    vl_logic_vector(31 downto 0)
    );
end gpr;
