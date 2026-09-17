LIB := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
VERILATOR ?= verilator
BUILD_DIR ?= obj_dir
PRE_SRCS ?=
SURFER ?= surfer
FST_FILE ?= $(BUILD_DIR)/sim.vcd

.PHONY: deps sim wave clean

# Copia a esta carpeta los .sv de ejercicios anteriores (HDL Studio no lee
# el Makefile; hace falta tenerlos acá y agregarlos al circuito).
deps:
ifneq ($(strip $(PRE_SRCS)),)
	cp -f $(PRE_SRCS) .
endif

sim: deps
	$(VERILATOR) --binary --timing --trace -j 0 \
		-Wno-WIDTHEXPAND -Wno-UNDRIVEN -Wno-UNUSEDPARAM \
		--top-module sim_top \
		-Mdir $(BUILD_DIR) \
		+incdir+$(LIB) \
		+define+TB_MODULE=$(TB) \
		$(LIB)/sim_top.sv \
		$(SRCS)
	$(BUILD_DIR)/Vsim_top

wave: sim
	@f="$(abspath $(FST_FILE))"; \
	if command -v cursor >/dev/null 2>&1 && cursor --reuse-window "$$f"; then \
		echo "wave → $$f (editor)"; \
	elif command -v code >/dev/null 2>&1 && code --reuse-window "$$f"; then \
		echo "wave → $$f (editor)"; \
	else \
		case "$$DISPLAY" in \
			*:*) WAYLAND_DISPLAY= WINIT_UNIX_BACKEND=x11 $(SURFER) "$$f" & \
			     echo "wave → Surfer (X11) $$f" ;; \
			*) echo "X11 no disponible. Abrí $$f en VaporView/Surfer (click en el archivo)." ;; \
		esac; \
	fi

clean:
	rm -rf $(BUILD_DIR) $(FST_FILE)
ifneq ($(strip $(PRE_SRCS)),)
	rm -f $(notdir $(PRE_SRCS))
endif
