DIRS = . ./data ./lib
COFFEE_SCRIPTS = $(basename $(foreach dir,$(DIRS),$(wildcard $(dir)/*.coffee)))
GEN_POPUPS := $(basename $(shell find data/ ! -name "html.py" -name "*.py"))
PY_EXT=.py
PYTHON=python

CHDIR_SHELL := $(SHELL)
define chdir
   $(eval _D=$(firstword $(1) $(@D)))
   $(info $(MAKE): cd $(_D)) $(eval SHELL = cd $(_D); $(CHDIR_SHELL))
endef

.PHONY: all
all:
	@$(MAKE) coffee_scripts generate_popups_html

coffee_scripts:
	@echo "[*]Compile coffee scripts"
	@for script in $(COFFEE_SCRIPTS) ; do \
		# echo $(addsuffix .coffee,$$script) ; \
		# echo $(addsuffix .js,$$script); \
		coffee -b -p -c $(addsuffix .coffee,$$script) > $(addsuffix .js,$$script); \
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

download_sdk:
	rm ~/jetpack -rf
	wget https://ftp.mozilla.org/pub/mozilla.org/labs/jetpack/jetpack-sdk-latest.tar.gz -O ~/Downloads/jetpack-sdk-latest.tar.gz
	mkdir ~/jetpack
	tar zxvf ~/Downloads/jetpack-sdk-latest.tar.gz -C ~/jetpack
	echo "bash" >> ~/jetpack/addon-sdk-1.17/bin/activate

enter:
	current_dir=$(shell pwd)
	$(call chdir,~/jetpack/addon-sdk-1.17)
	bash ./bin/activate
	@echo "Getting back"
	$(chell cd,$$current_dir)
run:
	cfx run
