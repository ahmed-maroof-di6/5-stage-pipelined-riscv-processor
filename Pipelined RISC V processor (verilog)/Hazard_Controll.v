module Hazard_controll (
    input regWriteM, regWriteW, 
    input [4:0] read_reg1, read_reg2, write_regM, write_regW,
    output reg [1:0] forwardingA, forwardingB
);

     
 always @* begin
               if ((regWriteM == 1'b1) && (write_regM !== 5'b0) && (write_regM == read_reg1)) begin
         forwardingA = 2'b10; 
      end else if ((regWriteW == 1'b1) && (write_regW !== 5'b0) && (write_regW == read_reg1)) begin
         forwardingA = 2'b01; 
      end else begin
        forwardingA = 2'b00;
      end
              if ((regWriteM == 1'b1) && (write_regM !== 5'b0) && (write_regM == read_reg2)) begin
         forwardingB = 2'b10; 
      end else if ((regWriteW == 1'b1) && (write_regW !== 5'b0) && (write_regW == read_reg2)) begin
         forwardingB = 2'b01; 
      end else begin
         forwardingB = 2'b00;
      end   
   end
    
endmodule