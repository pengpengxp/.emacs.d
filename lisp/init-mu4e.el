(require 'mu4e)

;; default
(setq mu4e-maildir (expand-file-name "~/mutt_mail"))
(setq mu4e-get-mail-command "offlineimap")
(evil-set-initial-state 'mu4e-main-mode 'emacs)
(evil-set-initial-state 'mu4e-headers-mode 'emacs)
(evil-set-initial-state 'mu4e-view-mode 'emacs)
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

(provide 'init-mu4e)
