(setq inhibit-startup-message t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq ring-bell-function 'ignore)
(blink-cursor-mode 0)
;; (setq blink-cursor-blinks -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font 12"))

(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

(use-package dracula-theme)
(enable-theme 'dracula)

;; language support
(use-package racket-mode)

;; tree-sitter
;;(use-package tree-sitter)
;;(use-package tree-sitter-langs)
;;(require 'tree-sitter)
;;(require 'tree-sitter-hl)
;;(require 'tree-sitter-langs)
;;(require 'tree-sitter-debug)
;;(require 'tree-sitter-query)
;;(global-tree-sitter-mode)
;;(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(use-package company)
(setq company-tooltip-align-annotations t)
(global-company-mode)

;; (use-package web-mode)

;;(use-package tide)
;;(defun setup-tide-mode ()
;;  (interactive)
;;  (tide-setup)
;;  (flycheck-mode +1)
;;  (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;  (eldoc-mode +1)
;;  (tide-hl-identifier-mode +1)
;;  (company-mode +1))
;;
;;(add-hook 'typescript-mode-hook #'setup-tide-mode)
;;
;;(put 'upcase-region 'disabled nil)

;; recompile elisp
(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

(unless (package-installed-p 'dash)
  (package-install 'dash))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b54bf2fa7c33a63a009f249958312c73ec5b368b1094e18e5953adb95ad2ec3a" default))
 '(package-selected-packages '(visws tide eglot racket-mode dash use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
