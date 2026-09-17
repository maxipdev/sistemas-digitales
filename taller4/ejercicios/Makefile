EXERCISES = ej2 ej4 ej5 ej6 ej7
.PHONY: sim deps clean
sim deps clean:
	@set -e; for exercise in $(EXERCISES); do $(MAKE) -C "$$exercise" $@; done
