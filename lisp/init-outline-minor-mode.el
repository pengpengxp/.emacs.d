;;; init-outline-minor-mode.el --- 
;; 
;; Filename: init-outline-minor-mode.el
;; 
;; Description: This is pengpengxp's outline-minor-mode-settings
;; 
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 一 12月 29 09:17:19 2014 (+0800)
;; Version: 
;; Last-Updated: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

(eval-after-load 'outline
  '(progn
    (require 'outline-magic)
    ))


;;; ***************************从网上拷贝的，我只需要设置eshell和shell为outline-minor可折叠就行了*************************************
(defun set-outline-minor-mode-regexp ()
  ""
  (outline-minor-mode 1)
  (let ((regexp-list (append outline-minor-mode-list nil))
  (find-regexp
	 (lambda (lst)
	   ""
	   (let ((innerList (car lst)))
	     (if innerList
		 (if (string= (car innerList) major-mode)
		     (car (cdr innerList))
		   (progn (pop lst)
			  (funcall find-regexp lst))))
	     ))))
    (make-local-variable 'outline-regexp)
    (setq outline-regexp (funcall find-regexp regexp-list)))
	
  (local-set-key (kbd "C-c C-t") 'hide-body)
  (local-set-key (kbd "C-c C-a") 'show-all)
  (local-set-key (kbd "C-c C-e") 'show-entry)

  )
 
;;; 这里设置在什么mode以什么样的正则表达示折叠
(setq outline-minor-mode-list 
      (list
       ;; '(emacs-lisp-mode "(defun\\|(defvar\\|(defcustom\\|(defconst\\|(defmacro")
       '(shell-mode "^bash.*[#%\$] ")
       ;; '(sh-mode "function .*[{(]")
       ;; '(perl-mode "sub ")
       '(eshell-mode "^[^#$\n]* [#$] ")
       ;; '(ruby-mode "[ ]+def \\|cloud_pattern\\|[ ]+cloud_node")
       ;; '(Man-mode "^[A-Z]+")
       '(term-mode ".*pengpengxp@pengpengxp-mac-air.*")
       ))
 
(mapc (lambda (mode-name) 
        (add-hook mode-name  'set-outline-minor-mode-regexp t))
      '(shell-mode-hook
        ;; sh-mode-hook
        ;; emacs-lisp-mode-hook
        eshell-mode-hook
        ;; ruby-mode-hook
        ;; Man-mode-hook
	term-mode-hook
        ))
;;; ***************************从网上拷贝的，我只需要设置eshell和shell为outline-minor可折叠就行了*************************************

(provide 'init-outline-minor-mode.el)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-outline-minor-mode.el ends here
