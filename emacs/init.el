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
      ("C-t" . set-input-method)
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
      ("M-e" . scroll-up-n)
      ("M-y" . scroll-down-n)
    :config
      (leaf-keywords-init)))

(menu-bar-mode -1)

; For agda-mode.
(set-language-environment "English")

(setq require-final-newline t)
(setq confirm-kill-emacs 'y-or-n-p)
(setq default-input-method 'japanese-skk)

(setq auto-mode-alist (cons '("\\.lagda.md$" . agda2-mode) auto-mode-alist))

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

(defun scroll-up-n (n)
  "Scroll up N lines."
  (interactive "p")
  (scroll-up n))

(defun scroll-down-n (n)
  "Scroll down N lines."
  (interactive "p")
  (scroll-down n))

(leaf org
  :bind (:org-mode-map ("M-h" . backward-kill-word))
  :config
    (setq org-todo-keywords
	  '((sequence "TODO(t)" "DOING(i)" "WAIT(w@/!)" "|" "DONE(d!)")))
    (setq org-directory "~/.org")
    (setq org-default-notes-file (concat org-directory "/capture.org"))
    (setq org-archive-location (concat org-directory "/archive.org::"))
    (setq org-agenda-files (list (concat org-directory "/capture.org")))
    (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file))

(leaf org-roam
  :ensure t
  :init (org-roam-db-autosync-mode)
  :config
    (setq org-roam-directory "~/.org"))

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

(leaf counsel
  :ensure t
  :init
    (ivy-mode 1))

(leaf ddskk
  :ensure t
  :config
    (setq skk-large-jisyo "~/.skk/SKK-JISYO.L"))

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
