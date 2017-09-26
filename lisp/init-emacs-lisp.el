;;****************************************************************pengpengxp's emacs-lisp mode
(defun pengpengxp-emacs-lisp-mode ()
  (linum-mode 1)
  (hl-line-mode 1)
  (paredit-mode 1)
  (autopair-on)
  (yas-minor-mode 1)
  (company-mode 1)
  (which-function-mode 1)
  (dumb-jump-mode 1)
  )
(add-hook 'emacs-lisp-mode-hook 'pengpengxp-emacs-lisp-mode)

(provide 'init-emacs-lisp)
