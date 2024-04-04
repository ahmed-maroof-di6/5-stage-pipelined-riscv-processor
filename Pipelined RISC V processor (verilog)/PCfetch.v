module PCfetch(
  input  clock,
  input  reset,
  input  [31:0] target_PC,
  output [31:0] PC
);

   reg [31:0] PC_reg;
   assign PC = PC_reg;

always @(posedge clock ) begin
  if (reset) begin
      PC_reg <= 32'b0;
  end else begin
      PC_reg = target_PC;
end
end 
endmodule

