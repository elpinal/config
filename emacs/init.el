(setq debug-on-error t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :bind
      ("C-h" . delete-backward-char)
      ("M-?" . help-for-help)
      ("C-z" . help-for-help)
      ("C-x M-q" . quoted-insert)
      ("C-q" . move-beginning-of-line)
      ("M-h" . backward-kill-word)
      ("<left>" . windmove-left)
      ("<down>" . windmove-down)
      ("<up>" . windmove-up)
      ("<right>" . windmove-right)
      ("M-c" . delete-window)
      ("C-x !". shell)
    :config
      (leaf-keywords-init)))

(menu-bar-mode -1)

; For agda-mode.
(set-language-environment "English")

(setq require-final-newline t)

(leaf undo-tree
  :ensure t
  :bind ("M-r" . undo-tree-redo)
  :init (global-undo-tree-mode))

(leaf smartparens
  :ensure t
  :init (smartparens-global-mode t))

(leaf racket-mode
  :ensure t)

(leaf clojure-mode
  :ensure t
  :config
    (add-hook 'clojure-mode-hook #'smartparens-strict-mode))

(leaf cider
  :ensure t)

(leaf sml-mode
  :ensure t)

(leaf web-mode
  :ensure t)

(leaf magit
  :ensure t
  :bind ("C-x m" . magit))

(leaf ddskk
  :ensure t)

(leaf dracula-theme
  :ensure t
  :init
    (load-theme 'dracula t)
    (enable-theme 'dracula))

(leaf exec-path-from-shell
  :ensure t
  :init
    (exec-path-from-shell-initialize))

(if (executable-find "agda-mode")
  (load-file (let ((coding-system-for-read 'utf-8))
                  (shell-command-to-string "agda-mode locate"))))
