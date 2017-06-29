;;; I don't use calendar
;; (require 'calfw)

;;; I use org,so I load this
(require 'calfw-org)

;;; 星期一做为一周的起点
(setq calendar-week-start-day 1) ; 0:Sunday, 1:Monday


(defun peng-cfw:calendar-mode ()
  "pengpengxp's cfw:calendar-mode-hook"
  (interactive)
  (cfw:change-view-week))

(add-hook 'cfw:calendar-mode-hook 'peng-cfw:calendar-mode)



(provide 'init-calfw)
