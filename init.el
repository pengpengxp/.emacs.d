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
(setenv "PATH" "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9:/Applications/Emacs.app/Contents/MacOS/libexec-x86_64-10_9:/Applications/Emacs.app/Contents/MacOS:/Users/pengpengxp/.emacs.d/site-lisp/xcscope/:/usr/local/nginx/sbin:/Library/TeX/texbin:/Library/Frameworks/Python.framework/Versions/2.7/bin:~/bin")

(setq exec-path (append exec-path '("/usr/local/bin")))
(setq exec-path (append exec-path '("/Library/TeX/texbin")))
(setq exec-path (append exec-path '("/Library/Frameworks/Python.framework/Versions/2.7/bin")))
(setq exec-path (append exec-path '("~/bin")))


;;; 设置语系变量
(setenv "LANG" "zh_CN.UTF-8")
(setenv "LC_COLLATE" "zh_CN.UTF-8")
(setenv "LC_CTYPE" "zh_CN.UTF-8")
(setenv "LC_MESSAGES" "zh_CN.UTF-8")
(setenv "LC_MONETARY" "zh_CN.UTF-8")
(setenv "LC_NUMERIC" "zh_CN.UTF-8")
(setenv "LC_TIME" "zh_CN.UTF-8")

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

;; for mac
(require 'init-mac.el)

(require 'init-benchmark-init)

;;; my plugins
(require 'init-peng-copyfun)		;;;; some function I copyed from others
(require 'init-peng-copy-lexical-binding)
(require 'init-peng-prifun)		;;;; load function wrote by pengpengxp

;;; load each mode I have configured
(require 'init-evil)
(require 'init-evil-leader)
(require 'init-highlight-indent-guides)

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
(require 'init-org-page)
(require 'init-blog)

(require 'init-emacs-lisp)
;; (require 'init-latex)
(require 'init-compilation)
(require 'init-sundry)
(require 'init-eshell)
;; (require 'init-sql)
(require 'init-ibuffer)
(require 'init-shell-script)
(require 'init-dired)
;; (require 'init-cuda)


(require 'init-yasnippet)
(require 'init-auto-complete)
(require 'init-company-mode)		;company is the alternative for me
(require 'init-ycmd)
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


(require 'init-highlight)

(require 'init-ido)
(require 'init-smex)
(require 'init-icicles)
;; (require 'init-ido-cb.el)
;; (require 'ido-pinyin)			;可以使ido支持拼音，它修改了ido中的一个函数，在mbp上可以默认打开，不慢

(require 'init-ivy)

(require 'init-helm)
;; (require 'helm-ls-git)
(require 'helm-ag)
(require 'init-ag)


;;; the use of dash
;; (require 'helm-dash)			; do not need dash

(require 'init-dash)			; use dash in emacs

(require 'init-eim)
(require 'init-chinese-pyim)

;; (require 'init-auctex)			;;;;you need to install auctex first
(require 'init-smartparens)
(require 'init-window-numbering)
;; (require 'init-powerline)
;; (require 'init-guide-key)
(require 'init-which-key)
(require 'init-lusty-explorer)		; 和helm有些其别。平时没怎么用到
(require 'init-shell-pop)
;; (require 'init-flycheck)		;感觉用处不是很大？？
(require 'init-uniquify)		;make the buffer unique
;; (require 'init-weibo)
(require 'init-paredit)
(require 'init-slime)
(require 'init-magit)
;; (require 'init-mew)
(require 'init-expand-region)
(require 'init-calendar)
(require 'init-smart-tab)
;; (require 'init-calfw)
(require 'alarm)
(require 'pinyin-search)
;; (require 'init-mustache)
(require 'init-xcscope)
;; (require 'cdlatex)
(require 'init-term-mode)
;; (require 'init-ispell)
;; (require 'init-golden-ratio.el)
;; (require 'init-avy)

(require 'init-web-mode.el)
;; (require 'init-workgroups2)
(require 'init-calculater)
(require 'init-tramp)
(require 'init-docker)
(require 'init-projectile)
(require 'init-dumb-jump)

;;; hydra需要配置，暂时不用
;; (require 'hydra)
;; (require 'hydra-ox)

;; (require 'init-ecb)			; 代码浏览起来更加好，但是应该需要更多的资源

;;; don't use too often
(require 'init-bm)

;;; plugins need no addtional settings
(require 'autopair)
(require 'ascii)
(require 'hide-region)
(require 'init-multi-term)
(require 'stardict)
(require 'dash)
(require 'iedit)
(require 'breadcrumb)

;;; pengpengxp's own mode
(require 'init-cc-mode)
(require 'init-bookmark-bmemu-mode)
(require 'init-Info-mode)
(require 'init-ruby)
(require 'init-python)
(require 'init-js-mode)
(require 'init-applescript)
(require 'init-vba)
(require 'init-iterm2)
(require 'init-yaml)
(require 'init-symbol-overlay)
(require 'init-keyfreq)
(require 'init-occur-mode)
(require 'init-google-translate)
(require 'init-w3m)
(require 'init-tern)


;; (require 'init-java.el)
(require 'init-visual-line-mode)
(require 'init-BSDmakefile-mode)

;;; set my default tags table
(require 'init-tags)

;;; load my macro
(require 'init-macro)

;;; global settings need to put at last,since It may use some function provided above
(require 'init-font)
(require 'init-global)
(require 'init-xah-keys)
(require 'init-misc)
(require 'init-cursor)
(load-file (concat (getenv LISP)
                   "/init-cursor.el"))

;;; functions in river-security
(require 'init-river-security)

;;; define pengpengxp's key bindings, it should in the last
(require 'init-mouse)
(require 'init-keys)
(require 'init-hydra)
(require 'init-mu4e)


;;; require the test file
(require 'init-test)


(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#343d46" "#bf616a" "#a3be8c" "#ebcb8b" "#8fa1b3" "#b48ead" "#8fa1b3" "#dfe1e8"])
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(column-number-mode t)
 '(display-time-mode t)
 '(ibuffer-saved-filter-groups nil)
 '(ibuffer-saved-filters
   (quote
    ((#("python" 0 1
        (idx 0))
      ((used-mode . python-mode)))
     (#("org-buffer" 0 1
        (idx 1))
      ((used-mode . org-mode)))
     (#("eshell" 0 1
        (idx 2))
      ((used-mode . eshell-mode)))
     (#("t" 0 1
        (idx 3))
      (used-mode . eshell-mode))
     (#("c" 0 1
        (idx 4))
      ((or
        (mode . c-mode))))
     (#("cpp" 0 1
        (idx 5))
      ((or
        (mode . c++-mode)
        (mode . c-mode))))
     (#("lisp" 0 1
        (idx 6))
      ((or
        (mode . emacs-lisp-mode))))
     (#("sql" 0 1
        (idx 7))
      ((or
        (mode . sql-mode)
        (mode . sql-interactive-mode))))
     (#("dired" 0 1
        (idx 8))
      ((or
        (mode . dired-mode)))))))
 '(magit-log-arguments (quote ("--graph" "--decorate" "-n10")))
 '(magit-log-section-arguments (quote ("-n10")))
 '(menu-bar-mode nil)
 '(org-agenda-files
   (quote
    ("/Users/pengpengxp/org/gtd/inbox.org" "/Users/pengpengxp/org/gtd/note.org" "/Users/pengpengxp/org/gtd/test.org" "/Users/pengpengxp/org/gtd/Tips.org" "/Users/pengpengxp/org/gtd/daily.org")))
 '(safe-local-variable-values
   (quote
    ((major-mode . org-mode)
     (major-mode . org)
     (company-clang-arguments "-I/Users/pengpengxp/src/ASP-Engine/" "-I/Users/pengpengxp/src/ASP-Engine/build" "-I/Users/pengpengxp/src/ASP-Engine/build/asp_conf_ctrl_runner" "-I/Users/pengpengxp/src/ASP-Engine/build/release" "-I/Users/pengpengxp/src/ASP-Engine/build/release/openwrt" "-I/Users/pengpengxp/src/ASP-Engine/build/release/redhat" "-I/Users/pengpengxp/src/ASP-Engine/build/release/shared" "-I/Users/pengpengxp/src/ASP-Engine/build/release/ubuntu" "-I/Users/pengpengxp/src/ASP-Engine/build/template" "-I/Users/pengpengxp/src/ASP-Engine/build/template/redhat" "-I/Users/pengpengxp/src/ASP-Engine/build/template/shared" "-I/Users/pengpengxp/src/ASP-Engine/build/template/ubuntu" "-I/Users/pengpengxp/src/ASP-Engine/core" "-I/Users/pengpengxp/src/ASP-Engine/core/Core.xcodeproj" "-I/Users/pengpengxp/src/ASP-Engine/core/Core.xcodeproj/project.xcworkspace" "-I/Users/pengpengxp/src/ASP-Engine/core/data" "-I/Users/pengpengxp/src/ASP-Engine/core/data/debug" "-I/Users/pengpengxp/src/ASP-Engine/core/data/javascript" "-I/Users/pengpengxp/src/ASP-Engine/core/data/nbproject" "-I/Users/pengpengxp/src/ASP-Engine/core/data/template" "-I/Users/pengpengxp/src/ASP-Engine/core/data/txsafe_files" "-I/Users/pengpengxp/src/ASP-Engine/core/eastl" "-I/Users/pengpengxp/src/ASP-Engine/core/eastl/include" "-I/Users/pengpengxp/src/ASP-Engine/core/eastl/src" "-I/Users/pengpengxp/src/ASP-Engine/core/lib_json" "-I/Users/pengpengxp/src/ASP-Engine/core/lib_json/include" "-I/Users/pengpengxp/src/ASP-Engine/core/obj" "-I/Users/pengpengxp/src/ASP-Engine/core/obj/eastl" "-I/Users/pengpengxp/src/ASP-Engine/core/obj/lib_json" "-I/Users/pengpengxp/src/ASP-Engine/core/obj/src" "-I/Users/pengpengxp/src/ASP-Engine/core/src" "-I/Users/pengpengxp/src/ASP-Engine/core/src/aes" "-I/Users/pengpengxp/src/ASP-Engine/core/src/axtls" "-I/Users/pengpengxp/src/ASP-Engine/core/src/gtest" "-I/Users/pengpengxp/src/ASP-Engine/core/src/Javascript" "-I/Users/pengpengxp/src/ASP-Engine/core/src/Linux" "-I/Users/pengpengxp/src/ASP-Engine/core/src/Mac" "-I/Users/pengpengxp/src/ASP-Engine/core/src/UltraJason" "-I/Users/pengpengxp/src/ASP-Engine/core/src/Utils" "-I/Users/pengpengxp/src/ASP-Engine/core/unittest_samples" "-I/Users/pengpengxp/src/ASP-Engine/core/unittest_samples/javascript_encrypt_hook" "-I/Users/pengpengxp/src/ASP-Engine/core/unittest_samples/javascript_form" "-I/Users/pengpengxp/src/ASP-Engine/core/unittest_samples/javascript_obfuscate" "-I/Users/pengpengxp/src/ASP-Engine/core/unittest_samples/javascript_symbols" "-I/Users/pengpengxp/src/ASP-Engine/core/unittest_samples/javascript_syntax_tree" "-I/Users/pengpengxp/src/ASP-Engine/core/unittest_samples/performance_test" "-I/Users/pengpengxp/src/ASP-Engine/core/XcodeCoverage" "-I/Users/pengpengxp/src/ASP-Engine/core/XcodeCoverage/lcov-1.10" "-I/Users/pengpengxp/src/ASP-Engine/debug_console" "-I/Users/pengpengxp/src/ASP-Engine/debug_console/backend_web" "-I/Users/pengpengxp/src/ASP-Engine/debug_console/backend_web/templatetags" "-I/Users/pengpengxp/src/ASP-Engine/debug_console/backends" "-I/Users/pengpengxp/src/ASP-Engine/debug_console/static" "-I/Users/pengpengxp/src/ASP-Engine/debug_console/static/css" "-I/Users/pengpengxp/src/ASP-Engine/debug_console/static/fonts" "-I/Users/pengpengxp/src/ASP-Engine/debug_console/static/img" "-I/Users/pengpengxp/src/ASP-Engine/debug_console/static/scripts" "-I/Users/pengpengxp/src/ASP-Engine/debug_console/templates" "-I/Users/pengpengxp/src/ASP-Engine/debug_console/templates/registration" "-I/Users/pengpengxp/src/ASP-Engine/dist" "-I/Users/pengpengxp/src/ASP-Engine/dist/base_pkg" "-I/Users/pengpengxp/src/ASP-Engine/dist/base_pkg/bin" "-I/Users/pengpengxp/src/ASP-Engine/dist/base_pkg/post-install" "-I/Users/pengpengxp/src/ASP-Engine/dist/base_pkg/pre-install" "-I/Users/pengpengxp/src/ASP-Engine/dist/release" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/apache2" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/bin" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/conf_shared" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/debug_console" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/jail_tool" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/log_analyser" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/nginx" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/rsyslog.d" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/service_mgr" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/service_monitor" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/smoke_test" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/snmp" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/ssh" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/stunnel4" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/third-parties" "-I/Users/pengpengxp/src/ASP-Engine/dist/release/web_admin" "-I/Users/pengpengxp/src/ASP-Engine/dist/template" "-I/Users/pengpengxp/src/ASP-Engine/dist/template/apache2" "-I/Users/pengpengxp/src/ASP-Engine/dist/template/etc" "-I/Users/pengpengxp/src/ASP-Engine/dist/template/init" "-I/Users/pengpengxp/src/ASP-Engine/dist/template/init.d" "-I/Users/pengpengxp/src/ASP-Engine/dist/template/logrotate.d" "-I/Users/pengpengxp/src/ASP-Engine/dist/template/nginx" "-I/Users/pengpengxp/src/ASP-Engine/dist/template/ntp" "-I/Users/pengpengxp/src/ASP-Engine/dist/template/rsyslog.d" "-I/Users/pengpengxp/src/ASP-Engine/dist/template/services" "-I/Users/pengpengxp/src/ASP-Engine/dist/template/third-parties" "-I/Users/pengpengxp/src/ASP-Engine/docker" "-I/Users/pengpengxp/src/ASP-Engine/docker/asp" "-I/Users/pengpengxp/src/ASP-Engine/docker/asp-base" "-I/Users/pengpengxp/src/ASP-Engine/docs" "-I/Users/pengpengxp/src/ASP-Engine/log_analyser" "-I/Users/pengpengxp/src/ASP-Engine/log_analyser/access_log_analyser_lite" "-I/Users/pengpengxp/src/ASP-Engine/log_analyser/asp_log_sender" "-I/Users/pengpengxp/src/ASP-Engine/log_analyser/unittest" "-I/Users/pengpengxp/src/ASP-Engine/log_analyser/utils" "-I/Users/pengpengxp/src/ASP-Engine/mobile" "-I/Users/pengpengxp/src/ASP-Engine/mobile/android" "-I/Users/pengpengxp/src/ASP-Engine/mobile/android/ASPClient" "-I/Users/pengpengxp/src/ASP-Engine/mobile/android/RiverClient" "-I/Users/pengpengxp/src/ASP-Engine/mobile/docs" "-I/Users/pengpengxp/src/ASP-Engine/mobile/ios" "-I/Users/pengpengxp/src/ASP-Engine/mobile/ios/ASPNetworking" "-I/Users/pengpengxp/src/ASP-Engine/mobile/tools" "-I/Users/pengpengxp/src/ASP-Engine/mobile/tools/ut_backend" "-I/Users/pengpengxp/src/ASP-Engine/nginx" "-I/Users/pengpengxp/src/ASP-Engine/nginx/auto" "-I/Users/pengpengxp/src/ASP-Engine/nginx/auto/cc" "-I/Users/pengpengxp/src/ASP-Engine/nginx/auto/lib" "-I/Users/pengpengxp/src/ASP-Engine/nginx/auto/os" "-I/Users/pengpengxp/src/ASP-Engine/nginx/auto/types" "-I/Users/pengpengxp/src/ASP-Engine/nginx/autoARM" "-I/Users/pengpengxp/src/ASP-Engine/nginx/autoARM/cc" "-I/Users/pengpengxp/src/ASP-Engine/nginx/autoARM/lib" "-I/Users/pengpengxp/src/ASP-Engine/nginx/autoARM/os" "-I/Users/pengpengxp/src/ASP-Engine/nginx/autoARM/types" "-I/Users/pengpengxp/src/ASP-Engine/nginx/conf" "-I/Users/pengpengxp/src/ASP-Engine/nginx/contrib" "-I/Users/pengpengxp/src/ASP-Engine/nginx/contrib/unicode2nginx" "-I/Users/pengpengxp/src/ASP-Engine/nginx/contrib/vim" "-I/Users/pengpengxp/src/ASP-Engine/nginx/docs" "-I/Users/pengpengxp/src/ASP-Engine/nginx/docs/dtd" "-I/Users/pengpengxp/src/ASP-Engine/nginx/docs/html" "-I/Users/pengpengxp/src/ASP-Engine/nginx/docs/man" "-I/Users/pengpengxp/src/ASP-Engine/nginx/docs/text" "-I/Users/pengpengxp/src/ASP-Engine/nginx/docs/xml" "-I/Users/pengpengxp/src/ASP-Engine/nginx/docs/xsls" "-I/Users/pengpengxp/src/ASP-Engine/nginx/docs/xslt" "-I/Users/pengpengxp/src/ASP-Engine/nginx/mac" "-I/Users/pengpengxp/src/ASP-Engine/nginx/man" "-I/Users/pengpengxp/src/ASP-Engine/nginx/misc" "-I/Users/pengpengxp/src/ASP-Engine/nginx/naxsi" "-I/Users/pengpengxp/src/ASP-Engine/nginx/naxsi/naxsi_config" "-I/Users/pengpengxp/src/ASP-Engine/nginx/naxsi/naxsi_src" "-I/Users/pengpengxp/src/ASP-Engine/nginx/naxsi/nx_util" "-I/Users/pengpengxp/src/ASP-Engine/nginx/naxsi/t" "-I/Users/pengpengxp/src/ASP-Engine/nginx/Nginx.xcodeproj" "-I/Users/pengpengxp/src/ASP-Engine/nginx/ngx_http_subs_filter_module" "-I/Users/pengpengxp/src/ASP-Engine/nginx/ngx_http_subs_filter_module/doc" "-I/Users/pengpengxp/src/ASP-Engine/nginx/ngx_http_subs_filter_module/test" "-I/Users/pengpengxp/src/ASP-Engine/nginx/ngx_http_subs_filter_module/util" "-I/Users/pengpengxp/src/ASP-Engine/nginx/objs" "-I/Users/pengpengxp/src/ASP-Engine/nginx/objs/addon" "-I/Users/pengpengxp/src/ASP-Engine/nginx/objs/src" "-I/Users/pengpengxp/src/ASP-Engine/nginx/pcre" "-I/Users/pengpengxp/src/ASP-Engine/nginx/pcre/cmake" "-I/Users/pengpengxp/src/ASP-Engine/nginx/pcre/doc" "-I/Users/pengpengxp/src/ASP-Engine/nginx/pcre/m4" "-I/Users/pengpengxp/src/ASP-Engine/nginx/pcre/pcre.xcodeproj" "-I/Users/pengpengxp/src/ASP-Engine/nginx/pcre/sljit" "-I/Users/pengpengxp/src/ASP-Engine/nginx/pcre/testdata" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/core" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/event" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/http" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/mail" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/misc" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/os" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/stream" "-I/Users/pengpengxp/src/ASP-Engine/nginx/tests" "-I/Users/pengpengxp/src/ASP-Engine/nginx/tests/conf" "-I/Users/pengpengxp/src/ASP-Engine/nginx/tests/server" "-I/Users/pengpengxp/src/ASP-Engine/nginx/tests/ssl" "-I/Users/pengpengxp/src/ASP-Engine/nginx/txsafe_debug_module" "-I/Users/pengpengxp/src/ASP-Engine/nginx/txsafe_filter" "-I/Users/pengpengxp/src/ASP-Engine/nginx/txsafe_handshake_module" "-I/Users/pengpengxp/src/ASP-Engine/nginx/txsafe_realip_module" "-I/Users/pengpengxp/src/ASP-Engine/nginx/txsafe_reload_module" "-I/Users/pengpengxp/src/ASP-Engine/nginx/txsafe_web_filter" "-I/Users/pengpengxp/src/ASP-Engine/nginx/upstream_dynamic_servers_module" "-I/Users/pengpengxp/src/ASP-Engine/rsm" "-I/Users/pengpengxp/src/ASP-Engine/rsm/account" "-I/Users/pengpengxp/src/ASP-Engine/rsm/account/locale" "-I/Users/pengpengxp/src/ASP-Engine/rsm/account/migrations" "-I/Users/pengpengxp/src/ASP-Engine/rsm/account/templates" "-I/Users/pengpengxp/src/ASP-Engine/rsm/keystore" "-I/Users/pengpengxp/src/ASP-Engine/rsm/keystore/dev" "-I/Users/pengpengxp/src/ASP-Engine/rsm/license_admin" "-I/Users/pengpengxp/src/ASP-Engine/rsm/license_admin/locale" "-I/Users/pengpengxp/src/ASP-Engine/rsm/license_admin/templates" "-I/Users/pengpengxp/src/ASP-Engine/rsm/license_admin/templatetags" "-I/Users/pengpengxp/src/ASP-Engine/rsm/locale" "-I/Users/pengpengxp/src/ASP-Engine/rsm/locale/en" "-I/Users/pengpengxp/src/ASP-Engine/rsm/locale/zh_CN" "-I/Users/pengpengxp/src/ASP-Engine/rsm/locale/zh_TW" "-I/Users/pengpengxp/src/ASP-Engine/rsm/password_reset" "-I/Users/pengpengxp/src/ASP-Engine/rsm/password_reset/locale" "-I/Users/pengpengxp/src/ASP-Engine/rsm/password_reset/templates" "-I/Users/pengpengxp/src/ASP-Engine/rsm/password_reset/tests" "-I/Users/pengpengxp/src/ASP-Engine/rsm/rsm" "-I/Users/pengpengxp/src/ASP-Engine/rsm/rsm/apache" "-I/Users/pengpengxp/src/ASP-Engine/rsm/static" "-I/Users/pengpengxp/src/ASP-Engine/rsm/static/css" "-I/Users/pengpengxp/src/ASP-Engine/rsm/static/fonts" "-I/Users/pengpengxp/src/ASP-Engine/rsm/static/img" "-I/Users/pengpengxp/src/ASP-Engine/rsm/static/js" "-I/Users/pengpengxp/src/ASP-Engine/rsm/templates" "-I/Users/pengpengxp/src/ASP-Engine/service_mgr" "-I/Users/pengpengxp/src/ASP-Engine/service_mgr/unittest" "-I/Users/pengpengxp/src/ASP-Engine/service_monitor" "-I/Users/pengpengxp/src/ASP-Engine/service_monitor/unittest" "-I/Users/pengpengxp/src/ASP-Engine/smoke_test" "-I/Users/pengpengxp/src/ASP-Engine/smoke_test/service_mgr" "-I/Users/pengpengxp/src/ASP-Engine/tests" "-I/Users/pengpengxp/src/ASP-Engine/tests/auto_click" "-I/Users/pengpengxp/src/ASP-Engine/tests/auto_test_phantomjs" "-I/Users/pengpengxp/src/ASP-Engine/tests/auto_test_phantomjs/nbproject" "-I/Users/pengpengxp/src/ASP-Engine/tests/automation_auxiliary" "-I/Users/pengpengxp/src/ASP-Engine/tests/autotest" "-I/Users/pengpengxp/src/ASP-Engine/tests/autotest/advanced" "-I/Users/pengpengxp/src/ASP-Engine/tests/autotest/semi-auto" "-I/Users/pengpengxp/src/ASP-Engine/tests/autotest/testweb" "-I/Users/pengpengxp/src/ASP-Engine/tests/autotest/webconsole" "-I/Users/pengpengxp/src/ASP-Engine/tests/autotest/wizard" "-I/Users/pengpengxp/src/ASP-Engine/tests/config_ini" "-I/Users/pengpengxp/src/ASP-Engine/tests/demo" "-I/Users/pengpengxp/src/ASP-Engine/tests/demo/JenkisAutoStatistic" "-I/Users/pengpengxp/src/ASP-Engine/tests/demo/performance_test" "-I/Users/pengpengxp/src/ASP-Engine/tests/dev-rs.com" "-I/Users/pengpengxp/src/ASP-Engine/tests/dev-rs.com/apache-sites-enabled" "-I/Users/pengpengxp/src/ASP-Engine/tests/dev-rs.com/theme" "-I/Users/pengpengxp/src/ASP-Engine/tests/devenc" "-I/Users/pengpengxp/src/ASP-Engine/tests/devenc/src" "-I/Users/pengpengxp/src/ASP-Engine/tests/docker" "-I/Users/pengpengxp/src/ASP-Engine/tests/jail_tool" "-I/Users/pengpengxp/src/ASP-Engine/tests/mobile_demo" "-I/Users/pengpengxp/src/ASP-Engine/tests/mobile_demo/AndroidLabIntegration" "-I/Users/pengpengxp/src/ASP-Engine/tests/mobile_demo/AndroidLabs" "-I/Users/pengpengxp/src/ASP-Engine/tests/mobile_demo/AndroidLabs2" "-I/Users/pengpengxp/src/ASP-Engine/tests/mobile_demo/AndroidLabsMod" "-I/Users/pengpengxp/src/ASP-Engine/tests/mobile_demo/iPhoneLabs" "-I/Users/pengpengxp/src/ASP-Engine/tests/mobile_demo/iPhoneLabsMod" "-I/Users/pengpengxp/src/ASP-Engine/tests/mobile_demo/LabServer" "-I/Users/pengpengxp/src/ASP-Engine/tests/patch" "-I/Users/pengpengxp/src/ASP-Engine/tests/proxy_rr" "-I/Users/pengpengxp/src/ASP-Engine/tests/proxy_rr/backend_web" "-I/Users/pengpengxp/src/ASP-Engine/tests/proxy_rr/backends" "-I/Users/pengpengxp/src/ASP-Engine/tests/proxy_rr/proxy" "-I/Users/pengpengxp/src/ASP-Engine/tests/proxy_rr/static" "-I/Users/pengpengxp/src/ASP-Engine/tests/proxy_rr/templates" "-I/Users/pengpengxp/src/ASP-Engine/tests/proxy_rr/unittest" "-I/Users/pengpengxp/src/ASP-Engine/tests/rssh-server" "-I/Users/pengpengxp/src/ASP-Engine/tests/testweb" "-I/Users/pengpengxp/src/ASP-Engine/tests/testweb/static" "-I/Users/pengpengxp/src/ASP-Engine/tests/testweb/templates" "-I/Users/pengpengxp/src/ASP-Engine/tests/testweb/test_project" "-I/Users/pengpengxp/src/ASP-Engine/tests/third-parties" "-I/Users/pengpengxp/src/ASP-Engine/tests/third-parties/web-driver" "-I/Users/pengpengxp/src/ASP-Engine/tests/tools" "-I/Users/pengpengxp/src/ASP-Engine/tests/tools/ab-standalone" "-I/Users/pengpengxp/src/ASP-Engine/tests/tools/concurrent_connection" "-I/Users/pengpengxp/src/ASP-Engine/tests/tools/har_saver" "-I/Users/pengpengxp/src/ASP-Engine/tests/website" "-I/Users/pengpengxp/src/ASP-Engine/tests/website/static" "-I/Users/pengpengxp/src/ASP-Engine/tests/wizard_auto" "-I/Users/pengpengxp/src/ASP-Engine/third-parties" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/jemalloc" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/jemalloc/bin" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/jemalloc/build-aux" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/jemalloc/doc" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/jemalloc/include" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/jemalloc/lib" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/jemalloc/msvc" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/jemalloc/src" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/jemalloc/test" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/keepalived" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/keepalived/bin" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/keepalived/doc" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/keepalived/genhash" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/keepalived/keepalived" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/keepalived/lib" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/kibana" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/kibana/bin" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/kibana/config" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/kibana/docs" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/kibana/optimize" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/kibana/src" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/kibana/tasks" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/kibana/test" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/kibana/webpackShims" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/openssl" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/openssl/openssl" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/upx" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/upx/doc" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/upx/lzma-4.65" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/upx/src" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/upx/ucl-1.03" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/elasticsearch" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/geo_db_src" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/kibana" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/kibana/node_modules" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/kibana/src" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/plugins" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/plugins/head" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/plugins/http-basic" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/plugins/kopf" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/zookeeper" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/zookeeper/bin" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/zookeeper/conf" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/zookeeper/docs" "-I/Users/pengpengxp/src/ASP-Engine/third-parties-bin/zookeeper/lib" "-I/Users/pengpengxp/src/ASP-Engine/tools" "-I/Users/pengpengxp/src/ASP-Engine/tools/base_pkg" "-I/Users/pengpengxp/src/ASP-Engine/tools/base_pkg/bin" "-I/Users/pengpengxp/src/ASP-Engine/tools/base_pkg/post-install" "-I/Users/pengpengxp/src/ASP-Engine/tools/base_pkg/pre-install" "-I/Users/pengpengxp/src/ASP-Engine/tools/build" "-I/Users/pengpengxp/src/ASP-Engine/tools/build/share" "-I/Users/pengpengxp/src/ASP-Engine/tools/jail_tool" "-I/Users/pengpengxp/src/ASP-Engine/tools/passdev" "-I/Users/pengpengxp/src/ASP-Engine/tools/patch" "-I/Users/pengpengxp/src/ASP-Engine/tools/rssh-server" "-I/Users/pengpengxp/src/ASP-Engine/web_admin" "-I/Users/pengpengxp/src/ASP-Engine/web_admin/src" "-I/Users/pengpengxp/src/ASP-Engine/web_admin/src/web_admin" "-I/Users/pengpengxp/src/ASP-Engine/web_admin/static" "-I/Users/pengpengxp/src/ASP-Engine/web_admin/static/css" "-I/Users/pengpengxp/src/ASP-Engine/web_admin/static/fonts" "-I/Users/pengpengxp/src/ASP-Engine/web_admin/static/img" "-I/Users/pengpengxp/src/ASP-Engine/web_admin/static/js" "-I/Users/pengpengxp/src/ASP-Engine/web_admin/static/ping_js")
     (company-clang-arguments "-I./auto" "-I./auto/cc" "-I./auto/lib" "-I./auto/os" "-I./auto/types" "-I./client_body_temp" "-I./conf" "-I./contrib" "-I./contrib/unicode2nginx" "-I./contrib/vim" "-I./core" "-I./core/Core.xcodeproj" "-I./core/data" "-I./core/eastl" "-I./core/lib_json" "-I./core/obj" "-I./core/src" "-I./core/unittest_samples" "-I./core/XcodeCoverage" "-I./fastcgi_temp" "-I./html" "-I./logs" "-I./man" "-I./ngx_http_mytet_module" "-I./objs" "-I./objs/addon" "-I./objs/src" "-I./proxy_temp" "-I./sbin" "-I./scgi_temp" "-I./src" "-I./src/core" "-I./src/event" "-I./src/http" "-I./src/mail" "-I./src/misc" "-I./src/os" "-I./src/stream" "-I./uwsgi_temp")
     (company-clang-arguments "-I/Users/pengpengxp/src/ASP-Engine/core/" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/http" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/http/modules" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/core" "-I/Users/pengpengxp/src/ASP-Engine/nginx/mac" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/os/unix" "-I/Users/pengpengxp/src/ASP-Engine/nginx/src/event" "-I/Users/pengpengxp/src/ASP-Engine/third-parties/openssl/"))))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-page 'disabled nil)
(put 'erase-buffer 'disabled nil)
