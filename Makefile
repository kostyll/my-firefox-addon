DIRS = . ./data ./lib
COFFEE_SCRIPTS = $(foreach dir,$(DIRS),$(wildcard $(dir)/*.coffee))
GEN_POPUPS := $(shell find data/ ! -name "html.py" -name "*.py")
PYTHON=python

.PHONY: all
all:
	@$(MAKE) coffee_scripts generate_popups_html

coffee_scripts:
	@echo "[*]Compile coffee scripts"
	@for coffee_script in $(COFFEE_SCRIPTS) ; do \
		coffee -p -c $$coffee_script > $(subst .coffee,.js,$$coffee_script); \
	done
	@echo "[*]Done"

generate_popups_html:
	@echo "[*]Generating HTML"
	@echo $(GEN_POPUPS)
	@for generate_script in $(GEN_POPUPS) ; do \
		$(PYTHON) $$generate_script > $(subst .py,.html,$$generate_script) ; \
	done
	@echo "[*]Done"
