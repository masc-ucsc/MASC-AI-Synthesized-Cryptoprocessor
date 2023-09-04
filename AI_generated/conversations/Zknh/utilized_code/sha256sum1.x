// Assuming a 32-bit architecture
const XLEN: u32 = u32:32;
// Rotate right function
fn ror(rs1: u32, rs2: u32) -> u32 {
  let shift_amount = rs2 & (XLEN - u32:1);  // Limit the shift amount to log2(XLEN) bits
  (rs1 >> shift_amount) | (rs1 << (XLEN - shift_amount))
}
// sha256sum1 function
fn sha256sum1(rs1: u32) -> u32 {
  let rotation_1 = ror(rs1, u32:6);
  let rotation_2 = ror(rs1, u32:11);
  let rotation_3 = ror(rs1, u32:25);
  rotation_1 ^ rotation_2 ^ rotation_3
}

#[test]
fn test_sha256sum1_simple() {
  let input = u32:0b00000000000000000000000100000000;
  assert_eq(sha256sum1(input), u32:0b00100000000000001000000000000100);
  trace_fmt!(" sha256sum1 ");
  trace_fmt!(" 0x{:x}", sha256sum1(input));
  let input_2 = u32:0b00000000000000000000001000000000;
  assert_eq(sha256sum1(input_2), u32:0b01000000000000010000000000001000);
  trace_fmt!(" sha256sum1 ");
  trace_fmt!(" 0x{:x}", sha256sum1(input_2));
}
