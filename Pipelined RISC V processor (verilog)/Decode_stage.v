`include "regFile.v"
`include "immGen.v"
`include "controller.v" 

// D or DIS - Decode Instruction Stage  
module Decode_stage (
   input reset, clock, wEn,
   input [4:0] write_reg,
   input [31:0] instruction_D, write_data, PC_D,
   output ALUscrE, memToRegE, regWriteE, memReadE, memWriteE, branchE, 
   output [1:0] ALUopE,
   output [4:0] write_regE, read_regE1, read_regE2,
   output [31:0] read_dataE1, read_dataE2, PC_E, GenOutE
);
  
   wire ALUscr, memToReg, regWrite, memRead, memWrite, branch; 
   wire [1:0] ALUop;
   wire [31:0] GenOutD, read_data01, read_data02;

   reg ALUscrD, memToRegD, regWriteD, memReadD, memWriteD, branchD; 
   reg [1:0] ALUopD;
   reg [4:0] write_regD, read_regD1_reg, read_regD2_reg;
   reg [31:0] PC_D_reg, read_data01_reg, read_data02_reg, GenOut_reg;
   

   regFile regFile_DIS (
        .clock(clock),
        .reset(reset),
        .wEn(wEn),
        .write_data(write_data),
        .read_reg1(instruction_D[19:15]), 
        .read_reg2(instruction_D[24:20]), 
        .write_reg(write_reg),
        .read_data1(read_data01), 
        .read_data2(read_data02)
    );

   immGen immGen_DIS (
       .inst(instruction_D),
       .GenOut(GenOutD)
    );

   controller Controller_DIS (
        .opcode(instruction_D[6:0]),
        .ALUscr(ALUscr), 
        .memToReg(memToReg), 
        .regWrite(regWrite), 
        .memRead(memRead), 
        .memWrite(memWrite), 
        .branch(branch), 
        .ALUop(ALUop)
    );

always @(posedge clock ) begin

    if (reset) begin
       {ALUscrD, memToRegD, regWriteD, memReadD, memWriteD, branchD, ALUopD} = 8'b00000000;
       PC_D_reg = 32'b0;
       read_data01_reg = 32'b0;
       read_data02_reg = 32'b0;
       GenOut_reg = 32'b0;
       write_regD = 5'b0;  
       read_regD1_reg = 5'b0;
       read_regD2_reg = 5'b0; 
    end else begin
       ALUscrD = ALUscr;
       memToRegD = memToReg; 
       regWriteD = regWrite; 
       memReadD = memRead;
       memWriteD = memWrite; 
       branchD = branch;
       ALUopD = ALUop;
       PC_D_reg = PC_D;
       read_data01_reg = read_data01;
       read_data02_reg = read_data02;
       GenOut_reg = GenOutD;
       write_regD = instruction_D[11:7];
       read_regD1_reg = instruction_D[19:15];
       read_regD2_reg = instruction_D[24:20]; 
    end
end

     assign ALUscrE = ALUscrD;
     assign memToRegE = memToRegD;
     assign regWriteE = regWriteD;
     assign memReadE = memReadD;
     assign memWriteE = memWriteD;
     assign branchE = branchD; 
     assign ALUopE = ALUopD;
     assign write_regE = write_regD;
     assign read_regE1 = read_regD1_reg;
     assign read_regE2 = read_regD2_reg;
     assign read_dataE1 = read_data01_reg;
     assign read_dataE2 = read_data02_reg; 
     assign PC_E = PC_D_reg;
     assign GenOutE = GenOut_reg;
   


endmodule