CC=/opt/riscv32/bin/riscv32-unknown-elf-gcc -mcmodel=medany
OPT=-O -ffast=math
OPTIONS=-march=rv32imafdcv_zicsr_zifencei_zbkb_zknh_zbkc_zbkx_zknd_zkne_zksed_zksh -mabi=ilp32d
LDFLAGS=-Wall -static -g -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -T/home/mark/riscv/riscv-tests/env/p/link.ld
CFLAGS=-std=gnu99 -Iinclude $(OPT)
TOP=crypto_tests

$(TOP): $(TOP).S
	riscv64-unknown-elf-gcc $(OPTIONS) $(LDFLAGS) $< -o $@

clean:
	rm -rf $(PROGRAMS) *.out
