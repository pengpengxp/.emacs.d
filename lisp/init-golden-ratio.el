(require 'golden-ratio)
(golden-ratio-mode 1)


;;; 默认是使用`other-window'的时候才调用。这样就可以在使用
;;; `windown-numbering'的时候使用`golden-ratio'了
(defadvice select-window-by-number
    (after golden-ratio-resize-window activate)
  (golden-ratio) nil)

;;; `select-window'以后调用一下`golden-ratio'来设置窗口大小
(defadvice select-window
    (after golden-ratio-resize-window activate)
  (golden-ratio) nil)

(provide 'init-golden-ratio.el)
