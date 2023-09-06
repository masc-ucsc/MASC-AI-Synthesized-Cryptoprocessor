fn sha512sig0l(rs1: u32, rs2: u32) -> u32 {
    let result = 
        (rs1 >> 1) ^ 
        (rs1 >> 7) ^ 
        (rs1 >> 8) ^ 
        (rs2 << 31) ^ 
        (rs2 << 25) ^ 
        (rs2 << 24);
    result
}

#[test]
fn test_sha512sig0l_simple() {
  let rs1 = u32:0b00000000000000000000000000000010;
  let rs2 = u32:0b00000000000000000000000000000001;
  let result = sha512sig0l(rs1, rs2);
  assert_eq(result, u32:0b10000011000000000000000000000001);
  trace_fmt!(" sha512sig0l ");
  trace_fmt!(" 0x{:x}", result);
}
