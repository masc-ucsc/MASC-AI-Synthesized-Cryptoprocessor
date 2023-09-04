const XLEN: u32 = u32:32;



fn ror(x: u32, n: u32) -> u32 {

    (x >> n) | (x << (u32:32 - n))

}



fn sha512sum0r(rs1: u32, rs2: u32) -> u32 {   

    // Adjust rotation values based on XLEN

    let rotation_val_2: u32 = if XLEN == u32:64 { u32:34 } else { u32:2 };

    let rotation_val_3: u32 = if XLEN == u32:64 { u32:39 } else { u32:7 };

    

    // Performing the Sum0 operations on the 64-bit input using the ror function

    let rotation_1: u32 = ror(rs1, u32:28);

    let rotation_2: u32 = ror(rs1, rotation_val_2);

    let rotation_3: u32 = ror(rs1, rotation_val_3);

    

    // Combining results using XOR

    let result: u32 = rotation_1 ^ rotation_2 ^ rotation_3;

    

    result

}



#[test]

fn test_sha512sum0r() {

    // Sample input values

    let rs1: u32 = u32:0b00000000000000000000000100000000;

    let rs2: u32 = u32:0b00000000000000000000001000000000;



    // Running the function with the sample input

    let result: u32 = sha512sum0r(rs1, rs2);



    // Expected transformations based on given operations:

    let expected_rotation_1 = u32:0b00000000000000000001000000000000;

    let expected_rotation_2 = u32:0b00000000000000000000000001000000;

    let expected_rotation_3 = u32:0b00000000000000000000000000000010;

    let expected: u32 = expected_rotation_1 ^ expected_rotation_2 ^ expected_rotation_3;



    // Check if result matches expected value

    assert_eq(result, expected);
    trace_fmt!(" sha512sum0r ");
    trace_fmt!(" 0x{:x}", result);
}





