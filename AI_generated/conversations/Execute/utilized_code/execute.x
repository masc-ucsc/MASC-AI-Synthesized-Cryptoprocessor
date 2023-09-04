// Enumerating the instructions with explicit values
enum Instruction : u32 {
  ROR = 0,
  ROL = 1,
  RORI = 2,
  ANDN = 3,
  ORN = 4,
  XNOR = 5,
  PACK = 6,
  PACKH = 7,
  BREV8 = 8,
  REV8 = 9,
  ZIP = 10,
  UNZIP = 11,
  SHA512SUM0R = 12,
  SHA256SUM0 = 13,
  SHA512SIG0L = 14,
  SHA256SIG0 = 15,
  SHA256SUM1 = 16,
  SHA512SIG1H = 17,
  SHA512SIG0H = 18,
  SHA512SIG1L = 19,
  SHA512SUM1R = 20,
  SHA256SIG1 = 21
}

// The type for output which is a tuple (value: u32, valid: bool)
type Result = (u32, bool);

// Function to execute a given instruction
fn execute(instruction: Instruction, rs1: u32, rs2: u32) -> Result {
  match instruction {
    Instruction::ROR => (ror(rs1, rs2), true),
    Instruction::ROL => (rol(rs1, rs2), true),
    Instruction::RORI => (rori(rs1, rs2), true),
    Instruction::ANDN => (andn(rs1, rs2), true),
    Instruction::ORN => (orn(rs1, rs2), true),
    Instruction::XNOR => (xnor(rs1, rs2), true),
    Instruction::PACK => (pack(rs1, rs2), true),
    Instruction::PACKH => (packh(rs1, rs2), true),
    Instruction::BREV8 => (brev8(rs1), true),
    Instruction::REV8 => (rev8(rs1), true),
    Instruction::ZIP => (zip(rs1), true),
    Instruction::UNZIP => (unzip(rs1), true),
    Instruction::SHA512SUM0R => (sha512sum0r(rs1, rs2), true),
    Instruction::SHA256SUM0 => (sha256sum0(rs1), true),
    Instruction::SHA512SIG0L => (sha512sig0l(rs1, rs2), true),
    Instruction::SHA256SIG0 => (sha256sig0(rs1), true),
    Instruction::SHA256SUM1 => (sha256sum1(rs1), true),
    Instruction::SHA512SIG1H => (sha512sig1h(rs1, rs2), true),
    Instruction::SHA512SIG0H => (sha512sig0h(rs1, rs2), true),
    Instruction::SHA512SIG1L => (sha512sig1l(rs1, rs2), true),
    Instruction::SHA512SUM1R => (SHA512SUM1R(rs1, rs2), true),
    Instruction::SHA256SIG1 => (sha256sig1(rs1), true),
    _ => (u32:0, false)  // Default case for unknown Instruction
  }
}

