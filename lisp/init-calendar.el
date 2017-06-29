(require 'cal-china-x)			;显示农历
(require 'cl)
(require 'calendar)


(setq mark-holidays-in-calendar t)
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
(setq calendar-holidays cal-china-x-important-holidays)

;;; 定制一些我关注的节日
(setq holiday-wwliu-holidays
      '(;;公历节日
        (holiday-fixed 1 1 "元旦")
        (holiday-fixed 2 14 "情人节")
        (holiday-float 5 0 2 "母亲节")  ;5月第二个星期天
        (holiday-float 6 0 3 "父亲节")  ;6月第二个星期天
        (holiday-fixed 10 1 "国庆节")
        (holiday-fixed 8 21 "小谢生日")
        ;; (holiday-fixed 6 1 "儿童节")
        ;; (holiday-fixed 9 10 "教师节")
        ;; (holiday-fixed 3 8 "妇女节")
        ;; (holiday-fixed 3 14 "白色情人节")
        ;; (holiday-fixed 4 1 "愚人节")
        ;; (holiday-fixed 5 1 "劳动节")
        ;; (holiday-fixed 12 25 "圣诞节")

        
        ;; 农历节日
        (holiday-solar-term "清明" "清明节")
        (holiday-lunar 5 5 "端午节" 0)
        (holiday-lunar 7 20 "小谢农历生日" 0)
        (holiday-lunar 8 15 "中秋节" 0)
        (holiday-lunar 6 24 "青青农历生日" 0)
        (holiday-lunar 2 19 "妈妈生日" 0)
        (holiday-lunar 3 17 "老谢生日" 0)
        ;; (holiday-lunar 1 15 "元宵节" 0)
        ;; (holiday-lunar 1 1 "春节" 0)
        ;; (holiday-lunar 1 2 "春节" 0)
        ;; (holiday-lunar 1 3 "春节" 0)
        ))

;; 只显示我定制的节日
(setq calendar-holidays holiday-wwliu-holidays)

(setq christian-holidays nil) ;; 不显示基督教的节日
(setq hebrew-holidays nil)    ;; 不显示希伯来人的节日
(setq islamic-holidays nil)   ;; 不显示伊斯兰教的节日

(provide 'init-calendar)
