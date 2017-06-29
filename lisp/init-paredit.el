;;; remove the unwanted key binding by paredit
(eval-after-load "paredit"
  '(progn
     (define-key paredit-mode-map (kbd "\\") nil)
     (define-key paredit-mode-map (kbd "C-M-f") nil)
     (define-key paredit-mode-map (kbd ";") nil)
  ))
(require 'paredit)
(provide 'init-paredit)
