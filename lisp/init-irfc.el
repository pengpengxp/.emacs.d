(require 'irfc)
(setq irfc-directory "~/Documents/rfcs/my-rfc-mirror")
(setq irfc-assoc-mode t)
(add-to-list 'auto-mode-alist
             '("/rfc[0-9]+\\.txt\\'" . irfc-mode))

(defun peng-irfc-mode ()
  (interactive)

  (peng-local-set-key (kbd "<backtab>")'irfc-rfc-link-prev)
  (peng-local-set-key (kbd "<tab>")'irfc-rfc-link-next)

  (peng-local-set-key (kbd "<C-return>") 'irfc-table-jump)

  (peng-local-set-key (kbd "L") 'irfc-head-prev)
  (peng-local-set-key (kbd "H") 'irfc-head-next)

  (peng-local-set-key (kbd "b") 'irfc-page-table)
  (peng-local-set-key (kbd "<") 'irfc-page-first)
  (peng-local-set-key (kbd ">") 'irfc-page-last)
  (peng-local-set-key (kbd "P") 'irfc-page-prev)
  (peng-local-set-key (kbd "N") 'irfc-page-next)

  ;; (peng-local-set-key (kbd "") 'irfc-page-goto)

  (peng-local-set-key (kbd "F") 'irfc-head-number-goto)
  (peng-local-set-key (kbd "f") 'irfc-head-goto)
  (peng-local-set-key (kbd "r") 'irfc-reference-goto)
  (peng-local-set-key (kbd "v") 'irfc-visit)
  (peng-local-set-key (kbd "o") 'irfc-follow)
  (peng-local-set-key (kbd "RET") 'irfc-follow)
  (peng-local-set-key (kbd "<return>") 'irfc-head-goto)
  ;; (peng-local-set-key (kbd "q") 'irfc-quit)
  ;; (peng-local-set-key (kbd "") 'irfc-render-toggle)
  (hl-line-mode 1)
  )

(add-hook 'irfc-mode-hook 'peng-irfc-mode)

(provide 'init-irfc)
