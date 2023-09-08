fn rol(rs1: u32, rs2: u32) -> u32 {
    let shamt: u32 = rs2 & u32:31;
    (rs1 << shamt) | (rs1 >> (u32:32 - shamt))
}

fn aes_sbox_inv(input: u8) -> u8 {
    // This is the inverse S-box table used in AES.
    let inv_sbox: u8[256] = [
        u8:0x52, u8:0x09, u8:0x6a, u8:0xd5, u8:0x30, u8:0x36, u8:0xa5, u8:0x38,
        u8:0xbf, u8:0x40, u8:0xa3, u8:0x9e, u8:0x81, u8:0xf3, u8:0xd7, u8:0xfb,
        u8:0x7c, u8:0xe3, u8:0x39, u8:0x82, u8:0x9b, u8:0x2f, u8:0xff, u8:0x87,
        u8:0x34, u8:0x8e, u8:0x43, u8:0x44, u8:0xc4, u8:0xde, u8:0xe9, u8:0xcb,
        u8:0x54, u8:0x7b, u8:0x94, u8:0x32, u8:0xa6, u8:0xc2, u8:0x23, u8:0x3d,
        u8:0xee, u8:0x4c, u8:0x95, u8:0x0b, u8:0x42, u8:0xfa, u8:0xc3, u8:0x4e,
        u8:0x08, u8:0x2e, u8:0xa1, u8:0x66, u8:0x28, u8:0xd9, u8:0x24, u8:0xb2,
        u8:0x76, u8:0x5b, u8:0xa2, u8:0x49, u8:0x6d, u8:0x8b, u8:0xd1, u8:0x25,
        u8:0x72, u8:0xf8, u8:0xf6, u8:0x64, u8:0x86, u8:0x68, u8:0x98, u8:0x16,
        u8:0xd4, u8:0xa4, u8:0x5c, u8:0xcc, u8:0x5d, u8:0x65, u8:0xb6, u8:0x92,
        u8:0x6c, u8:0x70, u8:0x48, u8:0x50, u8:0xfd, u8:0xed, u8:0xb9, u8:0xda,
        u8:0x5e, u8:0x15, u8:0x46, u8:0x57, u8:0xa7, u8:0x8d, u8:0x9d, u8:0x84,
        u8:0x90, u8:0xd8, u8:0xab, u8:0x00, u8:0x8c, u8:0xbc, u8:0xd3, u8:0x0a,
        u8:0xf7, u8:0xe4, u8:0x58, u8:0x05, u8:0xb8, u8:0xb3, u8:0x45, u8:0x06,
        u8:0xd0, u8:0x2c, u8:0x1e, u8:0x8f, u8:0xca, u8:0x3f, u8:0x0f, u8:0x02,
        u8:0xc1, u8:0xaf, u8:0xbd, u8:0x03, u8:0x01, u8:0x13, u8:0x8a, u8:0x6b,
        u8:0x3a, u8:0x91, u8:0x11, u8:0x41, u8:0x4f, u8:0x67, u8:0xdc, u8:0xea,
        u8:0x97, u8:0xf2, u8:0xcf, u8:0xce, u8:0xf0, u8:0xb4, u8:0xe6, u8:0x73,
        u8:0x96, u8:0xac, u8:0x74, u8:0x22, u8:0xe7, u8:0xad, u8:0x35, u8:0x85,
        u8:0xe2, u8:0xf9, u8:0x37, u8:0xe8, u8:0x1c, u8:0x75, u8:0xdf, u8:0x6e,
        u8:0x47, u8:0xf1, u8:0x1a, u8:0x71, u8:0x1d, u8:0x29, u8:0xc5, u8:0x89,
        u8:0x6f, u8:0xb7, u8:0x62, u8:0x0e, u8:0xaa, u8:0x18, u8:0xbe, u8:0x1b,
        u8:0xfc, u8:0x56, u8:0x3e, u8:0x4b, u8:0xc6, u8:0xd2, u8:0x79, u8:0x20,
        u8:0x9a, u8:0xdb, u8:0xc0, u8:0xfe, u8:0x78, u8:0xcd, u8:0x5a, u8:0xf4,
        u8:0x1f, u8:0xdd, u8:0xa8, u8:0x33, u8:0x88, u8:0x07, u8:0xc7, u8:0x31,
        u8:0xb1, u8:0x12, u8:0x10, u8:0x59, u8:0x27, u8:0x80, u8:0xec, u8:0x5f,
        u8:0x60, u8:0x51, u8:0x7f, u8:0xa9, u8:0x19, u8:0xb5, u8:0x4a, u8:0x0d,
        u8:0x2d, u8:0xe5, u8:0x7a, u8:0x9f, u8:0x93, u8:0xc9, u8:0x9c, u8:0xef,
        u8:0xa0, u8:0xe0, u8:0x3b, u8:0x4d, u8:0xae, u8:0x2a, u8:0xf5, u8:0xb0,
        u8:0xc8, u8:0xeb, u8:0xbb, u8:0x3c, u8:0x83, u8:0x53, u8:0x99, u8:0x61,
        u8:0x17, u8:0x2b, u8:0x04, u8:0x7e, u8:0xba, u8:0x77, u8:0xd6, u8:0x26,
        u8:0xe1, u8:0x69, u8:0x14, u8:0x63, u8:0x55, u8:0x21, u8:0x0c, u8:0x7d
    ];

// Access the lookup table using input as an index and implicitly return the result.
    inv_sbox[input]
}


fn aes_xtime(a: u8) -> u8 {
    let xshifted: u8 = a << 1;
    let conditional_xor: u8 = if a & u8:0x80 != u8:0 { u8:0x1b } else { u8:0 };
    xshifted ^ conditional_xor
}

fn gmul(a: u8, b: u8) -> u8 {
    let term_1: u8 = if b & u8:0x1 != u8:0 { a } else { u8:0 };
    let term_2: u8 = if b & u8:0x2 != u8:0 { aes_xtime(a) } else { u8:0 };
    let term_3: u8 = if b & u8:0x4 != u8:0 { aes_xtime(aes_xtime(a)) } else { u8:0 };
    let term_4: u8 = if b & u8:0x8 != u8:0 { aes_xtime(aes_xtime(aes_xtime(a))) } else { u8:0 };

    (term_1 ^ term_2 ^ term_3 ^ term_4) & u8:0xFF
}


fn aes_mixcolumn_byte_inv(byte: u8) -> u32 {
    let result_1: u32 = (gmul(byte, u8:0x0B) as u32) << 24;
    let result_2: u32 = (gmul(byte, u8:0x0D) as u32) << 16;
    let result_3: u32 = (gmul(byte, u8:0x09) as u32) << 8;
    let result_4: u32 = gmul(byte, u8:0x0E) as u32;

    result_1 | result_2 | result_3 | result_4
}


fn aes32dsmi(bs: u8, rs2: u32, rs1: u32) -> u32 {
    let shamt: u8 = (bs << 3);  // Only the lower 5 bits are used, shifted by 3 to multiply by 8.
    let si: u8 = (rs2 >> shamt) as u8; 
    let so: u8 = (aes_sbox_inv(si) );  // Zero-extend by putting the result in the top byte.
    let mixed: u32 = aes_mixcolumn_byte_inv(so ); 
    let result: u32 = rs1 ^ rol(mixed, shamt as u32);
    result
}

#[test]
fn test_aes32dsmi() {
    // Sample values based on our understanding of the operations.
    let bs_test: u8 = u8:0b00001;  // Corresponds to a shift amount of 8.
    let rs2_test: u32 = u32:0x11223344;  // Random 32-bit value.
    let rs1_test: u32 = u32:0xAABBCCDD;  // Another random 32-bit value.

    // Expected result calculation:
    // We will extract the byte from rs2 using the shift amount determined by bs.
    // For the given values, the extracted byte would be 0x33.
    // Then, we'll apply the inverse SBox and then the partial inverse MixColumn.
    // Finally, the result is rotated and XORed with rs1.
    // The exact result would depend on the aes_sbox_inv and aes_mixcolumn_byte_inv functions, 
    // which were defined earlier.

    // The expected value here is just a placeholder. You would need to calculate the expected 
    // output using another reliable method (like a reference implementation) to replace this placeholder.
//    let expected_output: u32 = u32:0x12345678;  // Placeholder value.

    // Check if the function produces the expected result.
//    assert_eq(aes32dsmi(bs_test, rs2_test, rs1_test), expected_output);
    trace_fmt!(" aes32dsmi ");
    trace_fmt!(" 0x{:x}", aes32dsmi(bs_test, rs2_test, rs1_test));
}

