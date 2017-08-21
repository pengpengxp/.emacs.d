;;; init-color-theme.el --- 
;; 
;; Filename: init-color-theme.el
;; 
;; Description: initial my theme
;; 
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 二  1月  6 15:05:08 2015 (+0800)
;; Version: 
;; Last-Updated: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs 24 offer this theme, it is good. But color-theme offer me
;;; the more choices
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (when window-system
;;   ;; (load-theme 'manoj-dark nil nil)
;;   ;; (enable-theme 'manoj-dark)
;;   (load-theme 'deeper-blue nil nil)
;;   (enable-theme 'deeper-blue)
;;   )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; you can use 'color-theme-select to try the themes
(require 'color-theme)
(color-theme-initialize)

;;; I don't understand why I must load it rather than only require it?

;; (when window-system
;;   (progn
;;     (load-file (concat SITE-LISP "/color-theme-6.6.0/emacs-colors-solarized.el"))
;;     (require 'color-theme-solarized)))

;; ;;; solarized theme
;; (if (display-graphic-p)
;;   (progn
;;     (load-file (concat SITE-LISP "/color-theme-6.6.0/emacs-colors-solarized.el"))
;;     (require 'color-theme-solarized)
;;     ;; (color-theme-solarized-dark)
;;     (color-theme-deep-blue)
;; ))

;; (color-theme-aalto-light)

;;; ====================moe theme==================== 
(require 'moe-theme)
;; ;;; 白天light晚是dark自动切换
;; (setq moe-theme-switch-by-sunrise-and-sunset t)	;设置这个后，可以根据本地的日出和日落来切换dark和light
;; ;;; 这里先设置重庆的经纬度
;; (setq calendar-latitude +29.8)		; +表示北半球
;; (setq calendar-longitude +103.6)	; +表示东半球
;; (require 'moe-theme-switcher)

;; 我还是喜欢dark
;; (moe-light)
(moe-dark)
;; (color-theme-taming-mr-arneson)

;;; ====================moe theme==================== 

;; (color-theme-standard)
;; (color-theme-gnome2)

;; (color-theme-charcoal-black)

;;; use base16 emacs theme
;; (require 'base16-theme)
;; (let ((THEMENAME "base16-ocean-theme.el"))
;;   (load-file (concat (getenv "HOME")
;;                      "/.emacs.d/site-lisp/base16-emacs-master/build/"
;;                      THEMENAME)))


;;; for light theme leuven
;; (add-to-list 'custom-theme-load-path "/home/pengpengxp/.emacs.d/site-lisp/emacs-leuven-theme-master")
;; (load-theme 'leuven t)
;; (load-theme 'leuven-dark t)

;; ;;; ;;;;;;;;;;;;;;;; doom-themes config begin ;;;;;;;;;;;;;;;;
;; (require 'doom-themes)

;; ;; Global settings (defaults)
;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;       doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; ;; may have their own settings.
;; (load-theme 'doom-one t)
;; (load-theme 'doom-molokai t)

;; ;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)

;; ;; Enable custom neotree theme
;; (doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

;; ;;; ;;;;;;;;;;;;;;;; doom-themes config end ;;;;;;;;;;;;;;;;



(provide 'init-color-theme)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-color-theme.el ends here
