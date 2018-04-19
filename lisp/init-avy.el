(require 'avy)

(avy-setup-default)
(peng-global-set-key (kbd "C-c C-j") 'avy-resume)

;;; set the timeout of `avy-goto-char-timer'
(setq avy-timeout-seconds 20)
 
(provide 'init-avy)
