(require 'rg)

(add-hook 'rg-mode-hook #'(lambda ()
                           (interactive)
                           (define-key evil-normal-state-local-map (kbd "q") 'quit-window)
                           (define-key evil-normal-state-local-map (kbd "f") 'rg-rerun-change-files)
                           (define-key evil-normal-state-local-map (kbd "d") 'rg-rerun-change-dir)
                           (define-key evil-normal-state-local-map (kbd "i") 'rg-rerun-toggle-ignore)
                           (define-key evil-normal-state-local-map (kbd "c") 'rg-rerun-toggle-case)
                           (define-key evil-normal-state-local-map (kbd "t") 'rg-rerun-change-literal)
                           (define-key evil-normal-state-local-map (kbd "r") 'rg-rerun-change-regexp)
                           (define-key evil-normal-state-local-map (kbd "L") 'rg-list-searches)
                           (define-key evil-normal-state-local-map (kbd "g") 'rg-recompile)
                           ))

;; (defun peng-literal-rg (arg)
;;   (interactive "P")
;;   (let ((text (read-from-minibuffer "Please input text to search: "))
;;         (root-dir (shell-command-to-string "git rev-parse --show-toplevel")))
;;     (if arg
;;         (rg-literal text "everything" root-dir t)
;;       (rg-literal text "everything" root-dir nil))
;;     (switch-to-buffer-other-window "*rg*")
;;     ))

(defun peng-custumize-rg ()
  (interactive)
  (let* ((things (format "%s" (thing-at-point 'symbol)))
         (input (read-from-minibuffer (concat "Input something Default("
                                               things
                                               ")")))
         (string (if (equal input "")
                     things
                   input))
         (root-dir-origin (shell-command-to-string "git rev-parse --show-toplevel"))
         (root-dir (replace-regexp-in-string "\n" "" root-dir-origin))
         )

    (rg string "everything" root-dir)
    (switch-to-buffer-other-window "*rg*")))
(provide 'init-rg)
