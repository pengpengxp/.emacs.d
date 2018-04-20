(require 'elfeed)

(setq elfeed-feeds
      '(
        ("http://nullprogram.com/feed/")
        ("http://planet.emacsen.org/atom.xml")
        ("http://www.ruanyifeng.com/blog/atom.xml")
        ("http://feeds2.feedburner.com/programthink") 
        ("https://oremacs.com/atom.xml")
        ("http://feed.williamlong.info/")

        ("http://feed.xbeta.info")      ;善用佳软
        ("http://feed.appinn.com/")     ;小众软件
        ("http://feed.36kr.com/c/33346/f/566026/index.rss")  ;36氪

        ("http://news.ifeng.com/rss/mainland.xml")  ;凤凰网大陆
        ("http://news.ifeng.com/rss/world.xml") ;凤凰网国际

        ("blog.ecocn.org/feed")         ;经济学人中文版

        ("http://rss.cnn.com/rss/edition_asia.rss") ;cnn Asia

        ("http://www.chinagfw.org/feeds/posts/default")
        ("http://zhangwuchang.blog.caixin.com/feed")  ;张五常财新博客

        ("https://www.calleerlandsson.com/feed.xml")

        ("https://chriszheng.science/atom.xml") ;M-x Chris-An-Emacser

        ;; ("http://www.sfw.com.cn/?feed=rss2") ;科幻世界

        ;; ("http://huo360.com/feed")      ; 影视:火星360

        ("http://www.nhzy.org/?feed=rss2")  ;健康:nhzy资讯
        ;; ("http://www.zhihu.com/rss")    ;知乎每日精选
        ("http://songshuhui.net/feed")  ;科学松鼠会

        ("http://cnpolitics.org/feed/")  ;政见


        ("http://www.dffy.com/dffy.xml") ;法律：东方法眼（全站更新）
        ("http://www.rssmaker.cc/rss/tag/58c644ad0cf2105154adee06.xml")  ;rss法律聚合订阅

        ("http://www.lawtime.cn/rss/falvfagui/gjfg.xml")  ;法律快车（法律法规）
        ("http://rss.xinhuanet.com/rss/legal.xml")  ;新华网（法治新闻）
        ("https://cn.reuters.com/rssFeed/transportationNews/")  ;路透: 汽车交通
        ("http://cn.reuters.com/rssFeed/fundsNews/")  ;路透: 基金
        ("https://blog.lilydjwg.me/feed")  ; 依云
        ("http://feeds.feedburner.com/catonmat?format=xml")
        ))

;; (define-key elfeed-search-mode-map (kbd "RET") 'elfeed-search-show-entry)
;; (define-key elfeed-search-mode-map (kbd "<return>") 'elfeed-search-show-entry)
;; (define-key elfeed-search-mode-map (kbd "U") 'elfeed-search-update--force)
;; (define-key elfeed-search-mode-map (kbd "F") 'elfeed-search-fetch-visible)

(define-key elfeed-show-mode-map "<C-return>" 'peng-w3m-view-current-url-new-session)
(define-key elfeed-show-mode-map (kbd "<mouse2>") 'peng-w3m-view-current-url-new-session)
(define-key elfeed-search-mode-map "<C-return>" 'peng-w3m-view-current-url-new-session)

(define-key elfeed-search-mode-map (kbd "j") 'next-line)
(define-key elfeed-search-mode-map (kbd "k") 'previous-line)

(setq shr-inhibit-images t)

;;; rebind *elfeed entry* `RET' to open url in w3m new session
(define-key shr-map (kbd "RET") 'peng-shr-browse-url)
(defun peng-shr-browse-url (&optional external mouse-event)
  "Browse the URL under point.
If EXTERNAL, browse the URL using `shr-external-browser'."
  (interactive (list current-prefix-arg last-nonmenu-event))
  (mouse-set-point mouse-event)
  (let ((url (get-text-property (point) 'shr-url)))
    (cond
     ((not url)
      (message "No link under point"))
     ((string-match "^mailto:" url)
      (browse-url-mail url))
     (t
      (if external
	  (funcall shr-external-browser url)
	(w3m-goto-url-new-session url))))))

;;; set proxy, I guess elfeed use cURL to fetch info, and this extra
;;; arguments can pass to cURL so that elfeed can use my proxy to
;;; fetch some sensitive info.
 (setf elfeed-curl-extra-arguments '("--socks5-hostname" "localhost:1080"))

(provide 'init-elfeed)
