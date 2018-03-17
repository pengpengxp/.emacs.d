;;; for compilation mode
(defun peng-compilation-mode ()
  "cumstomize my compilation-mode"
  (local-set-key (kbd "DEL") (lambda ()
  		      (interactive)
  		      (bury-buffer)
  		      (delete-window)))
  ;; (switch-to-buffer-other-window "*compilation*") ; 有compilationbuffer的时候每次都自动跳转到这个buffer
  (local-set-key (kbd "<tab>") 'compilation-next-error)
  (local-set-key (kbd "<S-return>") 'peng-cdyq-compile-funciton)
)
(add-hook 'compilation-mode-hook 'peng-compilation-mode)

;;; compile的时候随着output输出而滚动，还可以定制其他。请查info
(setq compilation-scroll-output 'first-error)

;;; kill the last compilation without ask yes or no
(setq compilation-always-kill t)

(provide 'init-compilation)
