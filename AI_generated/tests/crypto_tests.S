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

	// will this work?
	ror t1, t1, t1
	sha256sig0 t1, t1
	clmul t1, t1, t1
	xperm8 t1, t1, t1
#	aes64ds t1, t1, t1
#	aes64es  t1, t1, t1
	sm4ed	 t1, t1, t1, 1

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
