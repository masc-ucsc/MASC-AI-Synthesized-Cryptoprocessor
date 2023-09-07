fn sha512sig1h(rs1: u32, rs2: u32) -> u32 {
    (rs1 >> u32:3) ^ 
    (rs1 >> u32:6) ^ 
    (rs1 >> u32:19) ^ 
    (rs2 << u32:29) ^ 
    (rs2 << u32:13)
}

#[test]
fn test_sha512sig1h() {
    // Test Input
    let rs1 = u32:0b00000000000000000000000000000010; 
    let rs2 = u32:0b00000000000000000000000000000001;

    // Expected result calculation
    let expected_result = (rs1 >> u32:3) ^ 
                          (rs1 >> u32:6) ^ 
                          (rs1 >> u32:19) ^ 
                          (rs2 << u32:29) ^ 
                          (rs2 << u32:13);

    assert_eq(sha512sig1h(rs1, rs2), expected_result);
    trace_fmt!(" sha512sig1h ");
    trace_fmt!(" 0x{:x}", sha512sig1h(rs1, rs2));
}

