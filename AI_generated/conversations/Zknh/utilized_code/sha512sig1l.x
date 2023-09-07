fn sha512sig1l(rs1: u32, rs2: u32) -> u32 {
    let rs1_shift_3 = rs1 >> u32:3;
    let rs1_shift_6 = rs1 >> u32:6;
    let rs1_shift_19 = rs1 >> u32:19;

    let rs2_shift_left_29 = rs2 << u32:29;
    let rs2_shift_left_26 = rs2 << u32:26;
    let rs2_shift_left_13 = rs2 << u32:13;

    let result = rs1_shift_3 ^ rs1_shift_6 ^ rs1_shift_19 ^ rs2_shift_left_29 ^ rs2_shift_left_26 ^ rs2_shift_left_13;

    result
}


#[test]
fn test_sha512sig1l() {
    // Test Input
    let rs1 = u32:0b00000000000000000000000000000010;
    let rs2 = u32:0b00000000000000000000000000000001;

    // Calculating expected result using individual shifts and XOR operations
    let expected_result = (rs1 >> u32:3) ^ 
                          (rs1 >> u32:6) ^ 
                          (rs1 >> u32:19) ^ 
                          (rs2 << u32:29) ^ 
                          (rs2 << u32:26) ^ 
                          (rs2 << u32:13);

    // Check if the function's output matches the expected result
    assert_eq(sha512sig1l(rs1, rs2), expected_result);
    trace_fmt!(" sha512sig1l ");
    trace_fmt!(" 0x{:x}", sha512sig1l(rs1, rs2));
}

