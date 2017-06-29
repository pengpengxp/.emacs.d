
(add-hook 'occur-mode-hook #'(lambda ()
                               (interactive)
                               (peng-local-set-key (kbd "RET") 'occur-mode-goto-occurrence)
                               (peng-local-set-key (kbd "<return>") 'occur-mode-goto-occurrence)
                               (peng-local-set-key (kbd "q") 'quit-window)
                               ;; 在evil模式下 `mouse' 还暂时用不了
                               (peng-local-set-key (kbd "<down-mouse-1>") 'mouse-drag-region)
                               ))



(provide 'init-occur-mode)
