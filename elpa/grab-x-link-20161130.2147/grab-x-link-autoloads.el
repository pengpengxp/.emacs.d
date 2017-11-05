;;; grab-x-link-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "grab-x-link" "grab-x-link.el" (23039 8344
;;;;;;  288446 64000))
;;; Generated autoloads from grab-x-link.el

(autoload 'grab-x-link-firefox-insert-link "grab-x-link" "\


\(fn)" t nil)

(autoload 'grab-x-link-firefox-insert-org-link "grab-x-link" "\


\(fn)" t nil)

(autoload 'grab-x-link-firefox-insert-markdown-link "grab-x-link" "\


\(fn)" t nil)

(autoload 'grab-x-link-chromium-insert-link "grab-x-link" "\


\(fn)" t nil)

(autoload 'grab-x-link-chromium-insert-org-link "grab-x-link" "\


\(fn)" t nil)

(autoload 'grab-x-link-chromium-insert-markdown-link "grab-x-link" "\


\(fn)" t nil)

(autoload 'grab-x-link "grab-x-link" "\
Prompt for an application to grab a link from.
When done, go gtab the link, and insert it at point.

If called from Lisp, grab link APP and return it (as a string) in
LINK-TYPE.  APP is a symbol and must be one of '(chromium
firefox), LINK-TYPE is also a symbol and must be one of '(plain
markdown org), if LINK-TYPE is omitted or nil, plain link will be used.

\(fn APP &optional LINK-TYPE)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; grab-x-link-autoloads.el ends here
