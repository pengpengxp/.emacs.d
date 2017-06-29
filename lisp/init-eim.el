;;;eim
(add-to-list 'load-path (concat SITE-LISP "emacs-eim"))
(autoload 'eim-use-package "eim" "Another emacs input method")

;; Tooltip 暂时还不好用
(setq eim-use-tooltip nil)

(register-input-method
 "eim-wb" "euc-cn" 'eim-use-package
 "五笔" "汉字五笔输入法" "wb.txt")
(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "拼音" "汉字拼音输入法" "py.txt")

(require 'eim-extra)
(global-set-key (kbd "<C-backspace>") 'toggle-input-method)
;; 用 ; 暂时输入英文
(define-key evil-insert-state-map (kbd ";") 'eim-insert-ascii)
(define-key evil-emacs-state-map (kbd ";") 'eim-insert-ascii)

(peng-global-set-key (kbd "s-;") 'eim-insert-ascii)

(setq default-input-method "eim-wb")

(add-hook 'eim-active-hook '(lambda ()
			      (setq eim-page-length 9)))

(setq eim-wb-history-file nil)		;不使用五笔记录上次输入位置


(provide 'init-eim)
