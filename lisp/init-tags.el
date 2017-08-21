;; (require 'helm-etags+)

;; (setq tags-table-list
;;       '("~/.emacs.d/TAGS" "/home/pengpengxp/.data/emacs-24.4/src"))

;; (setq tags-file-name nil)

;; (peng-global-set-key (kbd "C-c M-.") 'peng-helm-etags-select)

(defun peng-helm-etags-select ()
  (interactive)
  (helm-etags-select (read-from-minibuffer "Symbol name: "
                                           (thing-at-point 'symbol)))
  )
(defun peng-etags-select ()
  (interactive)
  (etags-select-find (read-from-minibuffer "Symbol name: "
                                           (thing-at-point 'symbol)))
  )
(defun  peng-clear-tags-table ()
  "reset the tags table to nil"
  (interactive)
  (setq tags-table-list nil)
  (setq tags-file-name nil)
  (message "Successfully clear all tags")
  )

(add-hook 'etags-select-mode-hook '(lambda ()
                                     (local-set-key (kbd "<kp-enter>") 'etags-select-goto-tag)
                                     ))



;; ;;; ================================================================
;; ;;; for gtags
;; ;;; ================================================================
;; (require 'helm-gtags)
;; (setq helm-gtags-auto-update t)


(provide 'init-tags)
