module instrMem (
   input [31:0] address,
   input reset,
   output [31:0] instruction
);
  reg [31:0] inst_mem [1023:0];  // Define a memory array to store instructions

  integer i;

  initial begin
  
      inst_mem[0] = 32'h015a09b3;   //0000 0001 0101 1010 0000 1001 1011 0011 - R
      inst_mem[4] = 32'h00236633;   //0000 0000 0101 0011 0110 1000 0011 0011 - R
      inst_mem[8] = 32'h00736aa3;   //0000 0000 0101 0011 0110 1000 0010 0011 - S
      inst_mem[12] = 32'h015a09b3;
      inst_mem[16] = 32'h70547b63;  //0000 0000 0101 0011 0110 1000 0100 0011 - B
      inst_mem[20] = 32'h005a9823;
      inst_mem[24] = 32'h00026723;
      inst_mem[28] = 32'h00a45833;  //0000 0000 0101 0011 0110 1000 0110 0011 - SB
      inst_mem[32] = 32'h005a0803;
      inst_mem[36] = 32'h00070b23;  

  end

  assign instruction = (reset == 1'b1) ? 32'b0 : inst_mem[address];

endmodule
