;;; init-org-page.el --- 
;; 
;; Filename: init-org-page.el
;; 
;; Description: 还没有实际使用过，配置出来是不影响打开了
;; 
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 一  3  9 19:05:58 2015 (+0800)
;; Version: 
;; Last-Updated: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:



(require 'org-page)

(setq op/repository-directory (concat (getenv "HOME")
				      "/org/blog/")) ;; the repository location

(setq op/site-domain "http://pengpengxp.github.io/")         ;; your domain

(setq op/site-main-title "pengpengxp的首页")
(setq op/site-sub-title "============ 不服输，但是得服气 ============ ")
(setq op/personal-github-link "https://github.com/pengpengxp")
(setq op/personal-disqus-shortname "pengpengxp")
;; (setq op/personal-google-analytics-id "UA-41088132-1")

;;; the configuration below you should choose one, not both
(setq op/personal-disqus-shortname "pengpengxpgithubio")    ;; your disqus commenting system
;; (setq op/personal-duoshuo-shortname "your_duoshuo_shortname")  ;; your duoshuo commenting system


;; 我使用这个来publish，可以不再进行分支切换了
(defun peng-op/do-publication ()
  (interactive)
  (op/do-publication t
		     nil
		     (concat (getenv "HOME")
			     "/blog")
		     t
		     nil))

;;; 这是从org-page发明人的emacs.d中拷贝的。
;; (setq op/category-config-alist
;;       '(("blog" ;; this is the default configuration
;;          :show-meta t
;;          :show-comment t
;;          :uri-generator op/generate-uri
;;          :uri-template "/blog/%y/%m/%d/%t/"
;;          :sort-by :date     ;; how to sort the posts
;;          :category-index t) ;; generate category index or not
;;         ("wiki"
;;          :show-meta t
;;          :show-comment nil
;;          :uri-generator op/generate-uri
;;          :uri-template "/wiki/%t/"
;;          :sort-by :mod-date
;;          :category-index t)
;;         ("index"
;;          :show-meta nil
;;          :show-comment nil
;;          :uri-generator op/generate-uri
;;          :uri-template "/"
;;          :sort-by :date
;;          :category-index nil)
;;         ("about"
;;          :show-meta nil
;;          :show-comment nil
;;          :uri-generator op/generate-uri
;;          :uri-template "/about/"
;;          :sort-by :date
;;          :category-index nil)))
(provide 'init-org-page)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-org-page.el ends here
