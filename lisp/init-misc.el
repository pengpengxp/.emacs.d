;;; init make-it-so make it so
(mis-config-default)

;; for unzip chinese charactor file which are ziped on windows
(setenv "UNZIP" "-O CP936")
(setenv "ZIPINFO" "-O CP936")

(provide 'init-misc)
