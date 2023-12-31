# Caravel RISC-V Crypto Extension


This repo contains the code for the efabless 2nd
[competition](https://efabless.com/genai/challenges/2) to fabricate a chip with
LLMs. The challenge includes RTL and testing.


## Overall goal


The project focuses on the [RISC-V
Crypto](https://github.com/riscv/riscv-crypto) extension by leveraging the
capabilities of GPT-4. The unique aspect of this project is the use of DSLX for
hardware description language, verification with cosimulation code generated by
GPT-4, and additional automatically generated verification tests.

The [folder](AI_generated) has the GPT-4 queries and how to reproduce the results.


## Objectives


The primary objective of this project is to explore the use of new HDLs like
DSLX to implement and verify the RISC-V Crypto extension. The reason for the
Crypto extension is that there are clear explanations, and it could be possible
to compare results against existing Verilog implementations in future works.


To achieve this, we employ GPT-4 to generate DSLX code that incorporates
cryptographic instruction set. DSLX is chosen over traditional hardware
description languages like Verilog due to its capability to facilitate
automatic pipelining, thereby optimizing the hardware for better performance.
For example, DSLX is able to pipeline the current design from 1 to 5 pipeline stages
and go from 7430ps to 2047ps. This is a 3.63x improvement. The
limiting factor seems to be that the programmable rotate operation consume close to
2000ps and DSLX can not repipeline without code changes.


The project also explores the feasibility and inherent challenges of using
GPT-4 for DSLX code generation. Given that GPT-4 has limited training data for
DSLX, generating accurate and efficient code becomes a non-trivial task. To
address this, we employ a verification methodology that includes cosimulation
and targeted testing. In the cosimulation process, the generated DSLX code is
run in parallel with Spike, a RISC-V emulator, to verify its functional
correctness. GPT-4 also generates sequences of valid RISC-V assembly code to
facilitate this verification. Furthermore, a wrapper implemented in GPT-4 is
used to test a subset of the cosimulation functionalities on the generated
Verilog code, ensuring its integrity and reliability.


## The Design


The product of this project is an RV32 compliant cryptographic accelerator that has full support for the Zkbk, Zknd, and Zknh extensions of the RISC-V specification, as shown in the table below. It performs all operations in constant time and is pipelined into 5 stages. The accelerator performs no RISC-V decoding and relies on its own, simpler opcodes to reduce multiplexor latency.

| Extension | Mnemonic    | Instruction                  |
|-----------|-------------|------------------------------|
| Zkbk      | ror         | Rotate right                 |
|           | rol         | Rotate left                  |
|           | rori        | Rotate right immediate       |
|           | andn        | AND with inverted operand    |
|           | orn         | OR with inverted operand     |
|           | xnor        | Exclusive NOR                |
|           | pack        | Pack low halves of registers |
|           | packh       | Pack low bytes of registers  |
|           | brev8       | Reverse bits in bytes        |
|           | rev8        | Byte-reverse register        |
|           | zip         | Zip                          |
|           | unzip       | Unzip                        |
| Zknd      | aes32dsi    | AES final round decrypt      |
|           | aes32dsmi   | AES middle round decrypt     |
| Zknh      | sha256sig0  | SHA2-256 Sigma0              |
|           | sha256sig1  | SHA2-256 Sigma1              |
|           | sha256sum0  | SHA2-256 Sum0                |
|           | sha256sum1  | SHA2-256 Sum1                |
|           | sha512sig0h | SHA2-512 Sigma0 high         |
|           | sha512sig0l | SHA2-512 Sigma0 low          |
|           | sha512sig1h | SHA2-512 Sigma1 high         |
|           | sha512sig1l | SHA2-512 Sigma1 low          |
|           | sha512sum0r | SHA2-512 Sum0                |
|           | sha512sum1r | SHA2-512 Sum1                |


## Challenges


One of the significant challenges faced in this project is the limited exposure
of GPT-4 to DSLX, which makes the task of generating accurate and efficient
code particularly daunting. The model's training data for DSLX is sparse,
leading to potential inaccuracies in the generated code that require rigorous
verification methods to mitigate. The solution is far from ideal, but it is to
showcase challenges around building new HDLs.


## Methodology


The first phase of the project involves training GPT-4 to understand and
generate DSLX code. To achieve this, we create a specific context that serves
as a training environment for the model. Given that DSLX has a Rust-like
syntax, the learning curve for GPT-4 is relatively smooth. The training aims to
equip GPT-4 with the ability to generate DSLX code that can extend the RISC-V
architecture with cryptographic functionalities. The model is fine-tuned to
understand the nuances of DSLX, including its syntax and idiomatic expressions,
to produce code that is both accurate and efficient.


The second phase focuses on verification at the DSLX level before proceeding to
Verilog generation. Testing at this stage is crucial to ensure that the
generated DSLX code meets the project's objectives and is free from errors.
This is followed by a cosimulation process where the DSLX code is run in
parallel with Spike, a RISC-V emulator. GPT-4 contributes to this verification
process by generating sequences of valid RISC-V assembly code. The cosimulation
serves as a comprehensive method to validate the functional correctness of the
generated DSLX code and its compatibility with existing RISC-V architectures.


The final phase involves Verilog testing, facilitated by a wrapper implemented
in GPT-4. This wrapper is responsible for converting the verified DSLX code
into Verilog. Additionally, it performs targeted tests on a subset of the
cosimulation functionalities. The purpose of this testing is to ensure the
integrity and reliability of the Verilog code, especially focusing on the
cryptographic extensions. This multi-tiered approach to verification—starting
from DSLX-level testing, followed by cosimulation, and finally Verilog
testing—ensures that the generated code is robust, accurate, and ready for
integration into RISC-V architectures.


## Areas that need improvement


When it comes to debugging issues identified during the cosimulation process,
the challenges are manifold. While DSLX is generally easier to debug compared
to Verilog, the complexity increases significantly when the code is
machine-generated, as is the case with our GPT-4 model. Human-written code
usually follows certain logical patterns and styles that make debugging more
intuitive. However, code generated by GPT-4 may not adhere to these human-like
patterns, making the reverse engineering process more complicated. This added
layer of complexity necessitates the development of specialized debugging tools
or methodologies that can effectively handle machine-generated DSLX code,
ensuring that any bugs or inconsistencies are promptly identified and
rectified.


The lack of native support for DSLX in GPT-4 presents another set of
challenges. The model requires multiple iterations to produce DSLX code that is
free from compile errors. Each iteration involves generating code, attempting
compilation, identifying errors, and then fine-tuning the model to correct
these errors. This iterative process is time-consuming and resource-intensive.
The issue stems from the fact that GPT-4 has not been trained on DSLX, making
it less proficient in generating error-free code in this language. This
highlights a broader issue that the research community needs to address: the
challenge of using machine learning models for code generation in languages
that are not part of their training data. Unless future iterations of GPT
models include training on newer or less popular languages like DSLX, the
utility of these models in such contexts will remain limited.


Given these challenges, it becomes evident that while machine learning models
like GPT-4 offer promising avenues for automating code generation, there are
specific hurdles to overcome, especially when dealing with less common
languages like DSLX. The debugging complexities and the lack of native language
support in the model necessitate further research and development. Solutions
could range from specialized debugging tools for machine-generated code to
expanding the training data of future GPT models to include a broader range of
programming languages.


## Conclusion

The project not only serves as a proof-of-concept for extending RISC-V
architectures using GPT-4 but also sheds light on the complexities and
challenges of working with less commonly used languages like DSLX. The
methodologies and verification techniques employed could serve as a blueprint
for similar future endeavors.


[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)


Contributors: Mark Zakharov, Farzaneh Rabiei, Jose Renau
