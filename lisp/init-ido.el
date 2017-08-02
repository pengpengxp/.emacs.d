;; Use C-f during file selection to switch to regular find-file

;; `ido'中的空格不是我喜欢的，加上使用`ido-better-flex'可以满足但是
;; `smex'又太慢。暂时先不开了。

(require 'ido)
(require 'ido-vertical-mode)
;; (require 'ido-complete-space-or-hyphen)
(require 'idomenu)

;;; ido-hacks可以使ido在尽可能多的地方使用，这样可以几乎很少开helm了
(require 'ido-hacks)
;;; 这里不能使用这种形式，没用，只能手动开启
;;; helm卸载后这就可以了
;; (ido-hacks-mode)

;;; 开启flex后我的Macbook Air太慢了，配置高了再说吧
(require 'ido-better-flex)
(ido-better-flex/disable)

(ido-mode 1)

;; (peng-global-set-key (kbd "C-h v") 'ido-describe-variable)
;; (peng-global-set-key (kbd "C-h f") 'ido-describe-function)

(ido-vertical-mode 1)
(ido-toggle-regexp)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; (setq ido-use-filename-at-point 'guess)	;可以自动识别当前`point'在的目录。好像没太大用

;;; 设定ido显示的排列方式
(setq ido-file-extensions-order
'(".org" ".c" ".lisp" ".sh" ".tex" ".pdf" ".txt" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))

;;; 这句以后可以设置变量`completion-ignored-extensions'来让`ido'ignore这些东西
(setq ido-ignore-extensions t)
;;; ignore case when search
(setq ido-case-fold t)

;;; 可以在使用ido的时候显示`.'表示当前目录，避免有些时候不能使用
(setq ido-show-dot-for-dired t)

;;; 使用`ido'来跳转bookmark
(defun ido-bookmark-jump ()
  (interactive)
  (bookmark-jump
       (ido-completing-read "Jump to bookmark: " (bookmark-all-names))))

(defun ido-yank ()
  "Select a kill to yank with `ido-completing-read'."
  (interactive)
  (insert-for-yank (ido-completing-read "Select kill: " kill-ring)))


(defun ido-sudo-find-file (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun ido-recentf-find-file ()
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file (find-file file))))

(defun ido-cache (pred &optional recalc)
  "Create a cache of symbols from `obarray' named after the
predicate PRED used to filter them."
  (let ((cache (intern (concat "ido-cache-" (symbol-name pred)))))
    (when (or recalc (not (boundp cache)))
      (set cache nil)
      (mapatoms (lambda (s)
                  (when (funcall pred s)
                    (push (symbol-name s) (symbol-value cache))))))
    (symbol-value cache)))

(defun ido-recalculate-all-caches ()
  "Recalculate the `ido-cache' of `functionp', `commandp' and
`boundp'."
  (interactive)
  (ido-cache 'commandp  t)
  (ido-cache 'functionp t)
  (ido-cache 'boundp    t)
  t)


;;; 这两个函数默认不能使用光标当前的文字，比起helm有点不好，默认不使用，
;;; 当开启了ido-hack-mode，`describe-function'自动就可以调用ido了。
(defun ido-describe-function (&optional at-point)
  "ido replacement for `describe-function'."
  (interactive "P")
  (describe-function
   (intern
    (ido-completing-read
     "Describe function: "
     (ido-cache 'functionp) nil nil
     (and at-point (function-called-at-point)
           (symbol-name it))))))

(defun ido-describe-variable (&optional at-point)
  "ido replacement for `describe-variable'."
  (interactive "P")
  (describe-variable
   (intern
    (ido-completing-read
     "Describe variable: "
     (ido-cache 'boundp) nil nil
     (and at-point (thing-at-point 'symbol) (format "%s" it))))))

(defun ido-find-function ()
  (interactive)
  (find-function (intern (ido-completing-read "Function: " (ido-cache 'functionp)))))

(defun ido-describe-variable-at-point ()
  (interactive)
  (ido-describe-variable t))

;;; *****************************from the wiki***********************************
(defun peng-ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapatoms (lambda (x)
		(push (prin1-to-string x t) tag-names))
	      tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

;; ;;; SPC选择，回车直接打开目录
;; (defun ido-smart-select-text ()
;;   "Select the current completed item.  Do NOT descend into directories."
;;   (interactive)
;;   (when (and (or (not ido-require-match)
;; 		 (if (memq ido-require-match
;; 			   '(confirm confirm-after-completion))
;; 		     (if (or (eq ido-cur-item 'dir)
;; 			     (eq last-command this-command))
;; 			 t
;; 		       (setq ido-show-confirm-message t)
;; 		       nil))
;; 		 (ido-existing-item-p))
;; 	     (not ido-incomplete-regexp))
;;     (when ido-current-directory
;;       (setq ido-exit 'takeprompt)
;;       (unless (and ido-text (= 0 (length ido-text)))
;; 	(let ((match (ido-name (car ido-matches))))
;; 	  (throw 'ido
;; 		 (setq ido-selected
;; 		       (if match
;; 			   (replace-regexp-in-string "/\\'" "" match)
;; 			 ido-text)
;; 		       ido-text ido-selected
;; 		       ido-final-text ido-text)))))
;;     (exit-minibuffer)))
;; (eval-after-load "ido"
;;   '(define-key ido-common-completion-map "\C-m" 'ido-smart-select-text))
;;; *****************************from the wiki***********************************

;;; 这样的`SPC'和`tab'才是我想要的
(defun peng-ido-define-key ()
  (interactive)
  (define-key ido-common-completion-map (kbd "SPC") 'ido-restrict-to-matches)
  (define-key ido-file-completion-map (kbd "SPC") 'ido-restrict-to-matches)
  (define-key ido-common-completion-map (kbd "<tab>") 'ido-exit-minibuffer)
  (define-key ido-common-completion-map (kbd "TAB") 'ido-exit-minibuffer)
  (define-key ido-common-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-common-completion-map (kbd "C-p") 'ido-prev-match)
  (define-key ido-common-completion-map (kbd "<down>") 'ido-next-match)
  (define-key ido-common-completion-map (kbd "<up>") 'ido-prev-match)
  )
(add-hook 'ido-setup-hook 'peng-ido-define-key)

                                        ;这样的<tab>才是我想要的。但是开启后`helm'用着不行了。关闭`ido-mode'就行。但是这样对smex无效。
;; (define-key minibuffer-local-map [tab] 'ido-exit-minibuffer) 

;;; ido-fasd
(defun peng-ido-fasd-find-file ()
  (interactive)
  (let* ((ido-candidats (split-string  (shell-command-to-string "fasd -a|awk '{print $2}'") "\n"))
         (ido-results (ido-completing-read "test: " ido-candidats)))
    (find-file ido-results)))

;;; ido-jump
(defun peng-ido-jump ()
  (interactive)
  (let* ((ido-list (list "Google"
			 "Baidu"
			 ))
	 (ido-result (ido-completing-read "Which do you want to jump: " ido-list)))
    (cond ((equal ido-result "Google") (peng-ido-jump-google-function))
	  ((equal ido-result "Baidu") (peng-ido-jump-baidu-function))
	  (t (message "None")))))
(defun peng-ido-jump-google-function ()
  (browse-url (concat "http://www.google.com.hk/search?q="
		      (format "%s" (read-minibuffer "google for what: ")))))
(defun peng-ido-jump-baidu-function ()
  (browse-url (concat "https://www.baidu.com/s?wd="
		      (format "%s" (read-minibuffer "baidu for what: ")))))

(defun peng-ido-insert-ls-and-grep ()
  (interactive)
  (let* ((pattern (read-from-minibuffer "Pattern: " "."))
         (result (ido-completing-read "Choose: "
                                      (split-string (shell-command-to-string
                                                     (concat "ls|grep -i "
                                                             pattern))
                                                    "\n"))))
    (insert result)))

;;; ------------------------------------------------------------------
;;; 
;;; 有bug
;;; 
;;; ------------------------------------------------------------------
;; (defun peng-ido-insert-ls-and-grep-hanzi ()
;;   "为了使用ido把汉字转化为拼音，输出的时候再转化回来。有bug"
;;   (interactive)
;;   (let* ((pattern (read-from-minibuffer "Pattern: " "."))
;; 	 (ido-list (split-string (shell-command-to-string
;; 				  (concat "ls|grep -i "
;; 					  pattern))
;; 				 "\n"))
;; 	 (ido-list-hanzi (mapcar 'pyim-hanzi2pinyin ido-list))
;; 	 (pinyin-result (ido-completing-read "Choose: "
;; 					     ido-list-hanzi))
;; 	 (index 0)
;; 	 )
;;     (unless (equal pinyin-result (nth index ido-list-hanzi))
;;       (setq index (1+ index)))
;;     (insert (nth index ido-list))))

(defun peng-ido-completing-pinyin-read (Prompt list)
  "可以读拼音"
  (let* ((list-pinyin (mapcar 'pyim-hanzi2pinyin list))
	 (index 0)
	 (ido-result (ido-completing-read Prompt list-pinyin))
	 (done 1)
	 (length-of-list (length list)))
    (while (> done 0)
      (if (string= ido-result
		   (nth index list-pinyin))
	  (setq done 0)
	(progn
	  (setq index (1+ index))
	  (if (>= index length-of-list)
	      (setq done 0)))))
    (nth index list)))

(defun peng-ido-insert-ls-and-grep ()
  (interactive)
  (let* ((pattern (read-from-minibuffer "Pattern: " "."))
         (result (ido-completing-read  "Choose: "
                                       (split-string (shell-command-to-string
                                                      (concat "ls|grep -i "
                                                              pattern))
                                                     "\n"))))
    (insert result)))
;;; ------------------------------------------------------------------

(provide 'init-ido)
