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

(setq ORG-HOME (concat HOME "/org/gtd"))
(setq ORG-AGENDA-FILES (list (concat ORG-HOME "/inbox.org")
			     (concat ORG-HOME "/note.org")
			     (concat ORG-HOME "/test.org")
			     (concat ORG-HOME "/Tips.org")
			     (concat ORG-HOME "/daily.org")
			     ))
(setq ORG-REFILE-FILES (list 
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

(defun peng-org-agenda-mode ()
  (interactive)
  (require 'evil)
  (require 'org)
  (hl-line-mode 1)
  (setq org-agenda-skip-scheduled-if-done t) ;不显示已做完的事情
  (setq evil-normal-state-local-map org-agenda-keymap)
  (define-key evil-normal-state-local-map (kbd "j") 'evil-next-line)
  (define-key evil-normal-state-local-map (kbd "k") 'evil-previous-line)
  (define-key evil-normal-state-local-map (kbd "h") 'evil-backward-char)
  (define-key evil-normal-state-local-map (kbd "l") 'evil-forward-char)
  (define-key evil-normal-state-local-map (kbd "c") 'org-agenda-goto-date)
  (define-key evil-normal-state-local-map (kbd "<backspace>") 'delete-other-windows)
  (define-key evil-normal-state-local-map (kbd "SPC") peng-spc-main-map))


(use-package org-agenda
  :defer t
  :init
  (add-hook 'org-agenda-mode-hook 'peng-org-agenda-mode))

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
	("t" "New TODO item" entry (file (concat ORG-HOME "/inbox.org"))
	 "* 待办  %?\n ")

	("l" "link" entry (file (concat ORG-HOME "/inbox.org"))
	 "* TODO  %(peng-get-chrome-current-tab-url-to-org-capture)  \n ")

	("w" "website" entry (file (concat "/home/pengpengxp/github/pengpengxp.github.io/source/2017-06-29-my-saved-website.org") "Websites")
	 "* %?  \n")
	))

(setq org-default-notes-file (concat ORG-HOME "/inbox.org"))

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
;; 每次打开`org-agenda'后都刷新一次
;; (add-hook 'org-agenda-finalize-hook 'my-org-agenda-to-appt)

(provide 'init-gtd)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-gtd.el ends here
