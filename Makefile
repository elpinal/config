PREFIX=$(HOME)

install:
	cp vim/.vimrc $(PREFIX)/.vimrc

	touch $(PREFIX)/.emacs.d/custom.el
	cp emacs/init.el $(PREFIX)/.emacs.d/init.el

.PHONY: install
