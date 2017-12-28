;; ;; pengpengxp's w3m-modet
;; (add-to-list 'load-path (concat SITE-LISP "emacs-w3m"))
(require 'smart-tab)
(provide 'w3m-e23)
(require 'w3m-lnum)
(require 'w3m-bookmark)

(setq w3m-home-page "www.google.com") ;set your home page
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
(setq w3m-use-toolbar t)
(setq browse-url-browser-function 'w3m-browse-url)                 ;set w3m as emacs's default browser
;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "xdg-open")

;;; after I install w3m from using package other than install
;;; manually, I must set this variable, or w3m can not work
;;; well. Wierd.
(setq w3m-url-invalid-regexp "\\`http:///")

;;; making new emacs-w3m buffers when visiting new pages
(setq w3m-make-new-session t)

(setq w3m-fill-column 70)
(setq w3m-session-automatic-save 1)
(setq w3m-session-deleted-save 1)
(setq w3m-session-load-last-sessions 1)
(setq w3m-use-title-buffer-name 1)	;use the title as buffer-name

;; 默认显示图片
(setq w3m-default-display-inline-images nil)

;;; set `browse-url-chromium' to use `google-chrome' other than
;;; `chromium'
(setq browse-url-chromium-program "google-chrome")

(defun pengpengxp-w3m-mode ()
  (defun peng-browse-current-url-by-firefox()
    (interactive)
    (browse-url-firefox w3m-current-url))

  (defun peng-browse-current-url-by-chrome ()
    (interactive)
    (browse-url-chromium w3m-current-url))

  
  (evil-normal-state 1)
  ;; (setq evil-insert-state-cursor '("black" box))
  ;; (setq evil-emacs-state-cursor '("black" box))
  (setq w3m-lnum-mode 1)
  (setq truncate-lines nil) ;; 一行显示不完就换行。不要显示到另外一页
  (local-set-key (kbd "C-j") 'view-stardict-in-buffer)

  ;; for X-emacs
  (peng-local-set-key (kbd "<C-return>") 'view-stardict-in-buffer)
  (peng-local-set-key (kbd "<M-return>") 'view-stardict-in-buffer)
  (peng-local-set-key (kbd "<down>") 'evil-next-line)
  (peng-local-set-key (kbd "<up>") 'evil-previous-line)
  (peng-local-set-key (kbd "<left>") 'evil-backward-char)
  (peng-local-set-key (kbd "<right>") 'evil-forward-char)
  (peng-local-set-key (kbd "DEL") 'delete-window) ;;?????useless
  (peng-local-set-key (kbd "o") 'w3m-browse-url)
  (peng-local-set-key (kbd "C-w") 'kill-this-buffer)
  (peng-local-set-key (kbd "C-t") 'w3m-goto-new-session-url)
  (peng-local-set-key (kbd "l") 'forward-char)
  (peng-local-set-key (kbd "h") 'backward-char)
  (peng-local-set-key (kbd "/") 'isearch-forward)
  (peng-local-set-key (kbd "b") 'switch-to-buffer)
  (peng-local-set-key (kbd "B") 'w3m-view-previous-page)
  (peng-local-set-key (kbd "N") 'w3m-view-next-page)
  (peng-local-set-key (kbd "r") 'w3m-reload-this-page)
  (peng-local-set-key (kbd "R") 'w3m-reload-all-pages)
  (peng-local-set-key (kbd "f") 'w3m-lnum-follow)
  (peng-local-set-key (kbd "F") 'peng-browse-current-url-by-firefox)
  (peng-local-set-key (kbd "+") 'w3m-zoom-in-image)
  (peng-local-set-key (kbd "-") 'w3m-zoom-out-image)
  ;; (peng-local-set-key (kbd "F") 'peng-browse-current-url-by-chrome)
  (peng-local-set-key (kbd "RET") 'w3m-view-this-url)
  (peng-local-set-key (kbd "<return>") 'w3m-view-this-url)
  (peng-local-set-key (kbd "<C-return>") 'w3m-view-this-url-new-session)
  (peng-local-set-key (kbd "<M-return>") 'w3m-view-this-url-new-session)
  (peng-local-set-key (kbd "<S-left>") 'w3m-previous-buffer)
  (peng-local-set-key (kbd "<S-right>") 'w3m-next-buffer)
  (define-key evil-normal-state-local-map (kbd "SPC m") 'hydra-google-translate/body)
  (hl-line-mode 1)
  )
(add-hook 'w3m-mode-hook 'pengpengxp-w3m-mode)

;;; open current chrome tab in w3m, only on mac
(if (string= system-type "darwin")
    (defun peng-w3m-goto-chrome-current-tab-url ()
      "Get the URL of the active tab of the first window"
      (interactive)
      (let ((result (do-applescript
                     (concat
                      "set frontmostApplication to path to frontmost application\n"
                      "tell application \"Google Chrome\"\n"
                      "	set theUrl to get URL of active tab of first window\n"
                      "	set theResult to (get theUrl) \n"
                      "end tell\n"
                      "activate application (frontmostApplication as text)\n"
                      "set links to {}\n"
                      "copy theResult to the end of links\n"
                      "return links as string\n"))))
        (w3m-goto-url result))))

(defun peng-w3m-view-current-url-new-session ()
  "open url at point with w3m in a new session"
  (interactive)
  (let ((url (xah-get-thing-at-point 'url)))
    (progn
      (w3m-goto-url-new-session url))))

(defun peng-chrome-view-current-url ()
  "open url at point with chrome"
  (interactive)
  (let ((url (xah-get-thing-at-point 'url)))
    (progn
      (browse-url-chromium url))))

(defun peng-firefox-view-current-url ()
  "open url at point with firefox"
  (interactive)
  (let ((url (xah-get-thing-at-point 'url)))
    (progn
      (browse-url-firefox url))))

;;; use `ivy' to use w3m-bookmarks
(require 'dom)
;;; where your bookmark file located
(setq peng-bookmark-file "~/.w3m/bookmark.html")

(defun peng-ivy-get-bookmarks ()
  "use `ivy-read' to select bookmark and return its url
"
  (let* ((dom (with-temp-buffer
                (insert-file-contents peng-bookmark-file)
                (libxml-parse-html-region (point-min)
                                          (point-max))))
         (a (dom-by-tag dom 'a))
         (mylist (mapcar 'peng-parse-dom-tag-to-personal-format a))
         (name (ivy-read "Jump to bookmarks:" (mapcar 'car mylist)))
         ;; todo: I need to find `name' in mylist, if find, break the
         ;; loop. But now, I just use `mapcar' to deal with every
         ;; element in mylist and get `final-result' by removing all
         ;; nil element in the list `result'. It's very ugly code!
         (result (mapcar #'(lambda (data)
                             (if (string= (car data)
                                          name)
                                 (cdr data)
                               nil))
                         mylist))
         (final-result (caar (remove nil result))))
    final-result))

(defun peng-parse-dom-tag-to-personal-format (dom)
  "parse a tag to `(name url) format'"
  (let ((url (dom-attr dom 'href))
        (name (dom-text dom)))
    (list name url)))

(defun peng-bookmarks-firefox ()
  (interactive)
  (let ((url (peng-ivy-get-bookmarks)))
    (browse-url-firefox url)))

(defun peng-bookmarks-chrome ()
  (interactive)
  (let ((url (peng-ivy-get-bookmarks)))
    (browse-url-chromium url)))

(defun peng-bookmarks-w3m ()
  (interactive)
  (let ((url (peng-ivy-get-bookmarks)))
    (w3m-goto-url-new-session url)))

;;; to use w3m by `proxychains /usr/bin/w3m "$@"'

(defun peng-w3m-use-proxy ()
  (interactive)
  (setq w3m-command "~/.emacs.d/w3m.sh"))
(peng-w3m-use-proxy)

(defun peng-w3m-nouse-proxy ()
  (interactive)
  (setq w3m-command "/usr/bin/w3m"))

(provide 'init-w3m)
