;; ;;; sql-mode
;;a little plugin to indent sql-file
(eval-after-load "sql"
  '(load-library "sql-indent"))

(defun peng-sql-send-line ()
  "send the current line to sql-inter.."
  (interactive)
   (sql-send-region (line-beginning-position)
		    (line-end-position)))
(defun peng-sql-send-remain ()
  "send the remain content from current line to sql-inter.."
  (interactive)
  (sql-send-region (line-beginning-position)
		   (point-max)))

(defun peng-sql-mode ()
  (add-to-list 'ac-modes 'sql-mode)
  (linum-mode 1)
  (local-set-key (kbd "<f5>") 'sql-send-buffer)
  (local-set-key (kbd "<C-return>") 'peng-sql-send-line)
  (local-set-key (kbd "<f8> s r") 'sql-send-region)
  (local-set-key (kbd "<f8> s s") 'sql-send-string)
  (local-set-key (kbd "<f8> s l") 'peng-sql-send-line)
  (local-set-key (kbd "<f10>") 'sql-send-region)
  ;; (local-set-key (kbd "<f9>") 'peng-sql-send-remain)
)
(add-hook 'sql-mode-hook 'peng-sql-mode)

;;sqli-mode:the interactive mode of sql
(defun peng-sql-interactive-mode ()
  (evil-emacs-state)
  (sql-set-product 'ansi)
  (sql-set-sqli-buffer-generally))
(add-hook 'sql-interactive-mode-hook 'peng-sql-interactive-mode)

(provide 'init-sql)
