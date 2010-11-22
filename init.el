;; -*- coding: utf-8 -*-

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *vi-emulation-support-enabled* nil) ; "viper-mode"
<<<<<<< HEAD
(setq *haskell-support-enabled* nil)
(setq *ocaml-support-enabled* t)
(setq *common-lisp-support-enabled* t)
(setq *clojure-support-enabled* t)
(setq *scheme-support-enabled* t)
(setq *macbook-pro-support-enabled* t)
(setq *erlang-support-enabled* nil)
(setq *darcs-support-enabled* nil)
(setq *rails-support-enabled* t)
(setq *spell-check-support-enabled* t)
(setq *byte-code-cache-enabled* nil)
(setq *twitter-support-enabled* t)
=======
(setq *spell-check-support-enabled* nil)
(setq *byte-code-cache-enabled* nil)
(setq *macbook-pro-support-enabled* t)
>>>>>>> 028244d9c782e2e3ea6cf8d0afa6c60c1882233e
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))


;;----------------------------------------------------------------------------
;; Make elisp more civilised
;;----------------------------------------------------------------------------
(require 'cl)


;;----------------------------------------------------------------------------
;; Set load path
;;----------------------------------------------------------------------------
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/site-lisp/")
           (default-directory my-lisp-dir))
      (progn
        (setq load-path (cons my-lisp-dir load-path))
        (normal-top-level-add-subdirs-to-load-path))))
(setq load-path (cons (expand-file-name "~/.emacs.d") load-path))


;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(when *byte-code-cache-enabled*
  (require 'init-byte-code-cache))
(require 'init-elpa)
(require 'init-el-get)
(require 'init-utils)
(require 'init-exec-path)
(require 'init-frame-hooks)
(require 'init-xterm)
(require 'init-title-bar)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-proxies)
<<<<<<< HEAD


;;----------------------------------------------------------------------------
;; Enhanced dired
;;----------------------------------------------------------------------------
(require 'dired+)
(setq dired-recursive-deletes 'top)
(define-key dired-mode-map [mouse-2] 'dired-find-file)


;;----------------------------------------------------------------------------
;; Show and edit all lines matching a regex
;;----------------------------------------------------------------------------
(require 'all)


;;----------------------------------------------------------------------------
;; VI emulation and related key mappings
;;----------------------------------------------------------------------------
(when *vi-emulation-support-enabled*
  ;; C-z is usually 'iconify-or-deiconify-frame, but viper uses it to toggle
  ;; vi/emacs input modes, causing confusion in non-viper buffers
  (global-unset-key "\C-z")
  (setq viper-mode t)
  (setq viper-custom-file-name (convert-standard-filename "~/.emacs.d/.viper"))
  (require 'viper)
  (define-key viper-insert-global-user-map (kbd "C-n") 'dabbrev-expand)
  (define-key viper-insert-global-user-map (kbd "C-p") 'dabbrev-expand)

  ;; Stop C-u from clobbering prefix-arg -- I always use C-b/C-f to scroll
  (define-key viper-vi-basic-map "\C-u" nil)

  ;; Vim-style searching of the symbol at point, made easy by highlight-symbol
  (autoload 'highlight-symbol-next "highlight-symbol" "Highlight symbol at point")
  (autoload 'highlight-symbol-prev "highlight-symbol" "Highlight symbol at point")
  (setq highlight-symbol-on-navigation-p t)
  (define-key viper-vi-global-user-map "*" 'highlight-symbol-next)
  (define-key viper-vi-global-user-map "#" 'highlight-symbol-prev))


;; Work around a problem in Cocoa emacs, wherein setting the cursor coloring
;; is incredibly slow; viper sets the cursor very frequently in insert mode
(when (and *vi-emulation-support-enabled* *is-cocoa-emacs*)
  (defun viper-change-cursor-color (new-color &optional frame)))


;;----------------------------------------------------------------------------
;; Show a marker in the left fringe for lines not in the buffer
;;----------------------------------------------------------------------------
(setq default-indicate-empty-lines t)


;;----------------------------------------------------------------------------
;; Don't disable case-change functions
;;----------------------------------------------------------------------------
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;;----------------------------------------------------------------------------
;; Navigate window layouts with "C-c <left>" and "C-c <right>"
;;----------------------------------------------------------------------------
(winner-mode 1)


;;----------------------------------------------------------------------------
;; Navigate windows "C-<arrow>"
;;----------------------------------------------------------------------------
(windmove-default-keybindings 'control)


;;----------------------------------------------------------------------------
;; Use regex searches by default.
;;----------------------------------------------------------------------------
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)
(global-set-key "\C-\M-s" 'isearch-forward)
(global-set-key "\C-\M-r" 'isearch-backward)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))


;;----------------------------------------------------------------------------
;; Easily count words (http://emacs-fu.blogspot.com/2009/01/counting-words.html)
;;----------------------------------------------------------------------------
(defun count-words (&optional begin end)
  "count words between BEGIN and END (region); if no region defined, count words in buffer"
  (interactive "r")
  (let ((b (if mark-active begin (point-min)))
      (e (if mark-active end (point-max))))
    (message "Word count: %s" (how-many "\\w+" b e))))


;;----------------------------------------------------------------------------
;; Modeline tweaks
;;----------------------------------------------------------------------------
(size-indication-mode)


;;----------------------------------------------------------------------------
;; Modeline tweaks
;;----------------------------------------------------------------------------
(autoload 'linum-mode "linum" "Toggle line numbering" t)


;;----------------------------------------------------------------------------
;; Scroll the window smoothly with the up/down arrows
;;----------------------------------------------------------------------------
(require 'smooth-scrolling)
(setq scroll-preserve-screen-position t)


;;----------------------------------------------------------------------------
;; Nicer naming of buffers for files with identical names
;;----------------------------------------------------------------------------
(require 'uniquify)

(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")


;;----------------------------------------------------------------------------
;; Use ibuffer instead of the built in buffer list
;;----------------------------------------------------------------------------
(global-set-key (kbd "C-x C-b") 'ibuffer)


;;----------------------------------------------------------------------------
;; Dynamic expansion tweaks
;;----------------------------------------------------------------------------
(eval-after-load "hippie-exp"
  '(setq hippie-expand-try-functions-list
         (remove 'try-expand-line hippie-expand-try-functions-list)))


;;----------------------------------------------------------------------------
;; Highlight URLs in comments/strings
;;----------------------------------------------------------------------------
;; (add-hook 'find-file-hooks 'goto-address-prog-mode)


;;----------------------------------------------------------------------------
;; Basic flymake configuration
;;----------------------------------------------------------------------------
=======
(require 'init-dired)
(require 'init-viper)
(require 'init-isearch)
(require 'init-iedit)
(require 'init-uniquify)
(require 'init-ibuffer)
>>>>>>> 028244d9c782e2e3ea6cf8d0afa6c60c1882233e
(require 'init-flymake)
(require 'init-regex-tool)

(require 'init-recentf)
(require 'init-ido)
(require 'init-hippie-expand)
(require 'init-auto-complete)
(require 'init-windows)
(require 'init-sessions)
(require 'init-fonts)
(require 'init-themes)
(require 'init-mmm)
(require 'init-growl)

(require 'init-editing-utils)

(require 'init-svn)
(require 'init-darcs)
(require 'init-git)

(require 'init-gnuplot)
(require 'init-crontab)
(require 'init-textile)
(require 'init-markdown)
(require 'init-csv)
(require 'init-erlang)
(require 'init-javascript)
(require 'init-sh)
(require 'init-php)
(require 'init-org)
(require 'init-htmlize)
(require 'init-nxml)
(require 'init-css)
(require 'init-haml)
(require 'init-python-mode)
(require 'init-haskell)
(require 'init-ocaml)
(require 'init-ruby-mode)
(require 'init-rails)

(require 'init-lisp)
(require 'init-slime)
(require 'init-clojure)
(require 'init-common-lisp)
;(require 'init-scheme)

(when *spell-check-support-enabled*
  (require 'init-spelling))

;; In-Emacs apps
(require 'init-mail)
(require 'init-twitter)

(require 'init-misc)


;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(server-start)


;;----------------------------------------------------------------------------
;; Edit-server for Chrome extension: http://github.com/stsquad/emacs_chrome
;;----------------------------------------------------------------------------
(require 'init-edit-server)


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)
