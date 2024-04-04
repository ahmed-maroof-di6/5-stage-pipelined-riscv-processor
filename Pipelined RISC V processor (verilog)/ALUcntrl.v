module ALUcntrl (
    input [1:0] ALUop,
    input [6:0] func7,
    input [2:0] func3,
    output reg [3:0] alu_opcode
);

   always @* begin
             if ((ALUop  == 2'b00) /*& (func7 == 7'bx) & (func3 == 3'bx)*/) begin 
      alu_opcode = 4'b0010;
    end else if ((ALUop[0]  == 1) /*& (func7 == 7'bx) & (func3 == 3'bx)*/) begin 
      alu_opcode = 4'b0110;
    end else if ((ALUop[1]  == 1) & (func7 == 7'b0) & (func3 == 3'b0)) begin 
      alu_opcode = 4'b0010;
    end else if ((ALUop[1]  == 1) & (func7 == 7'b0100000) & (func3 == 3'b0)) begin 
      alu_opcode = 4'b0110;
    end else if ((ALUop[1]  == 1) & (func7 == 7'b0) & (func3 == 3'b111)) begin 
      alu_opcode = 4'b0000;
    end else if ((ALUop[1]  == 1) & (func7 == 7'b0) & (func3 == 3'b110)) begin 
      alu_opcode = 4'b0001;
    end 
   end
      
endmodule