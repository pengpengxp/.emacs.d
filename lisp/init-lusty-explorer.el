(require 'lusty-explorer)

;; (eval-after-load "helm-mode"
;;   '(progn
;;      (add-to-list 'helm-completing-read-handlers-alist '(lusty-sudo-explorer . nil))
;;      (add-to-list 'helm-completing-read-handlers-alist '(lusty-file-explorer . nil))
;;      (add-to-list 'helm-completing-read-handlers-alist '(lusty-buffer-explorer . nil))))

(defun lusty-sudo-explorer ()
  "Launch the file/directory mode of LustyExplorer."
  (interactive)
  (let ((lusty--active-mode :file-explorer)
	(lusty-prompt "sudo: >>"))
    (lusty--define-mode-map)
    (let* ((lusty--ignored-extensions-regex
	    (concat "\\(?:" (regexp-opt completion-ignored-extensions) "\\)$"))
	   (minibuffer-local-filename-completion-map lusty-mode-map)
	   (file
	    (lusty--run 'read-file-name default-directory "")))
      (when file
	(switch-to-buffer
	 (find-file-noselect (concat "/sudo:root@localhost:"
				     (expand-file-name file))))))))

(add-hook 'lusty-setup-hook
	  '(lambda ()
	     (define-key lusty-mode-map (kbd "RET") 'lusty-select-current-name)))
(provide 'init-lusty-explorer)
