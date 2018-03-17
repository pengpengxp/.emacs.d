;;; init-ace-jump.el --- 
;; 
;; Filename: init-ace-jump.el
;; 
;; Description: use ace-jump to quikly jump in emacs-mode or evil-insert-mode
;; 
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 五  1月  9 08:27:14 2015 (+0800)
;; Version: 
;; Last-Updated: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

;; (require 'ace-jump-mode)

(require 'evil)

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ---- some personal setting
(setq ace-jump-word-mode-use-query-char t)
(setq ace-jump-mode-submode-list '(
				  ace-jump-char-mode
				  ace-jump-word-mode
				  ace-jump-line-mode
				  ))
(setq ace-jump-mode-case-fold nil)

;; you can select the key you prefer to
;; (peng-global-set-key (kbd "C-c SPC") 'ace-jump-char-mode)
(peng-global-set-key (kbd "C-c SPC") 'ace-jump-char-mode)

;;; ----------------------------------------`ace-jump-buffer'
(require 'ace-jump-buffer)

;;; 这样就可以产生一个`ace-jump-eshell-buffers'
(make-ace-jump-buffer-function "eshell"
  (with-current-buffer buffer
    (not (eq major-mode 'eshell-mode))))

;;; 这样就可以产生一个`ace-jump-org-buffers'
(make-ace-jump-buffer-function "org"
  (with-current-buffer buffer
    (not (eq major-mode 'org-mode))))

;;; 这样就可以产生一个`ace-jump-cc-buffers'
(make-ace-jump-buffer-function "cc"
  (with-current-buffer buffer
    (not (or (eq major-mode 'c-mode)
             (eq major-mode 'makefile-gmake-mode)))))

(peng-global-set-key (kbd "C-c C-b") 'ace-jump-buffer-with-configuration)
;;; ======================================================================

(provide 'init-ace-jump.el)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ace-jump.el ends here
