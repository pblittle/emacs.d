(defvar *window-system-color-theme* 'color-theme-sanityinc-dark
  "Color theme to use in window-system frames")
(defvar *tty-color-theme* 'color-theme-terminal
  "Color theme to use in TTY frames")


(require 'color-theme-autoloads)
(autoload 'color-theme-zenburn "zenburn" "A low contrast color theme" t)
(autoload 'color-theme-twilight "color-theme-twilight" "A dark color theme" t)
(autoload 'color-theme-vivid-chalk "vivid-chalk" "A dark color theme" t)
(autoload 'color-theme-tango-2 "color-theme-tango-2" "A dark color theme" t)
(autoload 'color-theme-subdued "color-theme-subdued" "A dark color theme" t)
(autoload 'color-theme-ir-black "color-theme-ir-black" "A dark color theme" t)
(autoload 'color-theme-zen-and-art "zen-and-art" "A dark color theme" t)
(autoload 'color-theme-railscasts "color-theme-railscasts" "Translation of railscasts theme for Textmate" t)
(autoload 'color-theme-sanityinc-light "color-theme-sanityinc" "A light color theme" t)
(autoload 'color-theme-sanityinc-dark "color-theme-sanityinc" "A dark color theme" t)

(color-theme-initialize)
<<<<<<< HEAD
;; (color-theme-pierson) ; Light, favourite
;; (color-theme-high-contrast)
;; (color-theme-snowish)
;; (color-theme-marquardt)
;; (color-theme-clarity) ; dark
(color-theme-dark-laptop) ; dark
;; (color-theme-billw) ; dark
;; (color-theme-oswald) ; dark
;; (color-theme-zenburn) ; dark, low contrast
;; (color-theme-standard)

(defun color-theme-my-vivid-chalk ()
  (interactive)
  (color-theme-vivid-chalk)
  (set-face-attribute 'highlight nil :background "white" :foreground "black"))
=======
>>>>>>> 028244d9c782e2e3ea6cf8d0afa6c60c1882233e

(defun color-theme-terminal ()
  (interactive)
  (color-theme-sanityinc-dark))


(defun apply-best-color-theme-for-frame-type (frame)
  (let ((prev-frame (selected-frame)))
    (select-frame frame)
    (prog1
        (if window-system
            (preserving-default-font-size
             (funcall *window-system-color-theme*))
          (funcall *tty-color-theme*))
      (select-frame prev-frame))))

(defun reapply-color-themes ()
  (interactive)
  (mapcar 'apply-best-color-theme-for-frame-type (frame-list)))

(defun light ()
  (interactive)
  (setq *window-system-color-theme* 'color-theme-sanityinc-light)
  (reapply-color-themes))

(defun dark ()
  (interactive)
  (setq *window-system-color-theme* 'color-theme-sanityinc-dark)
  (reapply-color-themes))

(set-variable 'color-theme-is-global nil)
(add-hook 'after-make-frame-functions 'apply-best-color-theme-for-frame-type)
(apply-best-color-theme-for-frame-type (selected-frame))

(provide 'init-themes)
