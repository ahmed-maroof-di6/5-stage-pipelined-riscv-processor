`include "mux.v"                  
`include "PCfetch.v"
`include "instrMem.v"
// PC - Program Pounter 
// F or FIS - Fetch Instruction Stage

module Fetch_stage (
    input reset, clock, PC_scr,
    input [31:0] PC_M, 
    output [31:0] instruction_D, PC_D
    );

    wire [31:0] PC_F, PCplus4, instr_F , muxtoPC;
    reg [31:0] PC_F_reg, instr_F_reg;

   mux2by1 muxToPC_FIS (
        .sel(PC_scr),
        .in0(PC_M), 
        .in1(PCplus4),
        .mux_out(muxtoPC)
    );

   PCfetch PCfetch_FIS (
     .clock(clock),
     .reset(reset),
     .target_PC(muxtoPC),
     .PC(PC_F)
    );

   instrMem InsterMen_FIS (
     .address(PC_F),
     .reset(reset),
     .instruction(instr_F)
    );

   always @(posedge clock ) begin
     if (reset) begin
       PC_F_reg <= 32'h0;
       instr_F_reg <= 32'h0;
     end else begin
       PC_F_reg <= PC_F;
       instr_F_reg <= instr_F;
     end 
  end
  
    assign PCplus4 = (reset) ? 32'h00000000 : (PC_F + 32'h0 + 32'h4);
    assign PC_D = PC_F_reg;
    assign instruction_D = (reset) ? 32'h00000000 : instr_F_reg;
    
endmodule
