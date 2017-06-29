;;; init-gtd.el --- 
;; 
;; Filename: init-gtd.el
;; 
;; Description: gtd config file
;; 
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 一  1月 12 16:22:13 2015 (+0800)
;; Version: 
;; Last-Updated: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:


(require 'evil)
(require 'org)

;;; ----------------------------------------------------------------------
;;; 设置环境变量
;;; ----------------------------------------------------------------------

(setq ORG-HOME (concat HOME "/org/gtd"))

(setq ORG-AGENDA-FILES (list (concat ORG-HOME "/inbox.org")
			     (concat ORG-HOME "/note.org")
			     (concat ORG-HOME "/test.org")
			     (concat ORG-HOME "/Tips.org")
			     ;; (concat ORG-HOME "/book.org")
			     ;; (concat ORG-HOME "/dreams.org")
			     ;; (concat ORG-HOME "/someday.org")
			     (concat ORG-HOME "/daily.org")
			     ))

(setq ORG-REFILE-FILES (list 
			;; (concat ORG-HOME "/book.org")
			(concat ORG-HOME "/dreams.org")
			(concat ORG-HOME "/finished.org")
			(concat ORG-HOME "/inbox.org")
			(concat ORG-HOME "/note.org")
			(concat ORG-HOME "/README.org")
			(concat ORG-HOME "/test.org")
			(concat ORG-HOME "/blog.org")
			(concat ORG-HOME "/Tips.org")
			(concat ORG-HOME "/trash.org")
			(concat ORG-HOME "/someday.org")
			     ))

(add-hook 'org-agenda-mode-hook '(lambda ()
				   ;; (delete-other-windows)
				   ;; (linum-on)
				   (hl-line-mode 1)

				   ;; (peng-local-set-key (kbd "RET") 'org-agenda-switch-to)
				   ;; (peng-local-set-key (kbd "return") 'org-agenda-switch-to)
				   ;; (peng-local-set-key (kbd "s") 'org-save-all-org-buffers)

				   ;; (setq evil-normal-state-local-map org-agenda-mode-map)
                                   (setq org-agenda-skip-scheduled-if-done t) ;不显示已做完的事情
				   (setq evil-normal-state-local-map org-agenda-keymap)

				   ;; (define-key evil-normal-state-local-map (kbd "SPC") peng-evil-normal-map)

				   (define-key evil-normal-state-local-map (kbd "j") 'evil-next-line)
				   (define-key evil-normal-state-local-map (kbd "k") 'evil-previous-line)
				   (define-key evil-normal-state-local-map (kbd "h") 'evil-backward-char)
				   (define-key evil-normal-state-local-map (kbd "l") 'evil-forward-char)
				   (define-key evil-normal-state-local-map (kbd "c") 'org-agenda-goto-date)
				   (define-key evil-normal-state-local-map (kbd "<backspace>") 'delete-other-windows)
                                   (define-key evil-normal-state-local-map (kbd "SPC") peng-spc-main-map)
				   ))

;;; ----------------------------------------------------------------------
;;;refile in several files,here is in the all org-agenda-files
;;; ----------------------------------------------------------------------
(setq org-refile-targets (quote ((nil :maxlevel . 9)
				 (ORG-REFILE-FILES :maxlevel . 9))))
;;; ----------------------------------------------------------------------

;; (setq org-refile-use-outline-path ORG-HOME)
;; (setq org-refile-targets (quote ((nil :maxlevel . 9))))

;;; 所有可能的状态
(setq org-todo-keywords '((sequence "TODO(T!)"
                                    "待办(t!)" 
				    "正在进行(n)"
				    "计划(p)"
				    ;; "Important-Day(j)"
                                    "咨询中(z)"
				    "等待协助(w)" ;waiting for others
                                    "等待讨论(j)"
				    "|"
                                    "也许有天会做(s)" ;I'll do it someday
				    "完成(d@/!)"
				    "取消(a@/!)"
				    "DONE(D@/!)"
				    "ABORT(A@/!)"
				    )))
(setq org-capture-templates 
      '(
	("t" "New TODO item" entry (file(concat ORG-HOME "/inbox.org"))
	 "* 待办  %?\n ")

	;; ("p" "New plan item" entry (file(concat ORG-HOME "/daily.org"))
	;;  "* PLAN  %?\n ")

	;; ("i" "Dreams" entry (file(concat ORG-HOME "/dreams.org"))
	;;  "* Dreams  %?\n ")

	;; ("n" "Notes" entry (file(concat ORG-HOME "/note.org"))
	;;  "*  %?\n ")

	;; ("j" "Important-Day" entry (file+datetree (concat ORG-HOME "/note.org"))
	;;  "* Important-Day  %?\n ")

	;; ("a" "Account" table-line (file+headline (concat ORG-HOME "/account.org.gpg") "Web accounts")
	;;  "|")

	("l" "link" entry (file(concat ORG-HOME "/inbox.org"))
	 "* TODO  %(peng-get-chrome-current-tab-url-to-org-capture)  \n ")

	;; ("k" "test" entry (file(concat ORG-HOME "/test.org") "Tasks")
	;;  "* TODO  %?  \n ")

	("w" "website" entry (file(concat HOME "/org/cloud/website.org") "Websites")
	 "* %?  \n")
	))

(setq org-default-notes-file (concat ORG-HOME "/inbox.org"))

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c l") 'org-store-link)
;; (global-set-key (kbd "C-c b") 'org-iswitchb)

;;; 定制自己的org-agenda选项。这样Ctrl-a以后可供选择。
(setq org-agenda-custom-commands
      '(
	("d" "Agenda and Home-related tasks"
	 (
	  (agenda "")
	  ;; (todo "PLAN")
	  ;; (todo "DOING")
	  ;; (todo "WAITING")
	  ))
	("w" "things WAITING"
	 (
	  (agenda "")
	  (todo "WAITING")
	  ))
	("o" "things TODO"
	 (
	  (agenda "")
	  (todo "TODO")
	  ))
	;; ("h" . "h for peng's dispatcher") ; description for "h" prefix
	("ht" todo "TODO")
	("hn" todo "DOING")
	("hd" todo "DONE")
	("hw" todo "WAITING")
	("hi" todo "Dreams")
	("hp" todo "Tips")
	("hs" todo "SOMEDAY")
	))

;;;默认显示一天的事件
;; (setq org-agenda-span 'week)
(setq org-agenda-span 'day)


;;; ----------------------------------------------------------------------
;;; 设置环境变量
;;; ----------------------------------------------------------------------
;;; 配置org-to-appt进行系统级别的提醒
(require 'appt)
(appt-activate t)

;;;`appt-display-interval'是在`appt-message-warning-time'到达后，每过多久循环通知
(setq appt-message-warning-time 2)	;设置提前多久通知
(setq appt-display-interval (1+ appt-message-warning-time)) ;这句可以禁示多次通知
;; (setq appt-display-interval 3)		;隔三分钟提醒一次



(setq appt-display-mode-line nil)

                                        ; use appointment data from org-mode
(defun my-org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

;;; 我的shell-script提醒程序
(setq my-appt-notification-app (concat (getenv "HOME") "/bin/appt-notification.sh"))
;; (setq my-appt-notification-app (concat (getenv "HOME") "/bin/sendmail.applescript")) ;这个可以发送邮件

(defun my-appt-display (min-to-app new-time msg)
  (if (atom min-to-app)
      (call-process my-appt-notification-app nil nil nil min-to-app msg)
    (dolist (i (number-sequence 0 (1- (length min-to-app))))
      (call-process my-appt-notification-app nil nil nil (nth i min-to-app) (nth i msg)))))

                                        ; 把默认的提醒方式换成我自己的程序
(setq appt-disp-window-function 'my-appt-display)

                                        ; 每次保存文件以后可以自动刷新
(add-hook 'after-save-hook
          '(lambda ()
             (if (string= (buffer-file-name) (concat (getenv "HOME") "/org/gtd/inbox.org"))
                 (my-org-agenda-to-appt))))
(add-hook 'after-save-hook
          '(lambda ()
             (if (string= (buffer-file-name) (concat (getenv "HOME") "/org/gtd/daily.org"))
                 (my-org-agenda-to-appt))))

                                        ; 每次开启emacs后和中午12点刷新
(my-org-agenda-to-appt)
(run-at-time "12:05am" (* 24 3600) 'my-org-agenda-to-appt)

;;; 每次打开`org-agenda'后都刷新一次
(add-hook 'org-agenda-finalize-hook 'my-org-agenda-to-appt)

(provide 'init-gtd)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-gtd.el ends here
