;; (add-to-list 'load-path "~/.emacs.d/elpa/swiper-20170328.737")

;;; `ivy-initial-inputs-alist'可以控制使用 ivy 补全函数的默认输入

(require 'ivy)
(require 'swiper)
(require 'counsel)
(require 'imenu-anywhere)


(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
;; (setq ivy-ignore-buffers '("\\` " "\\`\\*"))


(defun my-ivy-switch-buffer ()
  (interactive)
  (let* ((ivy-ignore-buffers '("\\` " "\\`\\*"))
         (ivy-use-virtual-buffers nil))
    (ivy-switch-buffer)))

;; (global-set-key "\C-s" 'swiper)
;; (global-set-key "\C-r" 'swiper)

(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key [f6] 'ivy-resume)

(define-key ivy-occur-mode-map (kbd "RET") 'ivy-occur-press-and-switch)
(add-hook 'ivy-occur-mode-hook (lambda ()
                                 (interactive)
                                 (peng-local-set-key (kbd "RET") 'ivy-occur-press-and-switch)
                                 (peng-local-set-key (kbd "q") 'quit-window)
                                 ))


;; (setq ivy-re-builders-alist
;;       '(
;;         ;; "for test" can be matched by inputing "test for"
;;         (t . ivy--regex-ignore-order)
;;         ;; defult
;;         (t . ivy--regex-plus)
;;         ))


;;; actions when M-o press

(defun peng-find-file ()
  (interactive)
  (let ((filename (ivy-read "ivy-find-file: " (map 'list 'expand-file-name
                                                   (directory-files default-directory)))))
    (find-file filename)))

(defun counsel-recentf ()
  (interactive)
  (let ((file (ivy-read "Choose recent file: " recentf-list nil t)))
    (when file (find-file file))))

;; (defun ivy-yank-action (x)
;;   (kill-new x))

;; (defun ivy-copy-to-buffer-action (x)
;;   (with-ivy-window
;;     (insert x)))

;; (defun ivy-peng-test (x)
;;   (peng-write-file ivy-text))

;; (ivy-set-actions
;;  t
;;  '(("i" ivy-copy-to-buffer-action "insert")
;;    ("y" ivy-yank-action "yank")
;;    ))

(setq ivy-count-format "(%d/%d) ")

(ivy-set-occur 'counsel-git-grep 'counsel-git-grep-occur)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 让`ivy-read'支持拼音
(require 'pinyinlib)
(defun my-pinyinlib-build-regexp-string (str)
  (progn
    (cond ((equal str ".*")
           ".*")
          (t
           (pinyinlib-build-regexp-string str t))))
  )
(defun my-pinyin-regexp-helper (str)
  (cond ((equal str " ")
         ".*")
        ((equal str "")
         nil)
        (t
         str)))

(defun pinyin-to-utf8 (str)
  (cond ((equal 0 (length str))
         nil)
        ((equal (substring str 0 1) ":")
         (mapconcat 'my-pinyinlib-build-regexp-string
                    (remove nil (mapcar 'my-pinyin-regexp-helper (split-string
                                                                  (replace-regexp-in-string ":" "" str ) "")))
                    ""))
        nil))

;;; 这是我自定义的匹配策略
(defun re-builder-pinyin (str)
  (or (pinyin-to-utf8 str)
      (ivy--regex-plus str)))

(setq ivy-re-builders-alist
      '((t . re-builder-pinyin)))


;;; 主要就是操作这个变量来控制`ivy'的匹配，现在又暂时不想要pinyin的匹
;;; 配了
;; (setq ivy-re-builders-alist
;;       '(
;;         (ivy-switch-buffer . ivy--regex-ignore-order)
;;         (t . ivy--regex-plus)
;;         ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 参考是的我和abo-abo的邮件

;; I don't speak/write Chinese. But PRs welcome.

;; You can have this functionality even with just user config.  Write
;; your own regex builder and customize ivy-re-builders-alist.

;; Here's a function to get you started:

;; (defun re-builder-pinyin (str)
;;   (or (pinyin-to-utf8 str)
;;       (ivy--regex-plus str)))

;; (setq ivy-re-builders-alist
;;       '((t . re-builder-pinyin)))

;; ;; ;;; 这样就可以去掉`pinyin'区配
;; (defun pinyin-to-utf8 (str)
;;   nil)

;; Here, pinyin-to-utf8 is a function that you have to write. It takes
;; ASCII and returns UTF8 if it recognizes the input as pinyin;
;; otherwise, it returns nil.


;; You could have the start input char tell how to interpret the
;; input:

;; !wen means: use pinyin for the following word, or all following words if you want.
;; wen means: use ascii.
;; Also look at pinyinlib on MELPA.

;;; copy from `ivy.el'. in order to use `ivy-views' convinience
(defun peng-ivy-switch-buffer-to-views ()
  "Switch to another buffer with { as default value"
  (interactive)
  (let ((this-command 'ivy-switch-buffer))
    (ivy-read "Switch to buffer: " 'internal-complete-buffer
              :initial-input "{} "
              :matcher #'ivy--switch-buffer-matcher
              :preselect (buffer-name (other-buffer (current-buffer)))
              :action #'ivy--switch-buffer-action
              :keymap ivy-switch-buffer-map
              :caller 'ivy-switch-buffer)))

;;; ================================================================
;;; hack: save and load `ivy-views'                            BEGIN
;;; ================================================================
(defun peng-save-ivy-views ()
  (interactive)
  (with-temp-file "~/.emacs.d/ivy-views"
    (prin1 ivy-views (current-buffer))
    (message "save ivy-views to ~/.emacs.d/ivy-views")))
(defun peng-load-ivy-views ()
  (interactive)
  (setq ivy-views
        (with-temp-buffer
          (insert-file-contents "~/.emacs.d/ivy-views")
          (read (current-buffer))))
  (message "load ivy-views"))
(defun peng-clear-ivy-views ()
  (interactive)
  (setq ivy-views nil))
;;; add auto save
(add-hook 'kill-emacs-hook #'(lambda ()
                               (peng-save-ivy-views)))
(add-hook 'emacs-startup-hook #'(lambda ()
                               (peng-load-ivy-views)))
;;; ================================================================
;;; hack: save and load `ivy-views'                              End
;;; ================================================================

(defun ivy-insert-org-entity ()
  "Insert an org-entity using ivy."
  (interactive)
  (ivy-read "Entity: " (loop for element in (append org-entities org-entities-user)
			     when (not (stringp element))
			     collect
			     (cons 
			      (format "%10s | %s | %s | %s"
				      (car element) ;name
				      (nth 1 element) ; latex
				      (nth 3 element) ; html
				      (nth 6 element)) ;utf-8
			      element))
	    :require-match t
	    :action '(1
		      ("u" (lambda (element) (insert (nth 6 (cdr element)))) "utf-8")
		      ("o" (lambda (element) (insert "\\" (cadr element))) "org-entity")
		      ("l" (lambda (element) (insert (nth 1 (cdr element)))) "latex")
		      ("h" (lambda (element) (insert (nth 3 (cdr element)))) "html"))))

;;; set `counsel-grep-or-swiper' to use `rg' to do grep
(setq counsel-grep-base-command
 "rg -i -M 120 --no-heading --line-number --color never '%s' %s")

(add-hook 'ivy-occur-grep-mode-hook #'(lambda ()
                                        (interactive)
                                        (peng-local-set-key (kbd "RET") 'ivy-occur-press-and-switch)
                                        (peng-local-set-key (kbd "<return>") 'ivy-occur-press-and-switch)
                                        (peng-local-set-key (kbd "q") 'quit-window)
                                        (peng-local-set-key (kbd "g") 'ivy-occur-revert-buffer)
                                        ))

;; After this, your current input becomes selectable as a candidate.
;; Press C-p when you're on the first candidate to select your input
;; instead.

;; This solves the long standing issue of e.g. creating a file or a
;; directory foo when a file foobar already exists. Previously, the only
;; solution was to use C-M-j. It's still available, but now you can also
;; select your input with C-p and press RET.
(setq ivy-use-selectable-prompt t)

(provide 'init-ivy)
