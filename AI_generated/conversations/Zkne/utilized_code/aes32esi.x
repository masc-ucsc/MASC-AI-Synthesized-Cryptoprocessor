fn aes32esi(rs1: u32, rs2: u32, bs: u8) -> u32 {
    let bs_32 = bs as u32;
    let shamt = bs_32 * u32:8;
    let extracted_byte = (rs2 >> shamt) as u8;
    
    // Mock AES SBox operation (bitwise inversion)
    let substituted_byte = extracted_byte ^ u8:0xFF;

    let substituted_word = substituted_byte as u32;
    let merged_word = substituted_word << shamt;

    rs1 ^ merged_word
}

#[test]
fn aes32esi_test() {
    // Test Input
    let rs1 = u32:0x00000000; 
    let rs2 = u32:0x00000000;  // Changed value for demonstration
    let bs = u8:0; // Select the first byte (least significant byte) from rs2

    // Expected Output (using the mock transformation: byte -> byte ^ 0xFF)
    let extracted_byte = (rs2 & u32:0xFF) as u8; // Extract least significant byte
    let expected_sbox_byte = extracted_byte ^ u8:0xFF;  
    let merged_expected_byte = (expected_sbox_byte as u32) << (bs as u32 * u32:8);
    let expected_result = rs1 ^ merged_expected_byte;

    // Actual Output
    let result = aes32esi(rs1, rs2, bs);

    // Assert
    assert_eq(expected_result, result);
    trace_fmt!(" aes32esi ");
    trace_fmt!(" 0x{:x}", aes32esi(rs1, rs2, bs));
}

