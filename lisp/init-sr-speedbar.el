(require 'sr-speedbar)

(setq speedbar-show-unknown-files t) ; show all files
(setq speedbar-use-images nil) ; use text for buttons
(setq sr-speedbar-right-side nil) ; put on left side
(setq sr-speedbar-width 30)

(setq sr-speedbar-auto-refresh nil) ;nerver refresh automatically

;; (define-key evil-normal-state-map (kbd ",s") 'sr-speedbar-toggle)

(provide 'init-sr-speedbar)

;;; TODO 不能使用RET选择以后自动跳到文件的buffer中。感觉还没有我的
;;; dired-mode有用。
