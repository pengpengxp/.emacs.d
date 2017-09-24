;;; This is pengpengxp's global settings


;;; 设置我的备份策略，还在测试中
;; (setq backup-inhibited t)
(setq backup-by-copying t ; 自动备份
      backup-directory-alist '(("." . "~/.saves")) ; 自动备份在当前目录"./.saves"下
      delete-old-versions t ; 自动删除旧的备份文件
      kept-new-versions 6 ; 保留最近的6个备份文件
      kept-old-versions 2 ; 保留最早的2个备份文件
      version-control t) ; 多次备份

(desktop-save-mode 0)

;; my personal information
(setq user-full-name "pengpengxp")
(setq user-mail-address "pengpengxppri@gmail.com")

;;; 开始不需要使用menu-bar，scroll-bar这些
(menu-bar-mode -1)

;; (when window-system
;;   (scroll-bar-mode -1))

(if (display-graphic-p)
    (scroll-bar-mode -1))

;; Only start server mode if I'm not root
(unless (string-equal "root" (getenv "USER"))
  (require 'server)
  (unless (server-running-p) (server-start)))

;;; 关闭process的时候不需要询问。
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
	    kill-buffer-query-functions))

;;;copy from wangyin
(setq kill-ring-max 200)
(setq scroll-margin 3
      scroll-conservatively 10000)
(setq default-major-mode 'text-mode)
(mouse-avoidance-mode 'banish)
;;;copy from wangyin

;;;use for the alias `ls --color=auto`,if you don't use it,there will be some garbled
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; other
(display-time)
(show-paren-mode t)

;; ;;;the set for cuda .cu file
;; (setq auto-mode-alist
;;       (append
;;        ;;File name ends in '.cu'
;;        '(("\\.cu\\'". c-mode))
;;        auto-mode-alist))

;;;; the following should give fullscreen mode when F11 is depressed,I find it from the internet
;;; only usefull in Xemacs,you don't need it in terminal 
;; (when window-system
;;   (progn
;;     (peng-global-set-key [f11] '(lambda ()
;; 			     (interactive)
;; 			     (set-frame-parameter nil 'fullscreen
;; 						  (if (frame-parameter nil 'fullscreen) nil 'fullboth))
;; 			     ;; ;; If you want the fullscreen emacs to be very minimal (no tool bar, scroll bar, or menu bar, also add:
;; 			     (progn
;; 			       (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))  ;; no toolbar
;; 			       (menu-bar-mode -1) ;;no menubar
;; 			       ;; (scroll-bar-mode -1) ;; no scroll bar
;; 			       )))))

(if (display-graphic-p)
    (progn
      (peng-global-set-key [f11] '(lambda ()
				    (interactive)
				    (set-frame-parameter nil 'fullscreen
							 (if (frame-parameter nil 'fullscreen) nil 'fullboth))
				    ;; ;; If you want the fullscreen emacs to be very minimal (no tool bar, scroll bar, or menu bar, also add:
				    (progn
				      (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))  ;; no toolbar
				      (menu-bar-mode -1) ;;no menubar
				      ;; (scroll-bar-mode -1) ;; no scroll bar
				      )))))
;; for winner-mode
(winner-mode 1)
(peng-global-set-key (kbd "C-c u") 'winner-undo)
(peng-global-set-key (kbd "C-c r") 'winner-redo)

;;; open recentf-file-mode
;; (recentf-mode 1)
(setq recentf-max-saved-items 200)
(setq recentf-max-menu-items 100)

;;scroll smoothly in emacs
;;(setq scroll-conservatively 10000)
;; (load "smooth-scroll.el")

;;; y/n replace yes/no
(setq yes-or-no-p 'y-or-n-p)

;;; use registor easily
(peng-global-set-key (kbd "C-x SPC") 'point-to-register)
(peng-global-set-key (kbd "C-x j") 'jump-to-register)

;;; MISC
(peng-unshow-all-tools)
(setq column-number-mode t)
;; goto scratch easily
(peng-global-set-key (kbd "C-x C-g") 'peng-goto-scratch)

;; ;; split windows horizontal by default
;; (setq split-height-threshold nil)
;; (setq split-width-threshold 0)

;;; use easypg to encrypt my secret files
;;don't want to input the password after each modifying
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

;;; revert-buffer automaticcally
(global-auto-revert-mode 1)

;;; 这样以后，应该每次使用narrow这些都不需要提醒了
(put 'narrow-to-region 'disabled nil)

;;; 每次退出时都问问我是不是真的想退出，避免按错键了
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

(when window-system
  (peng-global-set-key (kbd "C-x C-c") 'ask-before-closing))

;;; 我现在不想看到按键提醒了
(setq suggest-key-bindings nil)

(setq-default indent-tabs-mode nil)


;; ;;; for remote ssh in emacs
;; (setq rlogin-program "ssh")
;; (setq rlogin-process-connection-type t)

;;; no fringe on mac两边没有黑边
(fringe-mode 0)


;;; 设置异步执行 `shell-command' 时，同时执行两条以上命令时，不再询问
;;; 是不是要重新开buffer什么的，直接干掉对应buffer
(setq async-shell-command-buffer 'kill-buffer)



(add-hook 'conf-space-mode-hook #'(lambda ()
                                    (hl-line-mode 1)))

(add-hook 'html-mode-hook #'(lambda ()
                              (hl-line-mode)))

(provide 'init-global)
