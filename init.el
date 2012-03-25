;; Currently a big mess, copied from all over the world.

(add-to-list 'load-path "~/.emacs.d/vendor")
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/") 
                           ("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")))
(require 'package)
(package-initialize)
(setq make-backup-files nil) ; stop creating those backup~ files
(setq auto-save-default nil) ; stop creating those #auto-save# files
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)
(setq x-select-enable-clipboard t) ;; makes killing/yanking interact with clipboard X11 selection
(setq isearch-highlight t)
(setq search-highlight t)
(setq resize-minibuffer-mode t)
(setq query-replace-highlight t)
(setq search-highlight t)
(transient-mark-mode 1)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(setq default-directory "~/")
(setq tooltip-use-echo-area t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(set-scroll-bar-mode 'nil)
(display-time)
(column-number-mode 1)
(show-paren-mode 1)

;; Final newline handling
(setq require-final-newline t)
(setq next-line-extends-end-of-buffer nil)
(setq next-line-add-newlines nil)

(defalias 'yes-or-no-p 'y-or-n-p)
(when (fboundp 'blink-cursor-mode)
  (blink-cursor-mode -1))

;; Everything in UTF-8
(prefer-coding-system 'utf-8)
(set-language-environment "utf-8")
(set-default-coding-systems 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(add-to-list 'auto-coding-alist '("." . utf-8))
(global-hl-line-mode 1)

(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key [(shift f8)] 'highlight-symbol-at-point)
(global-set-key "\C-\M-w" 'kill-ring-save-whole-line)
(global-set-key [C-M-backspace] #'(lambda () (interactive) (zap-to-char -1 32)))
(global-set-key "\r" 'newline-and-indent)
(global-set-key (kbd "M-y") 'browse-kill-ring)

;; auto-complete
(require 'auto-complete-config)
(require 'auto-complete-etags)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")
(setq ac-sources '(ac-source-filename
                   ac-source-functions
                   ac-source-yasnippet
                   ac-source-variables
                   ac-source-symbols
                   ac-source-features
                   ac-source-abbrev
                   ac-source-words-in-same-mode-buffers
                   ac-source-dictionary
                   ac-source-gtags
                   ac-source-etags))

;; linum
(require 'linum)
(global-linum-mode 1)
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; ido
(require 'ido)
(ido-mode 1)
(setq ido-enable-flex-matching nil)
(setq ido-enable-tramp-completion nil)
(setq confirm-nonexistent-file-or-buffer nil)
(ido-everywhere t)
(setq
 ido-ignore-buffers ; ignore these guys
 '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido")
 ido-case-fold t ; be case-insensitive
 ido-use-filename-at-point nil ; don't use filename at point (annoying)
 ido-use-url-at-point nil ; don't use url at point (annoying)
 ido-enable-flex-matching t ; be flexible
 ido-max-prospects 6 ; don't spam my minibuffer
 ido-confirm-unique-completion nil ; don't wait for RET with unique completion
 ido-max-directory-size 100000)

;; full-ack
(setq ack-executable "ack-grep")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; helm
(add-to-list 'load-path "~/.emacs.d/vendor/helm")
(require 'helm-config)

;; smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; This is your old M-x.

;; Dired
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "<return>")
              'dired-find-alternate-file) ; was dired-advertised-find-file
            (define-key dired-mode-map (kbd "^")
              (lambda () (interactive) (find-alternate-file "..")))))
(put 'dired-find-alternate-file 'disabled nil)

(require 'windmove)
(windmove-default-keybindings 'meta)
(global-set-key (kbd "<C-tab>") 'bury-buffer)
(global-set-key (kbd "M-o") 'other-window)

(require 'tramp)
(setq tramp-default-method "ssh")
(setq recentf-auto-cleanup 'never
      tramp-default-method "ssh")

;; GDB
(global-set-key "\M-o" 'other-window)
(global-set-key (kbd "<f5>") 'gud-go)
(global-set-key (kbd "<f10>") 'gud-next)
(global-set-key (kbd "<f11>") 'gud-step)
(global-set-key (kbd "<S-f11>") 'gud-finish)
(global-set-key (kbd "<f8>") 'gud-break)
(setq gdb-show-main t)  
(setq gdb-many-windows t)

;; PYTHON
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;;; bind RET to py-newline-and-indent
(add-hook 'python-mode-hook '(lambda () 
     (define-key python-mode-map "\C-m" 'newline-and-indent)))
(setq-default py-indent-offset 4)

;; C/C++
(require 'anything-gtags)
(setq compilation-window-height 8)
(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))

(defun gtags-update ()
  "Make GTAGS incremental update"
  (call-process "global" nil nil nil "-u"))

(defun gtags-update-hook ()
  (when (gtags-root-dir)
    (gtags-update)))

;(add-hook 'after-save-hook #'gtags-update-hook)
(add-hook 'gtags-mode-hook 
  (lambda()
    (local-set-key (kbd "<f7>") 'anything-gtags-select)
    (local-set-key (kbd "M-.") 'gtags-find-tag)  
    (local-set-key (kbd "M-,") 'gtags-pop-stack)
    (local-set-key (kbd "M-?") 'gtags-find-rtag)
    (local-set-key (kbd "C-M-o") 'gtags-find-file)
    (local-set-key (kbd "M-]") 'gtags-find-pattern)
    (local-set-key (kbd "M-[") 'gtags-find-symbol)))

(add-hook 'c-mode-common-hook
	  (lambda ()
        (setq tab-width 4)
        (setq indent-tabs-mode nil)
        (setq c-basic-offset 4)
        (require 'gtags)
        (autoload 'gtags-mode "gtags" "" t)
        (gtags-mode t)
        (require 'xcscope)
        (setq cscope-do-not-update-database t)
	    ))

(setq c-eldoc-includes "`pkg-config gtk+-2.0 --cflags` -I./ -I../")
(load "c-eldoc")
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

;; ;;(server-start)
;; (unless (server-running-p)
;;   (server-start))


(color-theme-solarized 'dark)

;; (set-cursor-color "blue")
;; (set-foreground-color "white")
;; (set-background-color "grey20")

(set-default-font "Inconsolata-11")
;; (set-default-font "Monospace-8")
;; (set-default-font "Bitstream Vera Sans Mono-9")
;; (set-default-font "-bitstream-bitstream vera sans mono-medium-r-*--*-75-*--*--*-")
;; (set-default-font "ProggyCleanTT-12")
;; (set-default-font "DejaVu Sans Mono-")
;; (set-default-font "Andale Mono-9")
;; (set-default-font "Anonymous-9")




