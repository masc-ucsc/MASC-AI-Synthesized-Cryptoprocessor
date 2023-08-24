import /mada.users.mzakharo.xls.test_files.harder_test.zkbk as zkbk

const XLEN = 32;

fn process_instruction(inst: zkbk::RiscVInstruction, rd: bits[XLEN], rs1: bits[XLEN], rs2: bits[XLEN]) -> bits[XLEN] {
  match inst {
    zkbk::RiscVInstruction::ror => zkbk::ror(rd, rs1, rs2),
    zkbk::RiscVInstruction::rol => zkbk::rol(rd, rs1, rs2),
    _ => {}
  }
}
