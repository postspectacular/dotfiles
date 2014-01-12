(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(unless (package-installed-p 'package+)
  (package-install 'package+))

(package-manifest
 'alpha
 'clojure-mode
 'cyberpunk-theme
 'd-mode
 'expand-region
 'fringe-helper
 'gh
 'gist
 'git-gutter
 'git-gutter-fringe
 'glsl-mode
 'graphviz-dot-mode
 'helm
 'helm-themes
 'httpcode
 'ido-hacks
 'iedit
 'isgd
 'js3-mode
 'key-chord
 'leuven-theme
 'logito
 'magit
 'markdown-mode
 'nrepl
 'nrepl-eval-sexp-fu
 'org
 'package+
 'paredit
 'pcache
 'powerline
 'projectile
 'rainbow-delimiters
 'rainbow-mode
 'scratch
 'smex
 'spaces
 'splitter
 'starter-kit
 'starter-kit-bindings
 'starter-kit-eshell
 'starter-kit-js
 'starter-kit-lisp
 'tabbar
 'toxi-theme
 'undo-tree
 'window-jump
 'yasnippet
 'zencoding-mode
 ;;'eval-sexp-fu
 ;;'smooth-scroll
 )

(require 'auth-source)

(if (file-exists-p "~/.authinfo.gpg")
    (setq auth-sources '((:source "~/.authinfo.gpg" :host t :protocol t)))
  (setq auth-sources '((:source "~/.authinfo" :host t :protocol t))))

;;(load "~/.emacs.d/.auth")

(require 'rainbow-delimiters)
(require 'alpha)
(require 'rainbow-mode)
(require 'expand-region)
(require 'projectile)
(require 'powerline)
(require 'undo-tree)
(require 'key-chord)
(require 'yasnippet)
(require 'zencoding-mode)
;;(require 'smooth-scroll)
;;(require 'eval-sexp-fu)

(when window-system
  (global-linum-mode t)
  ;;(set-frame-size (selected-frame) 238 66)
  )

(global-undo-tree-mode)
(global-auto-revert-mode t)
(projectile-global-mode)
(yas-global-mode 1)
(key-chord-mode 1)
(ido-mode 1)

(setq nrepl-popup-stacktraces t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'nrepl-interaction-mode)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(add-hook 'nrepl-repl-mode-hook 'paredit-mode)
(add-hook 'nrepl-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-hook 'before-save-hook 'time-stamp)

(add-to-list 'auto-mode-alist '("\\.cljx\\'" . clojure-mode))

(add-hook 'ttl-mode-hook 'turn-on-font-lock)
(autoload 'ttl-mode "ttl-mode" "Major mode for OWL/Turtle files" t)
(setq auto-mode-alist
      (append
       (list
        '("\\.n3" . ttl-mode)
        '("\\.ttl" . ttl-mode))
       auto-mode-alist))

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; minimal fringes
(set-fringe-mode '(1 . 1))
(set-default 'indicate-buffer-boundaries '((up . nil) (down . nil) (t . left)))
(setq next-screen-context-lines 5)
;;(savehist-mode 1)
(blink-cursor-mode 1)

;; Orgmode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(global-set-key (kbd "C-c C-v") 'eval-buffer)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is our old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(key-chord-define-global "ew" 'er/contract-region)
(key-chord-define-global "er" 'er/expand-region)
(key-chord-define-global "fg" 'forward-word)
(key-chord-define-global "fd" 'backward-word)
(key-chord-define-global "ft" 'esk-cleanup-buffer)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; type over selection
(delete-selection-mode 1)

;; no more accidental minimising
(global-unset-key "\C-z")

(defun dupe-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(defun shift-line-down ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (kill-line)
  (next-line 1)
  (open-line 1)
  (yank 2))

(defun shift-line-up ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (kill-line)
  (previous-line 1)
  (open-line 1)
  (yank 2))

;;(global-set-key (kbd "<C-s-down>") 'dupe-line)
;;(global-set-key (kbd "<C-M-down>") 'shift-line-down)
;;(global-set-key (kbd "<C-M-up>") 'shift-line-up)

;;(setq smooth-scroll/vscroll-step-size 2)
;;(smooth-scroll-mode nil)

(powerline-default-theme)
(load-theme 'leuven t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("41c8deb49dea6ee40db394acda39f5ebc649c13559534c9faaebcb320d044aef" "1c1e6b2640daffcd23b1f7dd5385ca8484a060aec901b677d0ec0cf2927f7cde" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
