library verilog;
use verilog.vl_types.all;
entity mult_div is
    generic(
        s0              : integer := 0;
        s1              : integer := 1;
        s2              : integer := 2
    );
    port(
        clk_I           : in     vl_logic;
        MDCtrl_I        : in     vl_logic;
        A_I             : in     vl_logic_vector(31 downto 0);
        B_I             : in     vl_logic_vector(31 downto 0);
        HI_O            : out    vl_logic_vector(31 downto 0);
        LO_O            : out    vl_logic_vector(31 downto 0);
        op_I            : in     vl_logic_vector(2 downto 0);
        MT_I            : in     vl_logic_vector(1 downto 0);
        Wdata_I         : in     vl_logic_vector(31 downto 0);
        memtoreg        : in     vl_logic_vector(2 downto 0);
        Ready_O         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
end mult_div;
