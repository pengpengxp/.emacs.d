;;; init-shell-script.el --- 
;; 
;; Filename: init-shell-script.el
;; Description: pengpengxp's shell-script-mode
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 四 12月 25 20:03:14 2014 (+0800)
;; Version: 
;; Last-Updated: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:



(require 'evil)

;;sh-mode is the alias of shell-script-mode so I should use the
;;sh-mode-hook rather than the shell-script-mode-hook to custermize
;;this mode.
(defun peng-shell-script-mode ()
  (hl-line-mode 1)
  ;; (define-key evil-normal-state-local-map (kbd "SPC z") 'peng-run-current-script)
  (peng-local-set-key (kbd "C-c C-v") 'peng-run-current-script)
  (company-mode 1)
  (auto-complete-mode 1)
  (peng-local-set-key (kbd "C-c o") 'ac-trigger-key-command)
  (dumb-jump-mode )
)

(add-hook 'sh-mode-hook 'peng-shell-script-mode)

(provide 'init-shell-script)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-shell-script.el ends here
