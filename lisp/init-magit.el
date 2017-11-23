;; (add-to-list 'load-path "/path/to/git-modes")
;; (
;;  add-to-list 'load-path "/path/to/magit")
(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list (concat SITE-LISP "/magit/"))))
(require 'magit)


(add-hook 'magit-mode-hook '(lambda ()
			      (interactive)
			      (delete-other-windows)))


(add-hook 'magit-popup-mode-hook '(lambda ()
                                    (interactive)
                                    (evil-emacs-state)
                                    ))

(add-hook 'magit-status-mode-hook '(lambda ()
                                    (interactive)
                                    (evil-emacs-state)
                                    (delete-other-windows)
                                    ))

(add-hook 'magit-revision-mode-hook '(lambda ()
                                    (interactive)
                                    (evil-emacs-state)
                                    ))

(setq magit-refresh-status-buffer nil)


(add-hook 'magit-blame-mode-hook #'(lambda ()
                                     (interactive)
                                     (define-key evil-normal-state-local-map (kbd "q") 'magit-blame-quit)
                                     (define-key evil-normal-state-local-map (kbd "n") 'magit-blame-next-chunk)
                                     (define-key evil-normal-state-local-map (kbd "N") 'magit-blame-next-chunk-same-commit)
                                     (define-key evil-normal-state-local-map (kbd "p") 'magit-blame-previous-chunk)
                                     (define-key evil-normal-state-local-map (kbd "P") 'magit-blame-previous-chunk-same-commit)
                                     (define-key evil-normal-state-local-map (kbd "t") 'magit-blame-toggle-headings)
                                     (define-key evil-normal-state-local-map (kbd "M-w") 'magit-blame-copy-hash)
                                     ))

;;; magit-utils add this device, Maybe for gitman info or something
;;; else. But this will make Info-follow-nearest not work, I remove it
;;; manually.
(advice-remove 'Info-follow-nearest-node 'Info-follow-nearest-node--magit-gitman)

;;; for use of `magit-list-repositories'
(setq magit-repository-directories `("/home/pengpengxp/.emacs.d", "/home/pengpengxp/src/fhos"))

(provide 'init-magit)
