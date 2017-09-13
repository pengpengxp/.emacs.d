;;; init-test.el --- 

;;;This is where I make some test


;; (ido-completing-read "测试："
;; 		     (list "xie"
;; 			   "peng"
;; 			   "谢鹏"
;; 			   "刘青"))
;; (defun peng-test ()
;;   (interactive)
;;   (let ((files
;;          (if (eq major-mode 'dired-mode)
;;              (dired-get-marked-files)
;;            (let ((default-directory (read-directory-name "dir: ")))
;;              (mapcar #'expand-file-name 
;;                      (file-expand-wildcards "*.org"))))))
;;     ;; (message "%s" files)
;;     (mapc
;;      (lambda (f)
;;        (with-current-buffer
;;            (find-file-noselect f)
;;          (org-latex-export-to-pdf)))
;;      files)
;;     ))

;; (defun peng-fun ()
;;   (interactive)
;;   (let* (
;;          (end (point-marker))
;;          (beg (save-excursion (eshell-bol) (point)))
;;          (args (catch 'eshell-incomplete
;;                  (eshell-parse-arguments beg end)))
;;          (target
;;           (or (and (looking-back " ") " ")
;;               (buffer-substring-no-properties
;;                (save-excursion
;;                  (eshell-backward-argument 1) (point))
;;                end)))
;;          (first (car args))		; Maybe lisp delimiter "(".
;;          last)		   ; Will be the last but parsed by pcomplete.
;;     (setq helm-ec-target (or target " ")
;;           end (point)
;;           ;; Reset beg for `with-helm-show-completion'.
;;           beg (or (and target (not (string= target " "))
;;                        (- end (length target)))
;;                   ;; Nothing at point.
;;                   (progn (insert " ") (point))))
;;     (cond (
;;           ;; In eshell `pcomplete-parse-arguments' is called
;;           ;; with `pcomplete-parse-arguments-function'
;;           ;; locally bound to `eshell-complete-parse-arguments'
;;           ;; which is calling `lisp-complete-symbol',
;;           ;; calling it before would popup the
;;           ;; *completions* buffer.
;;           (t (setq last (replace-regexp-in-string
;;                          "\\`\\*" ""
;;                          (car (last (ignore-errors
;;                                       (pcomplete-parse-arguments))))))

;;              ;; (with-helm-show-completion beg end
;;              ;;   (helm :sources (helm-make-source "Eshell completions" 'helm-esh-source)
;;              ;;         :buffer "*helm pcomplete*"
;;              ;;         :keymap helm-esh-completion-map
;;              ;;         :resume 'noresume
;;              ;;         :input (and (stringp last)
;;              ;;                     (helm-ff-set-pattern last))))
;; 	     ))))


;; (defun peng-ido-eshell-pcomplete ()
;;   (interactive)
;;   (let* (
;;          (end (point-marker))
;;          (beg (save-excursion (eshell-bol) (point)))
;;          (args (catch 'eshell-incomplete
;;                  (eshell-parse-arguments beg end)))
;;          (target
;;           (or (and (looking-back " ") " ")
;;               (buffer-substring-no-properties
;;                (save-excursion
;;                  (eshell-backward-argument 1) (point))
;;                end)))
;;          (first (car args)) ; Maybe lisp delimiter "(".
;;          last)
;;     target))

;; (defun peng-fun  ( )
;;   (interactive)
;;   (let* ((end (point-marker))
;; 	 (beg (save-excursion (eshell-bol) (point)))
;; 	 (args (catch 'eshell-incomplete
;;                  (eshell-parse-arguments beg end)))
;; 	 (input-command (replace-regexp-in-string
;; 		     "\\`\\*" ""
;; 		     (car (last (ignore-errors
;; 				  (pcomplete-parse-arguments)))))))
;;   ;; (ido-completing-read "test:" (pcomplete-completions) nil nil input-command)
;;   (ido-completing-read "test:" (pcomplete-completions))
;;   ))

(require 'cnfonts)
;; 让 cnfonts 随着 Emacs 自动生效。
(cnfonts-enable)
;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
;; (cnfonts-set-spacemacs-fallback-fonts)

(provide 'init-test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defun peng-test (key)
;;   (interactive)
;;   (insert key))

;; (define-prefix-command 'peng-test-map)
;; (define-key global-map (kbd ",") 'peng-test-map)
;; (define-key global-map (kbd ",xf") 'find-file)
;; (define-key global-map (kbd ",xb") 'switch-to-buffer)


;; (define-key global-map (kbd ",xr") '(lambda ()
;; 				      (interactive)
;; 				      (peng-test ",xr")))

;; (define-key global-map (kbd "<f12>") '(lambda ()
;; 					(interactive)
;; 					(message "xipeng")))


;; (defmacro peng-kk ()
;;   ""
;;   (interactive)
;;   `(define-key global-map (kbd "<f12>") '(lambda ()
;; 					(interactive)
;; 					(message "xiepeng ni ha wos dfsdfso"))))

;; (macroexpand '(peng-kk))

;; (define-key global-map (kbd "<f12>") (quote (lambda nil (interactive) (message "xiepeng ni h stwetrao"))))

;;; test for ivy read pinyin
