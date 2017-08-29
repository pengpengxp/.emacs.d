;; ;; pengpengxp's w3m-mode
(require 'smart-tab)
(add-to-list 'load-path (concat SITE-LISP "emacs-w3m"))
(require 'w3m-load)
(provide 'w3m-e23)
(require 'w3m-lnum)
(setq w3m-home-page "www.google.com") ;set your home page
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
(setq w3m-use-toolbar t)
;; (setq browse-url-browser-function 'w3m-browse-url)                 ;set w3m as emacs's default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "xdg-open")

(setq w3m-fill-column 70)
(setq w3m-session-automatic-save 1)
(setq w3m-session-deleted-save 1)
(setq w3m-session-load-last-sessions 1)
(setq w3m-use-title-buffer-name 1)	;use the title as buffer-name

;; 默认显示图片
(setq w3m-default-display-inline-images t)
(setq w3m-default-toggle-inline-images t)

(defun pengpengxp-w3m-mode ()
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
  (peng-local-set-key (kbd "f") 'w3m-lnum-follow)
  (peng-local-set-key (kbd "RET") 'w3m-view-this-url)
  (peng-local-set-key (kbd "<return>") 'w3m-view-this-url)
  (define-key evil-normal-state-local-map (kbd "SPC m") 'hydra-google-translate/body)
  (smart-tab-mode-off)
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




(provide 'init-w3m)
