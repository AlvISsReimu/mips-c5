library verilog;
use verilog.vl_types.all;
entity npc is
    port(
        pc_I            : in     vl_logic_vector(31 downto 2);
        RD1_I           : in     vl_logic_vector(31 downto 0);
        ALUout_I        : in     vl_logic_vector(31 downto 0);
        Jumpadd_I       : in     vl_logic_vector(25 downto 0);
        PCSrc_I         : in     vl_logic_vector(2 downto 0);
        Zero_I          : in     vl_logic;
        EPC_I           : in     vl_logic_vector(31 downto 2);
        npc_O           : out    vl_logic_vector(31 downto 2)
    );
end npc;
