`include "dataMem.v"

// M or MS - memory stage
module Memory_stage (
    input clock, reset,
    input memToRegM, regWriteM, memReadM, memWriteM, branchM, alu_zeroM,
    input [4:0] write_regM,
    input [31:0] alu_outM, write_dataM, PC_M,
    output regWriteW, memToRegW, PCscr,
    output [4:0] write_regW,
    output [31:0] readDataW, alu_outW, PC_out
);
   
   wire AND;
   wire [31:0] readData;
   
   reg regWriteM_reg, memToRegM_reg;
   reg [4:0] write_regM_reg;
   reg [31:0] readData_reg, alu_out_reg, PC_M_reg;

  dataMem DataMem_MS (
        .clock(clock),
        .reset(reset),
        .memWrite(memWriteM),
        .memRead(memReadM),
        .address(alu_outM), 
        .dataWrite(write_dataM),
        .dataRead(readData)
    );
 
  assign AND = (branchM & alu_zeroM);

 always @(posedge clock ) begin
    if (reset) begin
         regWriteM_reg = 1'b0;
         memToRegM_reg = 1'b0;
         write_regM_reg = 5'b0;
         readData_reg = 32'b0;
         alu_out_reg = 32'b0;
         PC_M_reg = 32'b0;
    end else begin
         regWriteM_reg = regWriteM;
         memToRegM_reg = memToRegM;
         write_regM_reg = write_regM;
         readData_reg = readData;
         alu_out_reg = alu_outM;
         PC_M_reg = PC_M;
    end  
 end
         assign regWriteW = regWriteM_reg;
         assign memToRegW = memToRegM_reg;
         assign PCscr = AND;
         assign write_regW = write_regM_reg;
         assign readDataW = readData_reg;
         assign alu_outW = alu_out_reg;
         assign PC_out = PC_M_reg;
     
    
endmodule