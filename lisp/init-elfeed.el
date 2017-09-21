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
        ))

;; (define-key elfeed-search-mode-map (kbd "RET") 'elfeed-search-show-entry)
;; (define-key elfeed-search-mode-map (kbd "<return>") 'elfeed-search-show-entry)
;; (define-key elfeed-search-mode-map (kbd "U") 'elfeed-search-update--force)
;; (define-key elfeed-search-mode-map (kbd "F") 'elfeed-search-fetch-visible)

(define-key elfeed-show-mode-map "<C-return>" 'peng-w3m-view-current-url-new-session)
(define-key elfeed-search-mode-map "<C-return>" 'peng-w3m-view-current-url-new-session)

(define-key elfeed-search-mode-map (kbd "j") 'next-line)
(define-key elfeed-search-mode-map (kbd "k") 'previous-line)


(setq shr-inhibit-images t)
(provide 'init-elfeed)
