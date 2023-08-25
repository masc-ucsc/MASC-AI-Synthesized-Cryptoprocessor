module __decode__process_instruction(
  input wire clk,
  input wire [31:0] instruction,
  input wire [31:0] rs1,
  input wire [31:0] rs2,
  output wire [31:0] out
);
  // ===== Pipe stage 0:

  // Registers for pipe stage 0:
  reg [31:0] p0_instruction;
  reg [31:0] p0_rs1;
  reg [31:0] p0_rs2;
  always_ff @ (posedge clk) begin
    p0_instruction <= instruction;
    p0_rs1 <= rs1;
    p0_rs2 <= rs2;
  end

  // ===== Pipe stage 1:
  wire [5:0] p1_sub_8729_comb;
  wire [31:0] p1_sub_8730_comb;
  wire p1_eq_8732_comb;
  wire p1_eq_8733_comb;
  wire p1_eq_8734_comb;
  wire p1_eq_8735_comb;
  wire p1_eq_8751_comb;
  wire p1_or_8752_comb;
  wire p1_eq_8754_comb;
  wire p1_eq_8755_comb;
  wire p1_eq_8756_comb;
  wire p1_eq_8757_comb;
  wire p1_eq_8758_comb;
  wire p1_eq_8759_comb;
  wire p1_eq_8760_comb;
  wire [31:0] p1_or_8761_comb;
  wire [31:0] p1_or_8762_comb;
  wire [31:0] p1_or_8763_comb;
  wire [31:0] p1_nor_8764_comb;
  wire [31:0] p1_nand_8765_comb;
  wire [31:0] p1_not_8766_comb;
  wire p1_result__20_comb;
  wire p1_result__22_comb;
  wire p1_result__24_comb;
  wire p1_result__26_comb;
  wire p1_result__28_comb;
  wire p1_result__30_comb;
  wire p1_result__32_comb;
  wire p1_result__31_comb;
  wire p1_result__29_comb;
  wire p1_result__27_comb;
  wire p1_result__25_comb;
  wire p1_result__16_comb;
  wire p1_result__12_comb;
  wire p1_result__8_comb;
  wire p1_result__4_comb;
  wire p1_or_8782_comb;
  wire p1_result__6_comb;
  wire p1_result__10_comb;
  wire p1_result__14_comb;
  wire p1_result__23_comb;
  wire p1_result__21_comb;
  wire p1_result__19_comb;
  wire p1_result__18_comb;
  wire p1_result__15_comb;
  wire p1_result__11_comb;
  wire p1_result__7_comb;
  wire p1_result__17_comb;
  wire p1_result__3_comb;
  wire p1_result__13_comb;
  wire p1_result__1_comb;
  wire p1_result__5_comb;
  wire p1_result__9_comb;
  wire p1_result__2_comb;
  wire [9:0] p1_concat_8805_comb;
  wire [10:0] p1_concat_8813_comb;
  wire [9:0] p1_concat_8825_comb;
  wire [10:0] p1_concat_8843_comb;
  wire [11:0] p1_concat_8855_comb;
  wire [10:0] p1_concat_8866_comb;
  wire [10:0] p1_concat_8873_comb;
  wire [8:0] p1_concat_8885_comb;
  wire [31:0] p1_concat_8901_comb;
  assign p1_sub_8729_comb = 6'h20 - {1'h0, p0_rs2[4:0]};
  assign p1_sub_8730_comb = 32'h0000_0020 - p0_rs2;
  assign p1_eq_8732_comb = p0_instruction == 32'h0000_0006;
  assign p1_eq_8733_comb = p0_instruction == 32'h0000_0007;
  assign p1_eq_8734_comb = p0_instruction == 32'h0000_000a;
  assign p1_eq_8735_comb = p0_instruction == 32'h0000_000b;
  assign p1_eq_8751_comb = p0_instruction == 32'h0000_0009;
  assign p1_or_8752_comb = p1_eq_8732_comb | p1_eq_8733_comb;
  assign p1_eq_8754_comb = p0_instruction == 32'h0000_0008;
  assign p1_eq_8755_comb = p0_instruction == 32'h0000_0005;
  assign p1_eq_8756_comb = p0_instruction == 32'h0000_0004;
  assign p1_eq_8757_comb = p0_instruction == 32'h0000_0003;
  assign p1_eq_8758_comb = p0_instruction == 32'h0000_0002;
  assign p1_eq_8759_comb = p0_instruction == 32'h0000_0001;
  assign p1_eq_8760_comb = p0_instruction == 32'h0000_0000;
  assign p1_or_8761_comb = p0_rs1 >> p0_rs2[4:0] | (p1_sub_8729_comb >= 6'h20 ? 32'h0000_0000 : p0_rs1 << p1_sub_8729_comb);
  assign p1_or_8762_comb = p0_rs1 << p0_rs2[4:0] | (p1_sub_8729_comb >= 6'h20 ? 32'h0000_0000 : p0_rs1 >> p1_sub_8729_comb);
  assign p1_or_8763_comb = (p0_rs2 >= 32'h0000_0020 ? 32'h0000_0000 : p0_rs1 >> p0_rs2) | (p1_sub_8730_comb >= 32'h0000_0020 ? 32'h0000_0000 : p0_rs1 << p1_sub_8730_comb);
  assign p1_nor_8764_comb = ~(~p0_rs1 | p0_rs2);
  assign p1_nand_8765_comb = ~(~p0_rs1 & p0_rs2);
  assign p1_not_8766_comb = ~(p0_rs1 ^ p0_rs2);
  assign p1_result__20_comb = p0_rs1[25];
  assign p1_result__22_comb = p0_rs1[26];
  assign p1_result__24_comb = p0_rs1[27];
  assign p1_result__26_comb = p0_rs1[28];
  assign p1_result__28_comb = p0_rs1[29];
  assign p1_result__30_comb = p0_rs1[30];
  assign p1_result__32_comb = p0_rs1[31];
  assign p1_result__31_comb = p0_rs1[15];
  assign p1_result__29_comb = p0_rs1[14];
  assign p1_result__27_comb = p0_rs1[13];
  assign p1_result__25_comb = p0_rs1[12];
  assign p1_result__16_comb = p0_rs1[23];
  assign p1_result__12_comb = p0_rs1[21];
  assign p1_result__8_comb = p0_rs1[19];
  assign p1_result__4_comb = p0_rs1[17];
  assign p1_or_8782_comb = p1_eq_8751_comb | p1_eq_8735_comb;
  assign p1_result__6_comb = p0_rs1[18];
  assign p1_result__10_comb = p0_rs1[20];
  assign p1_result__14_comb = p0_rs1[22];
  assign p1_result__23_comb = p0_rs1[11];
  assign p1_result__21_comb = p0_rs1[10];
  assign p1_result__19_comb = p0_rs1[9];
  assign p1_result__18_comb = p0_rs1[24];
  assign p1_result__15_comb = p0_rs1[7];
  assign p1_result__11_comb = p0_rs1[5];
  assign p1_result__7_comb = p0_rs1[3];
  assign p1_result__17_comb = p0_rs1[8];
  assign p1_result__3_comb = p0_rs1[1];
  assign p1_result__13_comb = p0_rs1[6];
  assign p1_result__1_comb = p0_rs1[0];
  assign p1_result__5_comb = p0_rs1[2];
  assign p1_result__9_comb = p0_rs1[4];
  assign p1_result__2_comb = p0_rs1[16];
  assign p1_concat_8805_comb = {p1_eq_8734_comb | p1_eq_8735_comb, p1_eq_8751_comb, p1_eq_8754_comb, p1_eq_8732_comb, p1_eq_8755_comb, p1_eq_8756_comb, p1_eq_8757_comb, p1_eq_8758_comb, p1_eq_8759_comb, p1_eq_8760_comb};
  assign p1_concat_8813_comb = {p1_eq_8735_comb, p1_eq_8734_comb, p1_eq_8751_comb, p1_eq_8754_comb, p1_eq_8732_comb, p1_eq_8755_comb, p1_eq_8756_comb, p1_eq_8757_comb, p1_eq_8758_comb, p1_eq_8759_comb, p1_eq_8760_comb};
  assign p1_concat_8825_comb = {p1_eq_8734_comb, p1_or_8782_comb, p1_eq_8754_comb, p1_eq_8732_comb, p1_eq_8755_comb, p1_eq_8756_comb, p1_eq_8757_comb, p1_eq_8758_comb, p1_eq_8759_comb, p1_eq_8760_comb};
  assign p1_concat_8843_comb = {p1_eq_8735_comb, p1_eq_8751_comb | p1_eq_8734_comb, p1_eq_8754_comb, p1_eq_8733_comb, p1_eq_8732_comb, p1_eq_8755_comb, p1_eq_8756_comb, p1_eq_8757_comb, p1_eq_8758_comb, p1_eq_8759_comb, p1_eq_8760_comb};
  assign p1_concat_8855_comb = {p1_eq_8735_comb, p1_eq_8734_comb, p1_eq_8751_comb, p1_eq_8754_comb, p1_eq_8733_comb, p1_eq_8732_comb, p1_eq_8755_comb, p1_eq_8756_comb, p1_eq_8757_comb, p1_eq_8758_comb, p1_eq_8759_comb, p1_eq_8760_comb};
  assign p1_concat_8866_comb = {p1_eq_8734_comb, p1_or_8782_comb, p1_eq_8754_comb, p1_eq_8733_comb, p1_eq_8732_comb, p1_eq_8755_comb, p1_eq_8756_comb, p1_eq_8757_comb, p1_eq_8758_comb, p1_eq_8759_comb, p1_eq_8760_comb};
  assign p1_concat_8873_comb = {p1_eq_8735_comb, p1_eq_8734_comb, p1_eq_8751_comb, p1_eq_8754_comb, p1_or_8752_comb, p1_eq_8755_comb, p1_eq_8756_comb, p1_eq_8757_comb, p1_eq_8758_comb, p1_eq_8759_comb, p1_eq_8760_comb};
  assign p1_concat_8885_comb = {p1_eq_8751_comb, p1_eq_8754_comb, p1_or_8752_comb | p1_eq_8734_comb | p1_eq_8735_comb, p1_eq_8755_comb, p1_eq_8756_comb, p1_eq_8757_comb, p1_eq_8758_comb, p1_eq_8759_comb, p1_eq_8760_comb};
  assign p1_concat_8901_comb = {p1_or_8761_comb[31] & p1_concat_8805_comb[0] | p1_or_8762_comb[31] & p1_concat_8805_comb[1] | p1_or_8763_comb[31] & p1_concat_8805_comb[2] | p1_nor_8764_comb[31] & p1_concat_8805_comb[3] | p1_nand_8765_comb[31] & p1_concat_8805_comb[4] | p1_not_8766_comb[31] & p1_concat_8805_comb[5] | p0_rs2[15] & p1_concat_8805_comb[6] | p1_result__18_comb & p1_concat_8805_comb[7] | p1_result__15_comb & p1_concat_8805_comb[8] | p1_result__32_comb & p1_concat_8805_comb[9], p1_or_8761_comb[30:24] & {7{p1_concat_8813_comb[0]}} | p1_or_8762_comb[30:24] & {7{p1_concat_8813_comb[1]}} | p1_or_8763_comb[30:24] & {7{p1_concat_8813_comb[2]}} | p1_nor_8764_comb[30:24] & {7{p1_concat_8813_comb[3]}} | p1_nand_8765_comb[30:24] & {7{p1_concat_8813_comb[4]}} | p1_not_8766_comb[30:24] & {7{p1_concat_8813_comb[5]}} | p0_rs2[14:8] & {7{p1_concat_8813_comb[6]}} | {p1_result__20_comb, p1_result__22_comb, p1_result__24_comb, p1_result__26_comb, p1_result__28_comb, p1_result__30_comb, p1_result__32_comb} & {7{p1_concat_8813_comb[7]}} | p0_rs1[6:0] & {7{p1_concat_8813_comb[8]}} | {p1_result__31_comb, p1_result__30_comb, p1_result__29_comb, p1_result__28_comb, p1_result__27_comb, p1_result__26_comb, p1_result__25_comb} & {7{p1_concat_8813_comb[9]}} | {p1_result__28_comb, p1_result__24_comb, p1_result__20_comb, p1_result__16_comb, p1_result__12_comb, p1_result__8_comb, p1_result__4_comb} & {7{p1_concat_8813_comb[10]}}, p1_or_8761_comb[23] & p1_concat_8825_comb[0] | p1_or_8762_comb[23] & p1_concat_8825_comb[1] | p1_or_8763_comb[23] & p1_concat_8825_comb[2] | p1_nor_8764_comb[23] & p1_concat_8825_comb[3] | p1_nand_8765_comb[23] & p1_concat_8825_comb[4] | p1_not_8766_comb[23] & p1_concat_8825_comb[5] | p0_rs2[7] & p1_concat_8825_comb[6] | p1_result__2_comb & p1_concat_8825_comb[7] | p1_result__31_comb & p1_concat_8825_comb[8] | p1_result__24_comb & p1_concat_8825_comb[9], p1_or_8761_comb[22:17] & {6{p1_concat_8813_comb[0]}} | p1_or_8762_comb[22:17] & {6{p1_concat_8813_comb[1]}} | p1_or_8763_comb[22:17] & {6{p1_concat_8813_comb[2]}} | p1_nor_8764_comb[22:17] & {6{p1_concat_8813_comb[3]}} | p1_nand_8765_comb[22:17] & {6{p1_concat_8813_comb[4]}} | p1_not_8766_comb[22:17] & {6{p1_concat_8813_comb[5]}} | p0_rs2[6:1] & {6{p1_concat_8813_comb[6]}} | {p1_result__4_comb, p1_result__6_comb, p1_result__8_comb, p1_result__10_comb, p1_result__12_comb, p1_result__14_comb} & {6{p1_concat_8813_comb[7]}} | p0_rs1[14:9] & {6{p1_concat_8813_comb[8]}} | {p1_result__23_comb, p1_result__22_comb, p1_result__21_comb, p1_result__20_comb, p1_result__19_comb, p1_result__18_comb} & {6{p1_concat_8813_comb[9]}} | {p1_result__27_comb, p1_result__23_comb, p1_result__19_comb, p1_result__15_comb, p1_result__11_comb, p1_result__7_comb} & {6{p1_concat_8813_comb[10]}}, p1_or_8761_comb[16:15] & {2{p1_concat_8843_comb[0]}} | p1_or_8762_comb[16:15] & {2{p1_concat_8843_comb[1]}} | p1_or_8763_comb[16:15] & {2{p1_concat_8843_comb[2]}} | p1_nor_8764_comb[16:15] & {2{p1_concat_8843_comb[3]}} | p1_nand_8765_comb[16:15] & {2{p1_concat_8843_comb[4]}} | p1_not_8766_comb[16:15] & {2{p1_concat_8843_comb[5]}} | {p0_rs2[0], p1_result__31_comb} & {2{p1_concat_8843_comb[6]}} | {1'h0, p0_rs2[7]} & {2{p1_concat_8843_comb[7]}} | {p1_result__16_comb, p1_result__17_comb} & {2{p1_concat_8843_comb[8]}} | {p1_result__17_comb, p1_result__16_comb} & {2{p1_concat_8843_comb[9]}} | {p1_result__3_comb, p1_result__30_comb} & {2{p1_concat_8843_comb[10]}}, p1_or_8761_comb[14:9] & {6{p1_concat_8855_comb[0]}} | p1_or_8762_comb[14:9] & {6{p1_concat_8855_comb[1]}} | p1_or_8763_comb[14:9] & {6{p1_concat_8855_comb[2]}} | p1_nor_8764_comb[14:9] & {6{p1_concat_8855_comb[3]}} | p1_nand_8765_comb[14:9] & {6{p1_concat_8855_comb[4]}} | p1_not_8766_comb[14:9] & {6{p1_concat_8855_comb[5]}} | p0_rs1[14:9] & {6{p1_concat_8855_comb[6]}} | p0_rs2[6:1] & {6{p1_concat_8855_comb[7]}} | {p1_result__19_comb, p1_result__21_comb, p1_result__23_comb, p1_result__25_comb, p1_result__27_comb, p1_result__29_comb} & {6{p1_concat_8855_comb[8]}} | p0_rs1[22:17] & {6{p1_concat_8855_comb[9]}} | {p1_result__15_comb, p1_result__14_comb, p1_result__13_comb, p1_result__12_comb, p1_result__11_comb, p1_result__10_comb} & {6{p1_concat_8855_comb[10]}} | {p1_result__26_comb, p1_result__22_comb, p1_result__18_comb, p1_result__14_comb, p1_result__10_comb, p1_result__6_comb} & {6{p1_concat_8855_comb[11]}}, p1_or_8761_comb[8] & p1_concat_8866_comb[0] | p1_or_8762_comb[8] & p1_concat_8866_comb[1] | p1_or_8763_comb[8] & p1_concat_8866_comb[2] | p1_nor_8764_comb[8] & p1_concat_8866_comb[3] | p1_nand_8765_comb[8] & p1_concat_8866_comb[4] | p1_not_8766_comb[8] & p1_concat_8866_comb[5] | p1_result__17_comb & p1_concat_8866_comb[6] | p0_rs2[0] & p1_concat_8866_comb[7] | p1_result__31_comb & p1_concat_8866_comb[8] | p1_result__2_comb & p1_concat_8866_comb[9] | p1_result__9_comb & p1_concat_8866_comb[10], p1_or_8761_comb[7:1] & {7{p1_concat_8873_comb[0]}} | p1_or_8762_comb[7:1] & {7{p1_concat_8873_comb[1]}} | p1_or_8763_comb[7:1] & {7{p1_concat_8873_comb[2]}} | p1_nor_8764_comb[7:1] & {7{p1_concat_8873_comb[3]}} | p1_nand_8765_comb[7:1] & {7{p1_concat_8873_comb[4]}} | p1_not_8766_comb[7:1] & {7{p1_concat_8873_comb[5]}} | p0_rs1[7:1] & {7{p1_concat_8873_comb[6]}} | {p1_result__1_comb, p1_result__3_comb, p1_result__5_comb, p1_result__7_comb, p1_result__9_comb, p1_result__11_comb, p1_result__13_comb} & {7{p1_concat_8873_comb[7]}} | p0_rs1[31:25] & {7{p1_concat_8873_comb[8]}} | {p1_result__8_comb, p1_result__7_comb, p1_result__6_comb, p1_result__5_comb, p1_result__4_comb, p1_result__3_comb, p1_result__2_comb} & {7{p1_concat_8873_comb[9]}} | {p1_result__29_comb, p1_result__25_comb, p1_result__21_comb, p1_result__17_comb, p1_result__13_comb, p1_result__9_comb, p1_result__5_comb} & {7{p1_concat_8873_comb[10]}}, p1_or_8761_comb[0] & p1_concat_8885_comb[0] | p1_or_8762_comb[0] & p1_concat_8885_comb[1] | p1_or_8763_comb[0] & p1_concat_8885_comb[2] | p1_nor_8764_comb[0] & p1_concat_8885_comb[3] | p1_nand_8765_comb[0] & p1_concat_8885_comb[4] | p1_not_8766_comb[0] & p1_concat_8885_comb[5] | p1_result__1_comb & p1_concat_8885_comb[6] | p1_result__15_comb & p1_concat_8885_comb[7] | p1_result__18_comb & p1_concat_8885_comb[8]};

  // Registers for pipe stage 1:
  reg [31:0] p1_concat_8901;
  always_ff @ (posedge clk) begin
    p1_concat_8901 <= p1_concat_8901_comb;
  end
  assign out = p1_concat_8901;
endmodule
