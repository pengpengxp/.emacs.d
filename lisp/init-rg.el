(require 'rg)

(add-hook 'rg-mode-hook #'(lambda ()
                           (interactive)
                           (peng-local-set-key (kbd "q") 'quit-window)
                           (peng-local-set-key (kbd "f") 'rg-rerun-change-files)
                           (peng-local-set-key (kbd "d") 'rg-rerun-change-dir)
                           (peng-local-set-key (kbd "i") 'rg-rerun-toggle-ignore)
                           (peng-local-set-key (kbd "c") 'rg-rerun-toggle-case)
                           (peng-local-set-key (kbd "t") 'rg-rerun-change-literal)
                           (peng-local-set-key (kbd "r") 'rg-rerun-change-regexp)
                           (peng-local-set-key (kbd "L") 'rg-list-searches)
                           (peng-local-set-key (kbd "g") 'rg-recompile)
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
