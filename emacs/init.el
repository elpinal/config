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
      ("C-x M-z" . zap-to-char)
      ("M-z" . repeat)
      ("C-c c" . org-capture)
      ("C-c a" . org-agenda)
      ("C-x RET RET" . load-current-file)
      ("C-x RET ." . load-init-file)
      ("C-x y" . open-config)
      ("C-x C-y" . open-config)
    :config
      (leaf-keywords-init)))

(menu-bar-mode -1)

; For agda-mode.
(set-language-environment "English")

(setq require-final-newline t)

;; Load init file quickly.
(defun load-current-file ()
  "Load the current file."
  (interactive)
  (load-file (buffer-file-name)))

(defun load-init-file ()
  "Load user's init file."
  (interactive)
  (load-file user-init-file))

(defun open-config ()
  "Open users's init file *in the repository*."
  (interactive)
  (find-file "~/src/github.com/elpinal/config/emacs/init.el"))

(leaf org
  :bind (:org-mode-map ("M-h" . backward-kill-word))
  :config
    (setq org-todo-keywords
	  '((sequence "TODO(t)" "DOING(i)" "WAIT(w@/!)" "|" "DONE(d!)")))
    (setq org-directory "~/.org")
    (setq org-default-notes-file (concat org-directory "/capture.org"))
    (setq org-archive-location (concat org-directory "/archive.org::"))
    (setq org-agenda-files (list (concat org-directory "/capture.org"))))

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
  :init
    (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  :bind ("C-x m" . magit))

(leaf ddskk
  :ensure t)

(leaf rg
  :ensure t
  :init (rg-enable-default-bindings)
  :bind ("C-c C-s" . rg-menu))

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

(if (executable-find "opam")
    (progn
      ;; Add opam emacs directory to the load-path
      (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
      (add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
      ;; Pre-load Andromeda
      (require 'andromeda-autoloads)))
