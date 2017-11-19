(add-hook 'ag-mode-hook #'(lambda ()
                            (interactive)
                            (define-key evil-normal-state-local-map (kbd "k") 'evil-previous-line)
                            (define-key evil-normal-state-local-map (kbd "j") 'evil-next-line)
                            (define-key evil-normal-state-local-map (kbd "h") 'evil-backward-char)
                            (define-key evil-normal-state-local-map (kbd "l") 'evil-forward-char)
                            ))

(setq ag-reuse-window 't)
(setq ag-reuse-buffers 't)

(defun peng-custumize-ag-regexp ()
  "Ag can do multiline search, use this only for multiline search
."
  (interactive)
  (let* ((things (format "%s" (thing-at-point 'symbol)))
         (input (read-from-minibuffer (concat "Input something Default("
                                               things
                                               ")")))
         (string (if (equal input "")
                     things
                   input))
         )

    (ag-project-regexp string)
    (switch-to-buffer-other-window "*ag search*")
    ))

(provide 'init-ag)
