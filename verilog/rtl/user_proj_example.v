// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 16
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    /* verilator lint_off UNUSED */
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    /* verilator lint_on UNUSED */
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    /* verilator lint_off UNUSED */
    input  [127:0] la_oenb,
    /* verilator lint_on UNUSED */

    // IOs
    /* verilator lint_off UNUSED */
    input  [BITS-1:0] io_in,
    /* verilator lint_on UNUSED */
    output [BITS-1:0] io_out,
    output [BITS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    // Unused
    assign wbs_ack_o = 'b0;
    assign wbs_dat_o = 'b0;
    
    assign io_out = 'b0;
    assign io_oeb = 'b0;

    assign la_data_out[127:33] = 'b0;

    assign irq = 'b0;

    wire clk;
    assign clk = wb_clk_i;


    // la_data_in[104:0] will be {valid, insn, rs2, rs1, bs}
    /* Instructions for operation:
    * 
    *  The MASC accelerator performs all of its operations in constant time,
    *  as the five pipeline stages of the accelerator
    *  act as a FIFO for operations that were submitted with a valid
    *  input signal high and with an instruction code that aligns with
    *  the following list - 
    *  
    *  ROR = 0,
    *  ROL = 1,
    *  RORI = 2,
    *  ANDN = 3,
    *  ORN = 4,
    *  XNOR = 5,
    *  PACK = 6,
    *  PACKH = 7,
    *  BREV8 = 8,
    *  REV8 = 9,
    *  ZIP = 10,
    *  UNZIP = 11,
    *  SHA512SUM0R = 12,
    *  SHA256SUM0 = 13,
    *  SHA512SIG0L = 14,
    *  SHA256SIG0 = 15,
    *  SHA256SUM1 = 16,
    *  SHA512SIG1H = 17,
    *  SHA512SIG0H = 18,
    *  SHA512SIG1L = 19,
    *  SHA512SUM1R = 20,
    *  SHA256SIG1 = 21,
    *  AES32DSI = 22,
    *  AES32DSMI = 23
    *
    * Any instruction (opcode) values besides those listed
    * will result in a zero value being produced on the "out"
    * output port of the module. If a valid operation is scheduled
    * with the "valid" input bit set, then the lower 32 bits of "out"
    * will be the result of the operation, and the MSB will be set high,
    * to indicate that the operation was valid and successful. The result
    * cannot be trusted unless the MSB of "out" is set, as that may 
    * indicate some undefined behavior coming from an initial state.
    *
    * The module is controlled purely through the Logic Analyzer signals
    * la_data_in and la_data_out, where la_data_in[104:0] will be the input
    * signals to the MASC accelerator, in order: {valid, insn, rs2, rs1, bs}
    * la_data_out[31:0] shall be the result of an operation, and la_data_out[32]
    * shall be the valid output bit, signalling if the current result came from 
    * a valid operating producedure.
    */
    __masc__execute execute(
      .clk(clk),
      .valid(la_data_in[104]),
      .instruction(la_data_in[103:72]),
      .rs1(la_data_in[39:8]),
      .rs2(la_data_in[71:40]),
      .bs(la_data_in[7:0]),
      .out(la_data_out[32:0])
    );
endmodule

`default_nettype wire
