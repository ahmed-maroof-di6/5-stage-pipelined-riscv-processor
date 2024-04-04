 `include "Pipelined_RISC_V_main.v"

`timescale 1ns/1ps

module tb_Pipeline_RISCV_main;

  // Define clock and reset signals
  reg clock , reset;

  // Instantiate your CSP_RISCV_main processor
  pipelined_risc_v PPL_RV (
    .clock(clock),
    .reset(reset) // Connect your 32-bit address input
  );

  initial repeat (13) begin #5 clock=1; #5 clock=0; end
 
    initial @(posedge clock ) begin

     $display("--------PIPELINE RISC-V PROCESSOR TESTING--------");

    $monitor("At time %0d reset=%b PC = %h, Instruction = %h, alu_out = %h, DataRead = %h",
           $time, reset, PPL_RV.IF.PCplus4, PPL_RV.instruction1, PPL_RV.alu_out1, PPL_RV.data_out1); 

    reset = 1;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
    reset = 1;   @(posedge clock) 
    reset = 0;   @(posedge clock) 
  
    $display("TEST PASSED");
    $finish;
    end
    
    initial begin
    $dumpvars;
    $dumpfile("dump.vcd");
    end  

endmodule
