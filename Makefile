XDG_CONFIG_HOME=$(HOME)/.config

install:
	cp vim/.vimrc $(HOME)/.vimrc
	./vim/setup_plugins.sh

	touch $(HOME)/.emacs.d/custom.el
	cp emacs/init.el $(HOME)/.emacs.d/init.el

	cp git/ignore $(XDG_CONFIG_HOME)/git/ignore

.PHONY: install
