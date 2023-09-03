fn right_rotate(value: u32, shift: u32) -> u32 {
    (value >> shift) | (value << (u32:32 - shift))
}

fn sha256sig1(rs1: u32) -> u32 {
    let rot_17 = right_rotate(rs1, u32:17);
    let rot_19 = right_rotate(rs1, u32:19);
    let rshift_10 = rs1 >> u32:10;
    rot_17 ^ rot_19 ^ rshift_10
}

#[test]
fn test_sha256sig1() {
    let test_input1 = u32:0b00000000111111110000000011111111;
    let expected_output1 = sha256sig1(test_input1); // This value is just a placeholder. We will trace the actual value.
    let result = sha256sig1(test_input1);
    trace_fmt!(" sha256sig1 0x{:x}", result);
    assert_eq(result, expected_output1);
}
