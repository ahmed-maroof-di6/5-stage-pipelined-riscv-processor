module dataMem (
  input reset, clock, memWrite, memRead,
  input [31:0] address, dataWrite,
  output [31:0] dataRead
);
     reg [31:0] memory [1023:0];

always @(posedge clock ) begin

    if (memWrite) begin
        memory[address] <= dataWrite;
    end 
  end
  
     assign dataRead = (reset) ? 32'h0 : memory[address];

  // initial begin
  //   memory[12] = 32'h0000000f;
  // end
    integer i;
    initial begin   // initializing data memory
      for (i = 0; i < 1023; i = i + 1) begin
        memory[i] = 32'h00000001 + (i*4);
      end 
    end
    

endmodule
