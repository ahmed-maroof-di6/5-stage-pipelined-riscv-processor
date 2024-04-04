module mux3x1 (
    input [31:0] in0, in1, in2,
    input [1:0] sel,
    output reg [31:0] muxOut
);
    always @* begin
        case (sel)
          2'b00  : muxOut <= in0;
          2'b01  : muxOut <= in1;
          2'b10  : muxOut <= in2;
          2'b11  : muxOut <= 32'b0;
        endcase
    end

endmodule