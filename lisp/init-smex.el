(require 'smex) ; Not needed if you use package.el

(global-set-key (kbd "M-X") 'execute-extended-command)
;; This is your old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'smex)

(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
					; when Smex is auto-initialized on its first run.

(provide 'init-smex)
