(add-hook 'term-mode-hook '(lambda ()
			     (interactive)
			     (company-mode -1)
                             (evil-emacs-state)
			     ))

(provide 'init-term-mode)
