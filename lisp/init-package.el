;;; ----------------------------------------------------------------------
;;; 增加一些仓库
;;; ----------------------------------------------------------------------

(require 'package)
(setq package-archives '(
			 ("gnu" . "/home/pengpengxp/emacs-packages/gnu")
                         ("marmalade" . "/home/pengpengxp/emacs-packages/marmalade")
                         ("melpa" . "/home/pengpengxp/emacs-packages/melpa")
			 ))

;; ;;; for elpy
;; (add-to-list 'package-archives
;;              '("elpy" . "http://jorgenschaefer.github.io/packages/")
;;              )

;;(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/") t)
;;
;;(add-to-list 'package-archives
;;             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
(provide 'init-package)

;;; 执行下面，如果没有安装对应的软件包，则会自己自动安装
;; (defvar prelude-packages
;;   '(
;;     2048-game          
;;     ace-jump-buffer    
;;     ace-jump-helm-line 
;;     ace-jump-mode      
;;     ace-jump-zap       
;;     ace-pinyin         
;;     ace-window         
;;     alert              
;;     applescript-mode   
;;     async              
;;     bibtex-utils       
;;     command-log-mode   
;;     darkroom           
;;     dash               
;;     f                  
;;     flx                
;;     gntp               
;;     helm               
;;     helm-ag            
;;     helm-bibtex        
;;     helm-bibtexkey     
;;     helm-c-yasnippet   
;;     helm-swoop         
;;     icicles            
;;     ido-better-flex    
;;     ido-ubiquitous     
;;     ido-vertical-mode  
;;     idomenu            
;;     list-utils         
;;     log4e              
;;     makey              
;;     mark-tools         
;;     markdown-mode      
;;     markdown-mode+     
;;     noflet             
;;     org                
;;     org-mac-iCal       
;;     org-mac-link       
;;     org-pomodoro       
;;     org-screenshot     
;;     org-tree-slide     
;;     ox-html5slide      
;;     ox-ioslide         
;;     parsebib           
;;     pcache             
;;     persistent-soft    
;;     rw-ispell          
;;     s                  
;;     shadchen           
;;     showkey            
;;     smex               
;;     swiper             
;;     swiper-helm        
;;     yasnippet
;;     )
;;   "A list of packages to ensure are installed at launch.")

;; (defun prelude-packages-installed-p ()
;;   (loop for p in prelude-packages
;;         when (not (package-installed-p p)) do (return nil)
;;         finally (return t)))

;; (unless (prelude-packages-installed-p)
;;   ;; check for new packages (package versions)
;;   (message "%s" "Emacs Prelude is now refreshing its package database...")
;;   (package-refresh-contents)
;;   (message "%s" " done.")
;;   ;; install the missing packages
;;   (dolist (p prelude-packages)
;;     (when (not (package-installed-p p))
;;       (package-install p))))
