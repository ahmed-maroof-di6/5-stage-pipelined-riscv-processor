`ifndef mux2by1_INCLUDED
`define mux2by1_INCLUDED

module mux2by1 (
   input sel,
   input [31:0] in0, in1,
   output [31:0] mux_out
);

assign  mux_out = (sel) ? in0 : in1;

endmodule

`endif 