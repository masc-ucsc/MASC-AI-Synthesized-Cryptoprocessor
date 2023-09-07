fn sha512sig0l(rs1: u32, rs2: u32) -> u32 {
    let shift_1 = rs1 >> u32:1;
    let shift_7 = rs1 >> u32:7;
    let shift_8 = rs1 >> u32:8;
    let rotation_31 = rs2 << u32:31;
    let rotation_25 = rs2 << u32:25;
    let rotation_24 = rs2 << u32:24;

    shift_1 ^ shift_7 ^ shift_8 ^ rotation_31 ^ rotation_25 ^ rotation_24
}


#[test]
fn test_sha512sig0l() {
    let rs1 = u32:0b00000000000000000000000000000010;
    let rs2 = u32:0b00000000000000000000000000000001;

    // Manually compute the expected result for clarity:
    let expected_result = (rs1 >> u32:1) ^ 
                          (rs1 >> u32:7) ^ 
                          (rs1 >> u32:8) ^ 
                          (rs2 << u32:31) ^ 
                          (rs2 << u32:25) ^ 
                          (rs2 << u32:24);

    assert_eq(sha512sig0l(rs1, rs2), expected_result);
    trace_fmt!(" sha512sig0l ");
    trace_fmt!(" 0x{:x}", expected_result);
}


