(add-to-list 'auto-mode-alist
	     '("\\.scpt" . applescript-mode))

(defun peng-applescript-mode ()
  (peng-local-set-key (kbd "C-c C-c") 'peng-run-current-script)
  (define-key evil-normal-state-local-map  (kbd "SPC z") 'peng-run-current-script)
  )

(add-hook 'applescript-mode-hook 'peng-applescript-mode)

(provide 'init-applescript)
