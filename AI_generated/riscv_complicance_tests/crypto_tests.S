/* Test for various RISC-V crypto extensions
 */
	.file "crypto_tests.c"
	.option nopic
	.section .text.startup, "ax",@progbits
	.globl _start
	.type _start, @function

_start:
	li	a1, 1<<13
	csrr	a0, mstatus
	or	a0, a0, a1
	csrw	mstatus, a0

	// setup traphandler
	la	t0, trap_vector_1
	csrw	mtvec, t0


# test_ror
li x1, 0b00100000000000000000000000000000
li x2, 0b1
ror x3, x1, x2

# test_rol
li x1, 0b00100000000000000000000000000000
li x2, 0b1
rol x3, x1, x2

# test_rori
li x1, 0b00100000000000000000000000000000
rori x3, x1, 1

# test_andn
li x1, 0b00000000000000000000000010101101
li x2, 0b00000000000000000000000011001100
andn x3, x1, x2

# test_orn
li x1, 0b00000000000000000000000010101100
li x2, 0b00000000000000000000000011000101
orn x3, x1, x2

# test_xnor
li x1, 0b00000000000000000000000010101100
li x2, 0b00000000000000000000000011000101
xnor x3, x1, x2

# test_pack
li x1, 0b00000000000011110000000000001111
li x2, 0b11111111000000000000000011111111
pack x3, x1, x2

# test_packh
li x1, 0b00000000000000000000000011110000
li x2, 0b11110000000000000000000000000000
packh x3, x1, x2

# test_brev8
li x1, 0b00000001000000100000001100000100
brev8 x3, x1

# test_rev8
li x1, 0b00000001000000100000001100000100
rev8 x3, x1

# test_zip
li x1, 0b01010101010101011111111111111111
zip x3, x1

# test_unzip
li x1, 0b01110111011101110111011101110111
unzip x3, x1

li x1, 0b11001100110011001100110011001100
unzip x4, x1

li x1, 0xabcdef12    // Load input into x1
sha256sig0 x3, x1    // Perform sha256sig0 operation and store result in x3

li x1, 0b00000000111111110000000011111111  // Load input into x1
sha256sig1 x3, x1                          // Perform sha256sig1 operation and store result in x3

li x1, 0b00000000000000000000000100000000  // Load input into x1
sha256sum0 x3, x1                          // Perform sha256sum0 operation and store result in x3

li x1, 0b00000000000000000000000100000000  // Load first input into x1
sha256sum1 x3, x1                          // Perform sha256sum1 operation and store result in x3

li x1, 0b00000000000000000000001000000000  // Load second input into x1
sha256sum1 x3, x1                          // Perform sha256sum1 operation and store result in x3

# Test for sha512sig0h

# Test case 1
li x1, 0    # Loading 0 into x1 (rs1)
li x2, 0    # Loading 0 into x2 (rs2)
sha512sig0h x3, x1, x2

# Test case 2
li x1, 0b00000001    # Load binary value into x1
li x2, 0             # Loading 0 into x2
sha512sig0h x3, x1, x2

# Test case 3
li x1, 0              # Loading 0 into x1
li x2, 0b00000001     # Load binary value into x2
sha512sig0h x3, x1, x2

# Test case 4
li x1, 0b10101010010101011010101001010101 # Load binary value into x1
li x2, 0b01010101101010100101010110101010 # Load binary value into x2
sha512sig0h x3, x1, x2

# Test for sha512sig0l_simple
li x1, 0b00000000000000000000000000000010 # Load binary value into x1
li x2, 0b00000000000000000000000000000001 # Load binary value into x2
sha512sig0l x3, x1, x2

# Test for sha512sig1h
li x1, 0b00000000000000000000000000000010 # Load binary value into x1
li x2, 0b00000000000000000000000000000001 # Load binary value into x2
sha512sig1h x3, x1, x2



li x1, 0b00000000000000000000000000000010  // Load first input into x1
li x2, 0b00000000000000000000000000000001  // Load second input into x2
sha512sig1l x3, x1, x2                     // Perform sha512sig1l operation and store result in x3


li x1, 0b00000000000000000000000000000100  // Load first input into x1
li x2, 0b00000000000000000000000000000010  // Load second input into x2
aes32esi x3, x1, x2, 0                     // Perform sha512sig1l operation and store result in x3


li x1, 0b00000000000000000000000000000100  // Load first input into x1
li x2, 0b00000000000000000000000000000010  // Load second input into x2
aes32esmi x3, x1, x2, 1                     // Perform sha512sig1l operation and store result in x3

li x1, 0b00000000000000000000000000000100  // Load first input into x1
li x2, 0b00000000000000000000000000000010  // Load second input into x2
aes32dsi x3, x1, x2, 1                     // Perform sha512sig1l operation and store result in x3

li x1, 0b00000000000000000000000000000100  // Load first input into x1
li x2, 0b00000000000000000000000000000010  // Load second input into x2
aes32dsmi x3, x1, x2, 1                     // Perform sha512sig1l operation and store result in x3


_success:
	// program exits as expected
	la	t0, tohost
	li	t1, 0x01
	sh	t1, 0(t0)
	j	sit_and_spin

_failure:
	// some unexcepted result was reached
	la	t0, tohost
	li	t1, 0x03
	sh	t1, 0(t0)

sit_and_spin:
	j	sit_and_spin

	.align 4
trap_vector_1:
	// catches exception
	csrr	t0, mcause
	csrr	t0, mtval
	csrr	t0, mepc
	la	t0, _failure	//failure
	csrw	mepc, t0
	mret

	// defines tohost, fromhost
	// these are success/failure exit vars
 .size   _start, .-_start

	.section ".tohost","aw",@progbits
	.align 6
	.globl tohost
	tohost: .dword 0
	.align 6
	.globl fromhost
	fromhost: .dword 0
