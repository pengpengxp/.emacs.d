(require 'protobuf-mode)

;;; I want to set indent to 4
(defun peng-protobuf-mode ()
  (interactive)
  (setq c-basic-offset 4))

(add-hook 'protobuf-mode-hook 'peng-protobuf-mode)

(provide 'init-proto)
