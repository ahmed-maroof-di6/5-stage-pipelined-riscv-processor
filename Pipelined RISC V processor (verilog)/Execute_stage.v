`include "mux3x1.v"
`include "ALU.v"
`include "ALUcntrl.v"
`include "mux.v"

// E or ES - Execute Instruction Stage
module Execut_stage (
   input clock, reset,
   input ALUscrE, memToRegE, regWriteE, memReadE, memWriteE, branchE, 
   input [1:0] ALUopE, mux1_sel, mux2_sel,
   input [2:0] func3,
   input [6:0] func7,
   input [3:0] alu_opcodeE,
   input [4:0] write_regE, read_regE1, read_regE2,
   input [31:0] read_dataE1, read_dataE2, PC_E, GenOutE, dataReadE, alu_outE,
   output memToRegM, regWriteM, memReadM, memWriteM, branchM, alu_zeroM,
   output [4:0] write_regM,
   output [31:0] write_dataM, alu_outM, PC_M, 
   output [4:0] read_regH1, read_regH2
);

   wire alu_zero;
   wire [3:0] alu_opcode;  
   wire [31:0] alu_out, muxOut1, muxOut2, mux_alu2;

   reg memToRegE_reg, regWriteE_reg, memReadE_reg, memWriteE_reg, branchE_reg, alu_zero_reg;
   reg [4:0] write_regE_reg;
   reg [31:0] alu_out_reg, write_data_reg, PC_E_reg, read_regH1_reg, read_regH2_reg;

  mux2by1 mux2_EIS (
        .sel(ALUscrE),
        .in0(muxOut2), 
        .in1(GenOutE),
        .mux_out(mux_alu2)
    );

 alu alu1_EIS ( 
        .alu_opcode(alu_opcode),
        .in_a(muxOut1),
        .in_b(mux_alu2), 
        .zero(alu_zero),
        .alu_out(alu_out) 
   );

 mux3x1 mux_to_alu1_EIS (
        .in0(read_dataE1), 
        .in1(dataReadE), 
        .in2(alu_outE),
        .sel(mux1_sel),
        .muxOut(muxOut1)
   );

 mux3x1 mux_to_alu2_EIS (
        .in0(read_dataE2), 
        .in1(dataReadE), 
        .in2(alu_outE),
        .sel(mux2_sel),
        .muxOut(muxOut2)
   );

 ALUcntrl ALUcntrl_EIS (
        .ALUop(ALUopE),
        .func7(func7), 
        .func3(func3),
        .alu_opcode(alu_opcode)
    );

 
always @(posedge clock ) begin

    if (reset) begin
       {memToRegE_reg, regWriteE_reg, memReadE_reg, memWriteE_reg, branchE_reg, alu_zero_reg} = 6'b000000;
       write_regE_reg = 5'b0;
       PC_E_reg = 32'b0;
       alu_out_reg = 32'b0;
       write_data_reg = 32'b0;
       read_regH1_reg = 32'b0;
       read_regH2_reg = 32'b0;
        
    end else begin
       memToRegE_reg = memToRegE;
       regWriteE_reg = regWriteE;
       memReadE_reg = memReadE;
       memWriteE_reg = memWriteE;
       branchE_reg = branchE;
       alu_zero_reg = alu_zero;
       write_regE_reg = write_regE;
       PC_E_reg = (( GenOutE << 1 ) + PC_E);
       alu_out_reg = alu_out;
       write_data_reg = muxOut2;
       read_regH1_reg = read_regE1;
       read_regH2_reg = read_regE2;
    end
end

   assign memToRegM = memToRegE_reg;
   assign regWriteM =  regWriteE_reg;
   assign memReadM = memReadE_reg;
   assign memWriteM = memWriteE_reg;
   assign branchM = branchE_reg;
   assign alu_zeroM = alu_zero_reg;
   assign write_regM = write_regE_reg;
   assign write_dataM = write_data_reg;
   assign alu_outM = alu_out_reg;
   assign PC_M = PC_E_reg;
   assign read_regH1 = read_regH1_reg;
   assign read_regH2 = read_regH2_reg;

    
endmodule