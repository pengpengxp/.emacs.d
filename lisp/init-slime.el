(require 'slime-autoloads)

;; Set your lisp system and, optionally, some contribs
(setq inferior-lisp-program "/usr/local/bin/sbcl")

(setq slime-contribs '(slime-fancy))

(add-hook 'slime-mode-hook '(lambda ()
			     (interactive)
			     (autopair-on)
			     (paredit-mode 1)
			     ))

(provide 'init-slime)
