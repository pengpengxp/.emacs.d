(add-hook 'ag-mode-hook #'(lambda ()
                            (interactive)
                            (define-key evil-normal-state-local-map (kbd "k") 'evil-previous-line)
                            (define-key evil-normal-state-local-map (kbd "j") 'evil-next-line)
                            (define-key evil-normal-state-local-map (kbd "h") 'evil-backward-char)
                            (define-key evil-normal-state-local-map (kbd "l") 'evil-forward-char)
                            ))

(setq ag-reuse-window 't)
(setq ag-reuse-buffers 't)

(provide 'init-ag)
