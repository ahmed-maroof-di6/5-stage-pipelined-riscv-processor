`include "mux.v"

// W or WIS - Write Back stage
module WriteBack_stage (
    input clock, reset,
    input regWriteW, memToRegW,
    input [4:0] write_regW,
    input [31:0] readDataW, alu_outW, 
    output regWriteDS, 
    output [31:0] data_out,
    output[4:0] write_regDS
);
    
    wire [31:0] muxOutData;
    
    reg regWriteW_reg;
    reg [31:0] muxOutData_reg;
    reg [4:0] write_regW_reg;

  mux2by1 muxOut_WBS (
        .sel(memToRegW),
        .in0(readDataW), 
        .in1(alu_outW),
        .mux_out(muxOutData)
    ); 

  always @(posedge clock ) begin
       if (reset) begin
        regWriteW_reg = 1'b0;
        muxOutData_reg = 32'b0;
        write_regW_reg = 32'b0;
       end else begin
        regWriteW_reg = regWriteW;
        muxOutData_reg = muxOutData;
        write_regW_reg = write_regW;
       end
  end

       assign regWriteDS = regWriteW_reg;
       assign data_out = muxOutData_reg;
       assign write_regDS = write_regW_reg;

endmodule