# Conversations

The conversations/ directory contains the contents of our three design phases, with Zkbk/ and Zknh/ being the RISC-V crypto extensions implemented, and Execute/ being the top level wrapper around the extensions' implementation. Each one contains the ChatGPT-4 conversation log in Markdown format, with the shared link to the conversation at the beginning, as well as a utilized_code/ directory. This directory contains the source code that was deemed the most valuable from the conversation and was integrated into the design, as well as short unit tests for compliance testing (see below).

As the design took multiple chat sessions, the three design phases were kept decoupled, to not overflow the AI context window. ChatGPT is a tool for source code generation and refinement, which leaves the choice of which code to use up to the engineer. This led to the contents of the top_level/ directory, which contains the utilized source code concatenated in a logical order to produce a valid DSLX file.

# Top Level

The top_level/ directory contains the source code as well as the script, generate_top_level, necessary to compile the final product of the converations, masc.x, to its verilog form, execute.v. The script first converts masc.x into an IR form, optimizes that, then generates a single verilog module containing the implemented logic and a specified amount of pipeline stages. The IR files and the produced verilog are left in the directory to show the user the expected result of running the generation script.

Requirements to reproduce: environment variable $XLS be set to the bazel-bin directory of the users XLS installation, directions found at https://google.github.io/xls/

# RISC-V Compliance Tests

The riscv_compliance_test/ directory contains a cosimulation methodology to validate the AI generated DSLX code. To prove that ChatGPT-4 successfully implemented a RISC-V compliant design, it was asked to translate each unit test it wrote for each instruction to RISC-V ASM in crypto_tests.S, as seen in DSLX_to_asm.md. These ASM tests cases were then run through the Spike simulator and their traces were captured for comparison versus the DSLX tests. commit_run produces the simulator log and check_all produces the DSLX interpreter log, both of which contain the explicit name of the instruction run and the resulting values from each of their test cases. cosim then extracts these names and values and converts them into a simple cosim format, each line being: " <name of instruction> <value produced>". It then runs diff between the two *.cosim files, echoing any divergences between the expected behavior and the result.

A precompiled binary crypto_tests is already provided from the ASM source code, it may be recreated by running make.

Requirements to reproduce: modern builds of Spike, riscv-gnu-toolchain, and riscv-tests.
