;;; init-ruby.el --- 
;; 
;; Filename: init-ruby.el
;; Description: initial pengpengxp's ruby mode
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 三 12月 24 19:29:10 2014 (+0800)
;; Version: 
;; Last-Updated: 四 12月 25 09:20:34 2014 (+0800)
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:
(require 'init-peng-prifun)
(require 'evil)
(require 'enh-ruby-mode)		;use ruby-enhanced-mode

(defun peng-ruby-mode ()
  (interactive)
  (define-key evil-normal-state-local-map (kbd "SPC z") 'peng-run-current-script)
  (autopair-on)
  (peng-local-set-key (kbd "C-c C-v") 'peng-run-current-script)
  )
(add-hook 'ruby-mode-hook 'peng-ruby-mode)
(add-hook 'enh-ruby-mode-hook 'peng-ruby-mode)

;;; I copied from the wiki page
(add-to-list 'auto-mode-alist
	     '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist
	     '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . enh-ruby-mode))

(provide 'init-ruby)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ruby.el ends here
