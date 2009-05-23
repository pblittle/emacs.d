(require 'twit)

(add-hook 'twit-new-tweet-hook 'twit-todochiku)
(setq twit-base-url "https://twitter.com") ;; use https to keep password secure
(setq twit-show-user-images t)
(setq twit-user-image-dir "~/.emacs.d/.twitter")

(provide 'init-twitter)
