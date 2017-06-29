(setq org-publish-project-alist
					;notes组件
      '((
         "org-notes"
         :body-only t
         :base-directory "/tmp/blog/" ;设置存放.org文件位置 
         :base-extension "org" ;仅处理 .org 格式文件
         :publishing-directory "/tmp/html" ;导出html文件位置
         :recursive t
	 :publishing-function org-html-publish-to-html
         :headline-levels 4 ;Just the default for this project.
	 :auto-preamble t

         :auto-sitemap t                  ;自动生成 sitemap.org
         :sitemap-filename "index.org"  ;默认名称
         :sitemap-title "Pengpengxp的流水账"
	 :sitemap-function org-publish-org-sitemap

         :export-creator-info nil    ;禁止在 postamble 显示"Created by Org"
         :export-author-info nil     ;禁止在 postamble 显示 "Author: Your Name"
         :auto-postamble nil

         :table-of-contents nil      ;禁止生成文章目录，如果要生成，将 nil 改为 t
         :section-numbers nil        ;禁止在段落标题前使用数字，如果使用，将 nil 改为 t
         :html-postamble "Update time: %d. " ;自定义 postamble 显示字样
         :style-include-default nil ;禁止使用默认 css 样式，默认就在当前目录下的css
	 )
	;;static 组件
        ("org-static"
         :base-directory "~/blog/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/blog/blog/"
         :recursive t
         :publishing-function org-publish-attachment
         )
	;;publish 组件
        ("org" :components ("org-notes" "org-static"))
	))

(provide 'init-org-publish)
