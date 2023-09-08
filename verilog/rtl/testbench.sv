module testbench;

    reg clk;
    reg [31:0] instruction;
    reg [31:0] rs1, rs2;
    reg [7:0] bs;
    reg [0:0] valid;
    wire [32:0] out;

    // Instantiate the module to be tested
    __masc__execute uut (
        .clk(clk),
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .bs(bs),
        .valid(valid),
        .out(out)
    );

    initial begin
        // Initialize signals
        clk = 0;
        instruction = 0;
        rs1 = 1;
        rs2 = 1;
        bs  = 0;
        valid = 1;

        // Wait 10ns for setup
        #10;

        // Apply test vectors
        for (instruction = 0; instruction < 32; instruction = instruction + 1) begin
            #10;  // Each cycle lasts 20ns, hence wait for half of it
            clk = 1; // Rising edge
            #10;
            clk = 0; // Falling edge

            // Print the out value
            $display("Instruction: %d, Out value: 0x%X, valid value: 0x%X", instruction, out[31:0], out[32]);
        end

        // Finish simulation after tests
        $finish;
    end

    // Clock generation
    always #10 clk = ~clk;

endmodule

