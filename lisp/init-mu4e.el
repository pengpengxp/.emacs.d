(require 'mu4e)

(setq mu4e-headers-fields
      (quote
       (
        (:human-date . 20)
        (:flags . 6)
        (:mailing-list . 10)
        (:from . 30)
        (:to . 30)
        (:thread-subject)
        )))

(setq mu4e-mu-version "0.9.19")
;;; set the rich-text color
(setq shr-color-visible-luminance-min 100)

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; default
(setq mu4e-maildir (expand-file-name "~/mutt_mail"))


;; (setq mu4e-get-mail-command "offlineimap")
;;; usr my own script to fetch mail
(setq mu4e-get-mail-command "/home/pengpengxp/bin/p_get_mail.sh")
;; Fetch mail in 600 sec interval
(setq mu4e-update-interval 600)

;;; use w3m to render rich-text message
(setq mu4e-html2text-command "w3m -dump -T text/html -o display_link_number=1")
;; (setq mu4e-html2text-command "lynx -stdin -dump")
;; (setq mu4e-html2text-command "html2text -width 100 -style pretty")

(evil-set-initial-state 'mu4e-main-mode 'normal)
(evil-set-initial-state 'mu4e-headers-mode 'normal)
(evil-set-initial-state 'mu4e-view-mode 'normal)
(evil-set-initial-state 'mu4e-compose-mode 'emacs)


(require 'smtpmail)
(setq send-mail-function    'smtpmail-send-it
      smtpmail-smtp-server  "smtp.sina.com"
      smtpmail-stream-type  'ssl
      smtpmail-smtp-service 465)
(setq mu4e-mu-binary "/usr/local/bin/mu")
(setenv "XAPIAN_CJK_NGRAM" "1")

(setq mu4e-attachment-dir
  (lambda (fname mtype)
    (cond
      ;; zip and rar file go to ~/Downloads
      ((and fname (string-match "\\.zip$" fname))  "~/Downloads")
      ((and fname (string-match "\\.rar$" fname))  "~/Downloads")

      ;; document to and rar file go to ~/Documents
      ((and fname (string-match "\\.pdf$" fname))  "~/Documents")
      ((and fname (string-match "\\.doc$" fname))  "~/Documents")

      ;; ... other cases  ...
      (t "/tmp")))) ;; everything else


(defun peng-mu4e-main-mode ()
  (interactive)
  (peng-local-set-key (kbd "U") 'mu4e-update-index)
  (peng-local-set-key (kbd "F") #'(lambda ()
                                    (interactive)
                                    (progn
                                    (async-shell-command "/home/pengpengxp/bin/p_get_mail.sh" "*offlineimap mu4e*"))))
  (peng-local-set-key (kbd "q") 'mu4e-quit)
  (peng-local-set-key (kbd "C") 'mu4e-compose-new)
  (peng-mu4e-key-binding)
  )

(add-hook 'mu4e-main-mode-hook 'peng-mu4e-main-mode)



(defun peng-mu4e-view-mode ()
  (interactive)
  (hl-line-mode 1)

  (peng-local-set-key (kbd "<return>") 'peng-firefox-view-current-url)
  (peng-local-set-key (kbd "RET") 'peng-firefox-view-current-url)
  (peng-local-set-key (kbd "q") 'mu4e~view-quit-buffer)
  (peng-local-set-key (kbd "<C-down>") 'mu4e-view-headers-next)
  (peng-local-set-key (kbd "<C-up>") 'mu4e-view-headers-prev)

  (peng-local-set-key (kbd "a") 'mu4e-view-action)
  (peng-local-set-key (kbd "A") 'mu4e-view-attachment-action)
  (peng-local-set-key (kbd "<C-return>") 'mu4e-view-open-attachment)
  (peng-local-set-key (kbd "<M-return>") 'mu4e-view-attachment-action)


  (peng-mu4e-key-binding)
  )

(add-hook 'mu4e-view-mode-hook 'peng-mu4e-view-mode)

(defun peng-mu4e-header-mode ()
  (interactive)

  (peng-local-set-key (kbd "<return>") 'mu4e-headers-view-message)
  (peng-local-set-key (kbd "RET") 'mu4e-headers-view-message)
  (peng-local-set-key (kbd "q") 'mu4e~headers-quit-buffer)
  (peng-local-set-key (kbd "D") 'mu4e-headers-mark-for-delete)
  (peng-local-set-key (kbd "d") 'mu4e-headers-mark-for-trash)
  (peng-local-set-key (kbd "u") 'mu4e-headers-mark-for-unmark)
  (peng-local-set-key (kbd "U") 'mu4e-mark-unmark-all)
  (peng-local-set-key (kbd "x") 'mu4e-mark-execute-all)
  (peng-local-set-key (kbd "g") 'mu4e-headers-rerun-search)
  
  (peng-mu4e-key-binding)
  )

(defun peng-mu4e-key-binding ()
  (interactive)
  (peng-local-set-key (kbd "s") 'mu4e-headers-search)
  (peng-local-set-key (kbd "b") 'mu4e-headers-search-bookmark)
  (peng-local-set-key (kbd "J") 'mu4e~headers-jump-to-maildir)
  )

(add-hook 'mu4e-headers-mode-hook 'peng-mu4e-header-mode)


;; View html message in firefox (type aV)
(add-to-list 'mu4e-view-actions
'("ViewInBrowser" . mu4e-action-view-in-browser) t)

(provide 'init-mu4e)
