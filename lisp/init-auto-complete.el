(require 'auto-complete)
;;;use auto-complete
(add-to-list 'load-path (concat SITE-LISP "auto-complete-1.3.1"))
;; (add-to-list 'ac-dictionary-directories "/home/pengpengxp/.emacs.d/auto-complete-1.3.1/dict")
(load "fuzzy")
(load "popup")
(load "auto-complete")
(load "auto-complete-config")
;; (ac-config-default)

(ac-set-trigger-key "<tab>")		;hope to use yasnippet with auto-complete
(setq ac-auto-start nil)
;; (ac-set-trigger-key "TAB")
;; (setq ac-auto-start nil)
;;;use auto-complete

;;; use `C-n C-p' to select
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

(provide 'init-auto-complete)
