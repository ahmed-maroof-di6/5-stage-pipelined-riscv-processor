module regFile (
  input clock, reset, wEn,
  input [31:0] write_data,
  input [4:0] read_reg1, read_reg2, write_reg,
  output [31:0] read_data1, read_data2
);

  reg [31:0] reg_file[31:0];
  integer k;
  
always @(posedge clock ) begin
        if (wEn) begin
            reg_file[write_reg] <= write_data;
        end
    end
  
    assign read_data1 = (reset == 0) ? reg_file[read_reg1] : 0;
    assign read_data2 = (reset == 0) ? reg_file[read_reg2] : 0;

        initial begin
            reg_file[0] = 32'h00000000;
            reg_file[1] = 32'h00000002;
            reg_file[2] = 32'h00000008;
            reg_file[3] = 32'h00000056;
            reg_file[4] = 32'h000000ab;
            reg_file[5] = 32'h0000000d;
            reg_file[6] = 32'h00000007;
            reg_file[7] = 32'h00000006;
            reg_file[8] = 32'h0000000b;
            reg_file[9] = 32'h00000004;
            reg_file[10] = 32'h00000030;
            reg_file[11] = 32'h00000900;
            reg_file[12] = 32'h0000b400;
            reg_file[13] = 32'h00000ff1;
            reg_file[14] = 32'h00000009;
            reg_file[15] = 32'h00000067;
            reg_file[16] = 32'h0000cd40;
            reg_file[17] = 32'h00000880;
            reg_file[18] = 32'h00000990;
            reg_file[19] = 32'h00000450;
            reg_file[20] = 32'h00000008;
            reg_file[21] = 32'h00000005;
            reg_file[22] = 32'h00054321;
            reg_file[23] = 32'h00009bdf;
            reg_file[24] = 32'h000000e0;
            reg_file[25] = 32'h000002c3;
            reg_file[26] = 32'h00000432;
            reg_file[27] = 32'h0000ef01;
            reg_file[28] = 32'h00000678;
            reg_file[29] = 32'h0005ace0;
            reg_file[30] = 32'h000000c3;
            reg_file[31] = 32'h00088bdf;
        end
   

endmodule