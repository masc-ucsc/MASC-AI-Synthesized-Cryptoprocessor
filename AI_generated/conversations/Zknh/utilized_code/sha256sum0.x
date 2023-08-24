const XLEN: u32 = u32:32;  // This constant represents the bit-length of our register.
// Rotate right function
fn ror(rs1: u32, rs2: u32) -> u32 {
  let shift_amount = rs2 & (XLEN - u32:1);  // Limit the shift amount to log2(XLEN) bits
  (rs1 >> shift_amount) | (rs1 << (XLEN - shift_amount))
}

fn sha256sum0(rs1: u32) -> u32 {
    let rot_a = ror(rs1, u32:2);
    let rot_b = ror(rs1, u32:13);
    let rot_c = ror(rs1, u32:22);
    rot_a ^ rot_b ^ rot_c
}

#[test]
fn test_sha256sum0_simple() {
    let input = u32:0b00000000000000000000000100000000;
    let expected_output = u32:0b00001000000001000000000001000000; // 28th and 17th positions set
    assert_eq(sha256sum0(input), expected_output);

    let input_2 = u32:0b00000000000000001000000000000000;
    let expected_output_2 = u32:0b00000000001000000000010000000100; // 28th and 17th positions set
    assert_eq(sha256sum0(input), expected_output);
}
