fn ror(rs1: u32, rs2: u32) -> u32 {
    let shift_amount: u32 = rs2 & u32:31;
    (rs1 >> shift_amount) | (rs1 << (u32:32 - shift_amount))
}

fn rol(rs1: u32, rs2: u32) -> u32 {
    let shamt: u32 = rs2 & u32:31;
    (rs1 << shamt) | (rs1 >> (u32:32 - shamt))
}

fn rori(rs1: u32, shamt: u32) -> u32 {
    (rs1 >> shamt) | (rs1 << (u32:32 - shamt))
}

fn andn(rs1: u32, rs2: u32) -> u32 {
    rs1 & (!rs2)
}

fn orn(rs1: u32, rs2: u32) -> u32 {
    rs1 | (!rs2)
}

fn xnor(rs1: u32, rs2: u32) -> u32 {
    !(rs1 ^ rs2)
}

fn pack(rs1: u32, rs2: u32) -> u32 {
    (rs1 & u32:0xFFFF) | ((rs2 & u32:0xFFFF) << u32:16)
}

fn packh(rs1: u32, rs2: u32) -> u32 {
    (rs1 & u32:0xFF) | ((rs2 & u32:0xFF) << u32:8)
}

fn reverse_byte(input_bits: u32) -> u32 {
    let bit0: u32 = (input_bits >> u32:0) & u32:1;
    let bit1: u32 = (input_bits >> u32:1) & u32:1;
    let bit2: u32 = (input_bits >> u32:2) & u32:1;
    let bit3: u32 = (input_bits >> u32:3) & u32:1;
    let bit4: u32 = (input_bits >> u32:4) & u32:1;
    let bit5: u32 = (input_bits >> u32:5) & u32:1;
    let bit6: u32 = (input_bits >> u32:6) & u32:1;
    let bit7: u32 = (input_bits >> u32:7) & u32:1;

    (bit0 << u32:7) | (bit1 << u32:6) | (bit2 << u32:5) | (bit3 << u32:4) |
    (bit4 << u32:3) | (bit5 << u32:2) | (bit6 << u32:1) | bit7
}

fn brev8(rs: u32) -> u32 {
    let byte0: u32 = reverse_byte(rs & u32:0xFF);
    let byte1: u32 = reverse_byte((rs >> u32:8) & u32:0xFF);
    let byte2: u32 = reverse_byte((rs >> u32:16) & u32:0xFF);
    let byte3: u32 = reverse_byte((rs >> u32:24) & u32:0xFF);

    byte0 | (byte1 << u32:8) | (byte2 << u32:16) | (byte3 << u32:24)
}

fn rev8(rs: u32) -> u32 {
    let byte0: u32 = rs & u32:0xFF;
    let byte1: u32 = (rs >> u32:8) & u32:0xFF;
    let byte2: u32 = (rs >> u32:16) & u32:0xFF;
    let byte3: u32 = (rs >> u32:24) & u32:0xFF;

    byte0 << u32:24 | byte1 << u32:16 | byte2 << u32:8 | byte3
}

fn zip(rs1: u32) -> u32 {
    let xlen_half: u32 = u32:16;
    let result: u32 = for (i, acc) : (u32, u32) in range(u32:0, xlen_half) {
        let lower_bit: u32 = (rs1 >> i) & u32:1;
        let upper_bit: u32 = (rs1 >> (i + xlen_half)) & u32:1;
        let combined_bits: u32 = (lower_bit << (u32:2 * i)) | (upper_bit << (u32:2 * i + u32:1));
        acc | combined_bits
    }(u32:0);  // initialize acc as 0 at the start
    result
}

fn unzip(rs1: u32) -> u32 {
    // Assuming we're working with 32-bit registers, so half-length is 16.
    let xlen_half: u32 = u32:16;
    // Iterate over half the length of the register and construct the result.
    let rd: u32 = for (i, acc) : (u32, u32) in range(u32:0, xlen_half) {
        // Extract even and odd bits.
        let even_bit: u32 = (rs1 >> (i * u32:2)) & u32:1;
        let odd_bit: u32 = (rs1 >> (i * u32:2 + u32:1)) & u32:1;
        // Place the even bit into the lower half and the odd bit into the upper half.
        acc + (even_bit << i) + (odd_bit << (i + xlen_half))
    }(u32:0);  // initialize acc as 0 at the start
    rd
}

#[test]
fn test_ror() {
    assert_eq(ror(u32:0b00100000000000000000000000000000, u32:1), u32:0b00010000000000000000000000000000);
    trace_fmt!(" ror ");
    trace_fmt!(" 0x{:x} ", ror(u32:0b00100000000000000000000000000000, u32:1));
}

#[test]
fn test_rol() {
    assert_eq(rol(u32:0b00100000000000000000000000000000, u32:1), u32:0b01000000000000000000000000000000);
    trace_fmt!(" rol ");
    trace_fmt!(" 0x{:x} ", rol(u32:0b00100000000000000000000000000000, u32:1));
}

#[test]
fn test_rori() {
    assert_eq(rori(u32:0b00100000000000000000000000000000, u32:1), u32:0b00010000000000000000000000000000);
}

#[test]
fn test_andn() {
    assert_eq(andn(u32:0b00000000000000000000000010101101, u32:0b00000000000000000000000011001100), u32:0b00000000000000000000000000100001);
}

#[test]
fn test_orn() {
    assert_eq(orn(u32:0b00000000000000000000000010101100, u32:0b00000000000000000000000011000101), u32:0b11111111111111111111111110111110);
}

#[test]
fn test_xnor() {
    assert_eq(xnor(u32:0b00000000000000000000000010101100, u32:0b00000000000000000000000011000101), u32:0b11111111111111111111111110010110);
}

#[test]
fn test_pack() {
    assert_eq(pack(u32:0b00000000000011110000000000001111, u32:0b11111111000000000000000011111111), u32:0b00000000111111110000000000001111);
}

#[test]
fn test_packh() {
    assert_eq(packh(u32:0b00000000000000000000000011110000, u32:0b11110000000000000000000000000000), u32:0b00000000000000000000000011110000);
}

#[test]
fn test_brev8() {
    assert_eq(brev8(u32:0b00000001000000100000001100000100), u32:0b10000000010000001100000000100000);
}

#[test]
fn test_rev8() {
    assert_eq(rev8(u32:0b00000001000000100000001100000100), u32:0b00000100000000110000001000000001);
}

#[test]
fn full_test_zip() {
    assert_eq(zip(u32:0b01010101010101011111111111111111), u32:0b01110111011101110111011101110111);
}

#[test]

fn test_unzip() {
    assert_eq(unzip(u32:0b01110111011101110111011101110111), u32:0b01010101010101011111111111111111);
    assert_eq(unzip(u32:0b11001100110011001100110011001100), u32:0b10101010101010101010101010101010);
}
