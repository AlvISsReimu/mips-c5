library verilog;
use verilog.vl_types.all;
entity control_unit is
    port(
        clk_I           : in     vl_logic;
        rst_I           : in     vl_logic;
        op_I            : in     vl_logic_vector(31 downto 26);
        Func_I          : in     vl_logic_vector(5 downto 0);
        ALUout_I        : in     vl_logic_vector(31 downto 0);
        Zero_I          : in     vl_logic;
        Ir_25_21_I      : in     vl_logic_vector(4 downto 0);
        Ir_20_16_I      : in     vl_logic_vector(4 downto 0);
        IntReq_I        : in     vl_logic;
        Ready           : in     vl_logic;
        PCSrc_O         : out    vl_logic_vector(2 downto 0);
        RegDst_O        : out    vl_logic_vector(1 downto 0);
        MemtoReg_O      : out    vl_logic_vector(2 downto 0);
        ALUSrcA_O       : out    vl_logic_vector(1 downto 0);
        ALUSrcB_O       : out    vl_logic_vector(1 downto 0);
        be_O            : out    vl_logic_vector(3 downto 0);
        MemWrite_O      : out    vl_logic;
        RegWrite_O      : out    vl_logic;
        IRWrite_O       : out    vl_logic;
        PCWrite_O       : out    vl_logic;
        ALUOp_O         : out    vl_logic_vector(3 downto 0);
        MDOp_O          : out    vl_logic_vector(2 downto 0);
        MT_O            : out    vl_logic_vector(1 downto 0);
        MDCTRL_O        : out    vl_logic;
        TimerWrite_O    : out    vl_logic;
        EPC_Wen_O       : out    vl_logic;
        EXLSet_O        : out    vl_logic;
        EXLClr_O        : out    vl_logic
    );
end control_unit;
