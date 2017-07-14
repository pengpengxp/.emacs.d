(require 'org-jekyll-mode)
(setq org-jekyll/jekyll-project-root "/tmp/researcher-gh-pages")
(setq org-jekyll/org-mode-project-root "/tmp/blog")
(setq org-jekyll/org-mode-static-files-folder-name  "/tmp/blog/assets")

(org-jekyll-mode)

(require 'ox-md)
;;; set org publish
;; (setq org-publish-project-alist
;;       '(

;;         ("html"
;;          ;; Path to your org files.
;;          :base-directory "~/blog/org/"
;;          :base-extension "org"

;;          ;; Path to your Jekyll project.
;;          :publishing-directory "~/blog/jekyll/"
;;          :recursive t
;;          :publishing-function org-html-publish-to-html
;;          :headline-levels 4 
;;          :html-extension "html"
;;          :body-only t ;; Only export section between <body> </body>
;;          )

;;         ("org-assets"
;;          :base-directory "~/blog/org"
;;          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
;;          :publishing-directory "~/blog/jekyll"
;;          :recursive t
;;          :publishing-function org-publish-attachment)

;;         ("org-source"
;;          :base-directory "~/blog/org"
;;          :base-extension "org"
;;          :publishing-directory "~/blog/jekyll/_site/"
;;          :recursive t
;;          :publishing-function org-publish-attachment)

;;         ("blog" :components ("org-source" "org-assets" "html"))
;;         ))

(setq org-publish-project-alist
      '(
        ("html"
         ;; Path to your org files.
         :base-directory "/Users/pengpengxp/github/pengpengxp.github.io/source"
         :base-extension "org"
         :auto-sitemap nil                  ;不自动生成 sitemap.org
         :publishing-directory "/Users/pengpengxp/github/pengpengxp.github.io"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4 
         :html-extension "html"
         :body-only nil ;; Only export section between <body> </body>
         :makeindex nil
         )

        ("org-assets"
         :base-directory "/Users/pengpengxp/github/pengpengxp.github.io/source"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
         :publishing-directory "/Users/pengpengxp/github/pengpengxp.github.io"
         :recursive t
         :publishing-function org-publish-attachment)
        ("blog" :components ("html" "org-assets"))
        ))

(defun peng-insert-blog-timestamp ()
  "insert time of today for writing blog"
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))


(defun peng-write-blog ()
  (interactive)
  (let ((filename (concat "~/github/pengpengxp.github.io/source/"
                   (format-time-string "%Y-%m-%d-")
                          (read-from-minibuffer "Blog title: " )
                          ".org")))
    (progn

      (find-file filename)
      (erase-buffer)
      (goto-char (point-min))
      (insert "#+AUTHOR: Peng Xie
#+EMAIL: pengpengxpplay@gmail.com
#+SETUPFILE: theme.setup
#+OPTIONS: ^:{}
#+TITLE: 
")
      (message "%s" filename)
      )))

(defun peng-blog-get-post-name ()
  (interactive)
  (let ((name
         (substring (file-name-nondirectory (buffer-file-name))
                    11 -4)))
    (format "%s" name)))
(defun peng-blog-get-img-name ()
  (interactive)
  (let ((name (concat (peng-blog-get-post-name)
                      "-img-")))
    (format "%s" (concat (make-temp-name name)
                          ".png"))))
(defun parent-directory (dir)
  (unless (equal "/" dir)
    (file-name-directory (directory-file-name dir))))

(defun peng-blog-org-screenshot ()
  (interactive)
  (setq filename
	(peng-blog-get-img-name))

  (setq fullfilename
	(concat (parent-directory (file-name-directory (buffer-file-name))) "img/" filename))

  ;; (print fullfilename)

  (if (file-accessible-directory-p fullfilename)
      nil
    ;; (print (file-name-directory fullfilename) t)
    (make-directory (file-name-directory fullfilename) t)
    )

  (call-process-shell-command "screencapture" nil nil nil nil "-i" (concat
        							    "\"" fullfilename "\"" ))
  (insert (concat
           "#+BEGIN_HTML\n"
           "<div class=\"figure\">\n"
           "<p><img src="
           "\"/img/"
           filename
           "\""
           "/>\n"
           "</p></div>\n"
           "#+END_HTML\n"

           ))
  )

(provide 'init-blog)
