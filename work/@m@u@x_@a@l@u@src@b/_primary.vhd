library verilog;
use verilog.vl_types.all;
entity MUX_ALUSrcB is
    port(
        ALUSrcB         : in     vl_logic_vector(1 downto 0);
        EXT             : in     vl_logic_vector(31 downto 0);
        GPR_B           : in     vl_logic_vector(31 downto 0);
        B               : out    vl_logic_vector(31 downto 0)
    );
end MUX_ALUSrcB;
