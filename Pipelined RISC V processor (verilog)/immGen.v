module immGen (
   input [31:0] inst,
   output reg [31:0] GenOut
);

   // Concatenate the bits as intended
   always @* begin
      
            if (inst[6:0] == 7'b0100011) begin // S - type
    GenOut = (inst[31] == 1'b1) ? {{20{1'b1}}, inst[31:25], inst[11:7]} : {{20{1'b0}}, inst[31:25], inst[11:7]};
   end else if (inst[6:0] == 7'b0000011) begin // I - type
    GenOut = (inst[31] == 1'b1) ? {{20{1'b1}}, inst[31:20]} : {{20{1'b0}}, inst[31:20]};
   end else if (inst[6:0] == 7'b1100011) begin // B - type
    GenOut = (inst[31] == 1'b1) ? {{21{1'b1}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0} : {{21{1'b0}}, inst[31], inst[7], inst[30:25], inst[11:8],1'b0};
   end else if (inst[6:0] == 7'b1101111) begin // J - type
    GenOut = (inst[31] == 1'b1) ? {{11{1'b1}}, inst[31], inst[19:12], inst[20], inst[30:20], 1'b0} : {{11{1'b0}}, inst[31], inst[19:12], inst[20], inst[30:20], 1'b0};
   end else if (inst[6:0] == 7'b0110111) begin // U - type
    GenOut = {inst[31:12], {12{1'b0}}};
   end 
   end

endmodule
