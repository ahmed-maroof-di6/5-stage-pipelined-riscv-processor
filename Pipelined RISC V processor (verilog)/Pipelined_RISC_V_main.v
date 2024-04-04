`include "Fetch_stage.v"
`include "Decode_stage.v"
`include "Execute_stage.v"
`include "Memory_stage.v"
`include "Writeback_stage.v"
`include "Hazard_Controll.v"

module pipelined_risc_v (
    input reset, clock
);

    wire PC_scr1, regWrite0, ALUscr1, memToReg1, regWrite1, memRead1, memWrite1, branch1; 
    wire alu_zeroEM, regWriteMW, memToRegMW, memToRegEM, regWriteEM, memReadEM, memWriteEM, branchEM;
    wire [1:0] ALUop1, forwardHA, forwardHB;
    wire [4:0] write_reg1, write_regDE, write_regEM, write_regMW, Readreg1, Readreg2, ReadregEH1, ReadregEH2;
    wire [31:0] instruction1, PC_MF, PC_M1, PC_D1, PC_E1, data_out1, ReadData1, ReadData2, GenOut1;
    wire [31:0] alu_out1, alu_outEM, write_dataEM, readDataMW;


   Fetch_stage IF (
    .reset(reset),
    .clock(clock), 
    .PC_scr(PC_scr1),
    .PC_M(PC_MF), 
    .instruction_D(instruction1),
    .PC_D(PC_D1)
    );

   Decode_stage ID (
    .reset(reset),
    .clock(clock),
    .wEn(regWrite0),
    .write_reg(write_reg1),
    .instruction_D(instruction1), 
    .write_data(data_out1),
    .PC_D(PC_D1),
    .ALUscrE(ALUscr1), 
    .memToRegE(memToReg1), 
    .regWriteE(regWrite1), 
    .memReadE(memRead1), 
    .memWriteE(memWrite1), 
    .branchE(branch1), 
    .ALUopE(ALUop1),
    .write_regE(write_regDE),
    .read_regE1(Readreg1), 
    .read_regE2(Readreg2),
    .read_dataE1(ReadData1), 
    .read_dataE2(ReadData2), 
    .PC_E(PC_E1), 
    .GenOutE(GenOut1)
    );

   Execut_stage EX (
    .reset(reset),
    .clock(clock), 
    .ALUscrE(ALUscr1), 
    .memToRegE(memToReg1), 
    .regWriteE(regWrite1), 
    .memReadE(memRead1), 
    .memWriteE(memWrite1), 
    .branchE(branch1), 
    .ALUopE(ALUop1), 
    .mux1_sel(forwardHA), 
    .mux2_sel(forwardHB),
    .func3(instruction1[14:12]),
    .func7(instruction1[31:25]),
    .write_regE(write_regDE),
    .read_regE1(Readreg1), 
    .read_regE2(Readreg2),
    .read_dataE1(ReadData1), 
    .read_dataE2(ReadData2), 
    .PC_E(PC_E1), 
    .GenOutE(GenOut1), 
    .dataReadE(data_out1), 
    .alu_outE(alu_out1),
    .memToRegM(memToRegEM), 
    .regWriteM(regWriteEM), 
    .memReadM(memReadEM), 
    .memWriteM(memWriteEM), 
    .branchM(branchEM), 
    .alu_zeroM(alu_zeroEM),
    .write_regM(write_regEM),
    .write_dataM(write_dataEM), 
    .alu_outM(alu_outEM), 
    .PC_M(PC_M1),
    .read_regH1(ReadregEH1),
    .read_regH2(ReadregEH2)
    );

   Memory_stage MEM (
    .reset(reset),
    .clock(clock), 
    .memToRegM(memToRegEM), 
    .regWriteM(regWriteEM), 
    .memReadM(memReadEM), 
    .memWriteM(memWriteEM), 
    .branchM(branchEM), 
    .alu_zeroM(alu_zeroEM),
    .write_regM(write_regEM),
    .alu_outM(alu_outEM), 
    .write_dataM(write_dataEM), 
    .PC_M(PC_M1),
    .regWriteW(regWriteMW), 
    .memToRegW(memToRegMW), 
    .PCscr(PC_scr1),
    .write_regW(write_regMW),
    .readDataW(readDataMW), 
    .alu_outW(alu_out1), 
    .PC_out(PC_MF)
    );

   WriteBack_stage WB (
    .reset(reset),
    .clock(clock),
    .regWriteW(regWriteMW), 
    .memToRegW(memToRegMW), 
    .write_regW(write_regMW),
    .readDataW(readDataMW), 
    .alu_outW(alu_out1), 
    .regWriteDS(regWrite0), 
    .data_out(data_out1), 
    .write_regDS(write_reg1)
    );

    Hazard_controll Hazard_Control (
    .regWriteM(regWriteMW), 
    .regWriteW(regWrite0), 
    .read_reg1(ReadregEH1), 
    .read_reg2(ReadregEH2), 
    .write_regM(write_regMW), 
    .write_regW(write_reg1),
    .forwardingA(forwardHA), 
    .forwardingB(forwardHB)
    );
   

endmodule