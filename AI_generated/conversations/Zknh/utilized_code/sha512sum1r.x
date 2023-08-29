// Utility to perform right rotation

fn ror(value: u32, shift: u32) -> u32 {

    (value >> shift) | (value << (u32:32 - shift))

}



fn SHA512SUM1R(rs1: u32, rs2: u32) -> u32 {

    // Sum1 transformations:

    let rotation_1: u32 = ror(rs1, u32:19);

    let rotation_2: u32 = ror(rs1, u32:29);  // Adjusted for 32-bit

    let shifted: u32 = rs1 >> u32:6;



    // Combining using XOR

    rotation_1 ^ rotation_2 ^ shifted

}



#[test]

fn test_SHA512SUM1R() {

    let rs1: u32 = u32:0b00000000000000000000000100000000;

    let rs2: u32 = u32:0b00000000000000000000001000000000; // This register is unused in the given description.



    let result = SHA512SUM1R(rs1, rs2);



    // Expected calculations:

    // Step 1: Right rotation of rs1 by 19 bits: u32:0b00000000001000000000000000000000

    let expected_rotation_1: u32 = u32:0b00000000001000000000000000000000;



    // Step 2: Right rotation of rs1 by 29 bits: u32:0b00000000000000000000100000000000

    let expected_rotation_2: u32 = u32:0b00000000000000000000100000000000;



    // Step 3: Shift rs1 by 6 bits to the right: u32:0b00000000000000000000000000000100

    let expected_shift: u32 = u32:0b00000000000000000000000000000100;



    let expected_result: u32 = expected_rotation_1 ^ expected_rotation_2 ^ expected_shift;



    assert_eq(result, expected_result);

}





