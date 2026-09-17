# LIB es relativo al ejercicio: no usar abspath/lastword con paths con espacios.
VERILATOR ?= verilator
BUILD_DIR ?= obj_dir
PRE_SRCS ?=
FST_FILE ?= $(BUILD_DIR)/sim.vcd

.DEFAULT_GOAL := sim
.PHONY: deps sim wave clean
deps:
	@set -e; $(foreach src,$(PRE_SRCS),cp -f "$(src)" .;) :

# Verilator genera Makefiles internos que no admiten espacios en sus rutas.
# Compilar fuentes locales en un temporal sin espacios, y ejecutar desde el
# ejercicio para conservar la traza en BUILD_DIR. El temporal siempre se borra.
sim: deps
	@set -eu; \
	build=$$(mktemp -d /tmp/taller5-sim.XXXXXX); \
	trap 'rm -rf "$$build"' EXIT HUP INT TERM; \
	$(foreach src,$(SRCS),cp "$(src)" "$$build/";) \
	cp "$(LIB)/sim_top.sv" "$(LIB)/tb_helpers.svh" "$$build/"; \
	mkdir -p "$(BUILD_DIR)"; \
	(cd "$$build" && $(VERILATOR) --binary --timing --trace -j 2 \
		-Wno-UNUSEDSIGNAL -Wno-WIDTHEXPAND -Wno-UNDRIVEN \
		--top-module sim_top -Mdir obj_dir \
		+incdir+. +define+TB_MODULE=$(TB) sim_top.sv $(notdir $(SRCS))); \
	"$$build/obj_dir/Vsim_top" "+trace_file=$(FST_FILE)"
wave: sim
	@echo "Abrir $(FST_FILE) en Surfer/VaporView"
clean:
	rm -rf "$(BUILD_DIR)"
	# Las dependencias provistas se conservan para HDL Studio.
