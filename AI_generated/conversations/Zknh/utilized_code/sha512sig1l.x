// Rotate right function
fn ror(rs1: u32, rs2: u32) -> u32 {
  let shift_amount: u32 = rs2 & u32:31;  // Limit the shift amount to log2(32) bits which is 5 bits or '31' in binary.
  (rs1 >> shift_amount) | (rs1 << (u32:32 - shift_amount))
}

// sha512sig1l function
fn sha512sig1l(rs1: u32, rs2: u32) -> u32 {
  // Specific rotations and shifts for Sigma1
  let rotation_1: u32 = ror(rs1, u32:16);
  let rotation_2: u32 = ror(rs2, u32:6);
  let shift_1: u32 = rs1 >> u32:23;
  // XOR them all together for the final result
  let result: u32 = rotation_1 ^ rotation_2 ^ shift_1;
  // Return the result
  result
}

#[test]
fn test_sha512sig1l() {
    let rs1 = u32:0b00000000000000000000000100000000; 
    let rs2 = u32:0b00000000000000000000001000000000; 
    // Expected operations on rs1 and rs2 based on the given `sha512sig1l` function
    // Step 1: Right rotation of rs1 by 16 bits: 0b00000001000000000000000000000000
    // Step 2: Right rotation of rs2 by 6 bits:  0b00000000000000000000000000001000
    // Step 3: Shift right of rs1 by 23 bits:    0b00000000000000000000000000000000
    // XOR all the results together
    // Result: 0b00000001000000000000000000000010
    let result = sha512sig1l(rs1, rs2);
    let expected: u32 = u32:0b00000001000000000000000000001000;
    assert_eq(result, expected);
    trace_fmt!(" sha512sig1l ");
    trace_fmt!(" 0x{:x}", result);
}
