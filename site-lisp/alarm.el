;;; alarm.el --- 
;; 
;; Filename: alarm.el
;; 
;; Description: 从网上下载的。我修改了一下。在mac上需要安装`terminal-notifier'来产生alarm
;; 
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 二  3 17 20:43:28 2015 (+0800)
;; Version: 
;; Last-Updated: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:


(defvar peng-alarm-clock-timer nil
  "Keep timer so that the user can cancel the alarm.")

(defun peng-alarm-clock-message (text)
  "The actual alarm action.
Argument TEXT alarm message."
  (shell-command (format "terminal-notifier -sound default -message \"%s\" " text)))

;; (defun peng-alarm-clock ()
;;   "Set an alarm.
;; The time format is the same accepted by `run-at-time'.  For
;; example \"11:30am\"."
;;   (interactive)
;;   (let ((time (read-string "Time(example, 11:30am): "))
;;         (text (read-string "Message: ")))
;;     (setq peng-alarm-clock-timer (run-at-time time nil 'peng-alarm-clock-message text))))

(defun peng-alarm-clock ()
  "Set an alarm.
The time format is the same accepted by `run-at-time'.  For
example \"11:30am\"."
  (interactive)
  (let ((time (read-from-minibuffer "Time(example, 11:30am): "
		      (time-stamp-string "%02H:%02M%#p")))
        (text (read-string "Message: ")))
    (setq peng-alarm-clock-timer (run-at-time time nil 'peng-alarm-clock-message text))))

(defun peng-alarm-clock-cancel ()
  "Cancel the alarm clock."
  (interactive)
  (cancel-timer peng-alarm-clock-timer))

(provide 'alarm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; alarm.el ends here

