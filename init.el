;;; --------------------------------------------------------------------------------
;;; 设置环境变量
;;; --------------------------------------------------------------------------------
;; (setenv "PATH" (shell-command-to-string "bash -i -c 'echo -n $PATH' 2>/dev/null"))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(let ((path (shell-command-to-string ". ~/.peng_bashrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;;; eshell里面执行还是需要使用`PATH'这个环境变量。不然找不程序。还是这样显示设置好一点。
;; (setenv "PATH" "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9:/Applications/Emacs.app/Contents/MacOS/libexec-x86_64-10_9:/Applications/Emacs.app/Contents/MacOS:/Users/pengpengxp/.emacs.d/site-lisp/xcscope/:/usr/local/nginx/sbin:/Library/TeX/texbin:/Library/Frameworks/Python.framework/Versions/2.7/bin:~/bin")

(setq exec-path (append exec-path '("/usr/local/bin")))
(setq exec-path (append exec-path '("/Library/TeX/texbin")))
(setq exec-path (append exec-path '("/Library/Frameworks/Python.framework/Versions/2.7/bin")))
(setq exec-path (append exec-path '("~/bin")))


;;; 设置语系变量
(setenv "LANG" "zh_CN.UTF-8")
;; (setenv "LC_COLLATE" "zh_CN.UTF-8")
;; (setenv "LC_CTYPE" "zh_CN.UTF-8")
;; (setenv "LC_MESSAGES" "zh_CN.UTF-8")
;; (setenv "LC_MONETARY" "zh_CN.UTF-8")
;; (setenv "LC_NUMERIC" "zh_CN.UTF-8")
;; (setenv "LC_TIME" "zh_CN.UTF-8")

;; (setenv "LANG" "en_US.UTF-8")
;; (setenv "LC_COLLATE" "en_US.UTF-8")
;; (setenv "LC_CTYPE" "en_US.UTF-8")
;; (setenv "LC_MESSAGES" "en_US.UTF-8")
;; (setenv "LC_MONETARY" "en_US.UTF-8")
;; (setenv "LC_NUMERIC" "en_US.UTF-8")
;; (setenv "LC_TIME" "en_US.UTF-8")

(setq HOME (getenv "HOME"))
(setq DIR (concat HOME "/.emacs.d"))
(setenv DIR (concat HOME "/.emacs.d"))
;;(setq GTD (concat HOME "/gtd"))
(setq LISP (concat DIR "/lisp"))
(setenv LISP (concat DIR "/lisp"))
(setq SITE-LISP (concat DIR "/site-lisp"))
(setenv SITE-LISP (concat DIR "/site-lisp"))
;; (add-to-list 'load-path DIR)
(add-to-list 'load-path SITE-LISP)
(add-to-list 'load-path LISP)
(let ((default-directory SITE-LISP))	;Don't add load-path after plugins every time
  (normal-top-level-add-subdirs-to-load-path))

;;(require 'init-el-get)

;;(require 'init-benchmark-init)
(require 'use-package)
(require 'benchmark-init)

;;; my plugins
(require 'init-peng-copyfun)		;;;; some function I copyed from others
(require 'init-peng-copy-lexical-binding)
(require 'init-peng-prifun)		;;;; load function wrote by pengpengxp

;;; load each mode I have configured
(require 'init-evil)
;; (require 'init-evil-leader)
;; (require 'init-highlight-indent-guides)

;;; to config the elpa
(require 'init-package)
(require 'init-artist-mode)
(require 'xah-get-thing)

;;;;; other plugins
;; (require 'init-scheme)
(require 'init-org)
(require 'init-gtd)
(require 'init-org-export)

;; (require 'init-org-publish)
;; (require 'init-org-page)
(require 'init-blog)

(require 'init-emacs-lisp)
;; (require 'init-latex)
(require 'init-compilation)
;; (require 'init-sundry)
(require 'init-eshell)
;; (require 'init-sql)
(require 'init-ibuffer)
(require 'init-shell-script)
(require 'init-dired)
;; (require 'init-cuda)

(require 'init-auto-complete)
(require 'init-company-mode)		;company is the alternative for me
(require 'init-ycmd)
(require 'init-wgrep)

;; (require 'init-irony-mode)

;;(require 'init-header2)
(require 'init-auto-insert)
(require 'init-outline-minor-mode.el)
(require 'init-color-theme)
(require 'init-ace-jump.el)
(require 'init-sr-speedbar)
;; (require 'init-tabbar)
;; (require 'init-deft)
(require 'init-markdown)
(require 'etags-select)

;; (require 'init-highlight)
(require 'init-ido)
(require 'init-smex)
;; (require 'init-icicles)
;; (require 'init-ido-cb.el)
;; (require 'ido-pinyin)			;可以使ido支持拼音，它修改了ido中的一个函数，在mbp上可以默认打开，不慢
(require 'init-ivy)
(require 'init-rtags)


;; (require 'init-helm)
;; (require 'helm-ag)
;; (require 'helm-ls-git)
(require 'init-ag)

(require 'init-magit)
;;; the use of dash
;; (require 'helm-dash)			; do not need dash

;; (require 'init-dash)			; use dash in emacs

(require 'init-eim)
(require 'init-man-mode)

;; (require 'init-chinese-pyim)

;; (require 'init-auctex)			;;;;you need to install auctex first
;; (require 'init-smartparens)
;; (require 'init-window-numbering)
;; (require 'init-powerline)
;; (require 'init-guide-key)
(require 'init-which-key)
;; (require 'init-lusty-explorer)		; 和helm有些其别。平时没怎么用到
;; (require 'init-shell-pop)
;; (require 'init-flycheck)		;感觉用处不是很大？？
(require 'init-uniquify)		;make the buffer unique
;; (require 'init-weibo)
(require 'init-paredit)
;; (require 'init-slime)
;; (require 'init-mew)
(require 'init-expand-region)
(require 'init-calendar)
;; (require 'init-smart-tab)
;; (require 'init-calfw)
;; (require 'alarm)
(require 'pinyin-search)
;; (require 'init-mustache)
(require 'init-xcscope)
;; (require 'cdlatex)
(require 'init-term-mode)
;; (require 'init-ispell)
;; (require 'init-golden-ratio.el)
(require 'init-avy)

(require 'init-web-mode.el)
;; (require 'init-workgroups2)
(require 'init-calculater)
;; (require 'init-tramp)
;; (require 'init-docker)
(require 'init-projectile)
(require 'init-rg)


(require 'init-cdyq)


;;; hydra需要配置，暂时不用
(require 'hydra)
(require 'init-hydra)
;; (require 'hydra-ox)

;; (require 'init-ecb)			; 代码浏览起来更加好，但是应该需要更多的资源这个花不了那么多


;;; don't use too often
(require 'init-bm)

;;; plugins need no addtional settings
(require 'autopair)
(require 'ascii)
(require 'hide-region)
;; (require 'init-multi-term)
(require 'stardict)
;; (require 'dash)
(require 'iedit)
;; (require 'breadcrumb)

;;; pengpengxp's own mode
(require 'init-cc-mode)
(require 'init-bookmark-bmemu-mode)
(require 'init-Info-mode)
(require 'init-ruby)

(require 'init-python)

;; (require 'init-js-mode)
(require 'init-applescript)
;; (require 'init-vba)
;; (require 'init-iterm2)
(require 'init-yaml)
(require 'init-symbol-overlay)
;; (require 'init-keyfreq)
(require 'init-occur-mode)
(require 'init-w3m)
(require 'init-tern)


;; (require 'init-java.el)
(require 'init-visual-line-mode)
(require 'init-BSDmakefile-mode)

;;; set my default tags table
(require 'init-tags)

;;; load my macro
(require 'init-macro)
(require 'init-snmp-mode)

(let ((FILES (list
              (expand-file-name "init-irfc.org" LISP)
              (expand-file-name "init-pdf-tools.org" LISP)
              (expand-file-name "init-dumb-jump.org" LISP)

              ;; (expand-file-name "init-irony-mode.org" LISP)

              ;; (expand-file-name "init-fcitx.org" LISP)
              (expand-file-name "init-server.org" LISP)
              ;; (expand-file-name "init-vm.org" LISP)
              )))
  (mapc 'org-babel-load-file FILES))


;;; global settings need to put at last,since It may use some function provided above
(require 'init-font)
(require 'init-global)
(require 'init-xah-keys)
(require 'init-misc)
(require 'init-elfeed)
(require 'init-mu4e)
(require 'init-google-translate)
(require 'init-proto)

;; (require 'init-cursor)
;; (load-file (concat (getenv LISP)
;;                    "/init-cursor.el"))

;;; define pengpengxp's key bindings, it should in the last
(require 'init-mouse)
;; (require 'init-keys)
;; (require 'chm-view)

;;; require the test file
;; (require 'init-test)
(require 'init-yasnippet)



(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(package-selected-packages
   (quote
    (goto-last-change irfc protobuf-mode hierarchy fcitx company-irony-c-headers company-irony irony pdf-tools toc-org company-rtags ivy-rtags rtags nlinum grab-x-link rg ivy-hydra helm-gtags helm-company xmlgen xah-lookup xah-get-thing workgroups2 with-editor which-key wgrep-ag undo-tree tern-auto-complete symbol-overlay smex simple-httpd showkey shadchen rw-ispell pylint projectile-ripgrep persistent-soft page-break-lines ox-pandoc ox-ioslide ox-html5slide outline-magic org-tree-slide org-screenshot org-pomodoro org-mac-link org-mac-iCal org-jekyll org-blog noflet names mwim multiple-cursors mark-tools make-it-so keyfreq inf-ruby iedit idomenu ido-vertical-mode ido-ubiquitous ido-hacks ido-better-flex icicles hydra highlight-indent-guides helm-swoop helm-pages helm-bm ggtags flycheck-ycmd flx eyebrowse esup eshell-manual elpy elfeed dumb-jump doom-themes dired-sort-menu+ dired-sort dired-details+ dired+ dash-at-point darkroom ctags counsel-projectile counsel-osx-app counsel-gtags counsel-dash company-ycmd company-c-headers command-log-mode color-theme-solarized color-theme-monokai cnfonts clang-format chm-view chinese-word-at-point chinese-pyim bibtex-utils benchmark-init applescript-mode ag ace-window ace-pinyin ace-jump-zap ace-jump-buffer 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bm-face ((t (:background "dark green" :underline t))) nil "pengpengxp's bm-toggle-face"))
