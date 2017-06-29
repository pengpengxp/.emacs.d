(require '2048-game)

(add-hook '2048-mode-hook (lambda ()
			   (interactive)
			   (evil-emacs-state)
			   (local-set-key (kbd "<down>") '2048-down)
			   (local-set-key (kbd "<up>") '2048-up)
			   (local-set-key (kbd "<left>") '2048-left)
			   (local-set-key (kbd "<right>") '2048-right)
	  ))


(provide 'init-2048)
