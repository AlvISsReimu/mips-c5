library verilog;
use verilog.vl_types.all;
entity im_8k is
    port(
        addr            : in     vl_logic_vector(21 downto 2);
        dout            : out    vl_logic_vector(31 downto 0)
    );
end im_8k;
