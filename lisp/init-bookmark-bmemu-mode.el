(add-hook 'bookmark-bmenu-mode-hook '(lambda ()
				       (interactive)
				       (hl-line-mode)
				       ))
;;;for bookmark
(setq bookmark-save-flag 1)		;let bookmark auto-saved when I change it


;; 书签查找和跳转的时候，默认的书签排序是按字母排序的。如果想将最近访
;; 问的书签放在最前面，将下面代码添加到你的emacs配置文件中。

(defadvice bookmark-jump (after bookmark-jump activate)
  (let ((latest (bookmark-get-bookmark bookmark)))
    (setq bookmark-alist (delq latest bookmark-alist))
    (add-to-list 'bookmark-alist latest)))

;; (require 'bookmark+)

(provide 'init-bookmark-bmemu-mode)
