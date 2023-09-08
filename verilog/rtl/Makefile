SIM=verilator
VSIM_OPTS += -sv --timing --trace-fst -timescale-override 1ns/1ps
VSIM_EXE := verilator-tb
VSIM_LOG := verilator.log
VSIM_WAV := verilator.fst
TOP_MODULE=__masc__execute
SYNTH_SOURCES += $(TOP_MODULE).v

$(VSIM_EXE): testbench.sv $(SYNTH_SOURCES)
	$(SIM) -o $(VSIM_EXE) $(VSIM_OPTS) --binary --top-module testbench testbench.sv $(SYNTH_SOURCES)

lint:
	$(SIM) --lint-only -top $(TOP_MODULE) $(TOP_MODULE).v $(SYNTH_SOURCES) -I $(VSIM_OPTS) -Wall 
