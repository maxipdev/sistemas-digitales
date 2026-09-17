LIB := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
VERILATOR ?= verilator
BUILD_DIR ?= obj_dir
PRE_SRCS ?=

.PHONY: deps sim clean

# Copia a esta carpeta los .sv de ejercicios anteriores (HDL Studio no lee
# el Makefile; hace falta tenerlos acá y agregarlos al circuito).
deps:
ifneq ($(strip $(PRE_SRCS)),)
	cp -f $(PRE_SRCS) .
endif

sim: deps
	$(VERILATOR) --binary --timing -j 0 \
		--top-module sim_top \
		-Mdir $(BUILD_DIR) \
		+define+TB_MODULE=$(TB) \
		$(LIB)/oracle_tb.sv $(LIB)/sim_top.sv \
		$(SRCS)
	$(BUILD_DIR)/Vsim_top

clean:
	rm -rf $(BUILD_DIR)
ifneq ($(strip $(PRE_SRCS)),)
	rm -f $(notdir $(PRE_SRCS))
endif
