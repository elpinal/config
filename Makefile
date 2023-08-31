XDG_CONFIG_HOME=$(HOME)/.config

install:
	cp vim/.vimrc $(HOME)/.vimrc
	mkdir -p $(HOME)/.vim
	cp vim/coc-settings.json $(HOME)/.vim/coc-settings.json
	mkdir -p $(HOME)/.vim/snippets
	cp vim/snippets/* $(HOME)/.vim/snippets/
	./vim/setup_plugins.sh

	touch $(HOME)/.emacs.d/custom.el
	cp emacs/init.el $(HOME)/.emacs.d/init.el

	cp git/ignore $(XDG_CONFIG_HOME)/git/ignore

.PHONY: install
