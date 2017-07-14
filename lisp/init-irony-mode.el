;(require 'company-irony)

;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-irony))

;(defun my-irony-mode-hook ()
;  (define-key irony-mode-map
;      [remap completion-at-point] 'counsel-irony)
;  (define-key irony-mode-map
;      [remap complete-symbol] 'counsel-irony))
;(add-hook 'irony-mode-hook 'my-irony-mode-hook)
;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(provide 'init-irony-mode)
