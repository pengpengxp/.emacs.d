(require 'evil)
(require 'deft)

;; (setq deft-extension "org")
;; (setq deft-directory "~/org/")
;; (setq deft-text-mode 'org-mode)
;; (setq deft-use-filename-as-title t)
;; (setq deft-incremental-search nil)

(evil-set-initial-state 'deft-mode 'emacs)
(setq deft-extensions '("org" "txt"))
(setq deft-default-extension "org")
(setq deft-text-mode 'org-mode)
(setq deft-directory "~/org")
(setq deft-use-filename-as-title t)
(setq deft-incremental-search nil)

(peng-global-set-key (kbd "C-c d") 'deft)
;; (peng-global-set-key (kbd "<f7>") 'deft)

(provide 'init-deft)
