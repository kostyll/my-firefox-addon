DIRS = . ./data ./lib
COFFEE_SCRIPTS = $(basename $(foreach dir,$(DIRS),$(wildcard $(dir)/*.coffee)))
GEN_POPUPS := $(basename $(shell find data/ ! -name "html.py" -name "*.py"))
PY_EXT=.py
PYTHON=python

.PHONY: all
all:
	@$(MAKE) coffee_scripts generate_popups_html

coffee_scripts:
	@echo "[*]Compile coffee scripts"
	@for script in $(COFFEE_SCRIPTS) ; do \
		# echo $(addsuffix .coffee,$$script) ; \
		# echo $(addsuffix .js,$$script); \
		coffee -p -c $(addsuffix .coffee,$$script) > $(addsuffix .js,$$script); \
	done
	@echo "[*]Done"

generate_popups_html:
	@echo "[*]Generating HTML"
	@for generate_script in $(GEN_POPUPS) ; do \
		# echo $(addsuffix .py, $$generate_script) ; \
		# echo $(addsuffix .html,$$generate_script) ; \
 		$(PYTHON) $(addsuffix .py, $$generate_script) > $(addsuffix .html,$$generate_script) ; \
	done
	@echo "[*]Done"
