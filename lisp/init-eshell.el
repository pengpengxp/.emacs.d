;;; eshell mode
(require 'shell-switcher)		;我使用shell-switcher来切换我的eshell
(setq shell-switcher-mode t)

(setq eshell-glob-case-insensitive t)	;glob不区分大小写
(setq eshell-error-if-no-glob t)	;如果glob出现不匹配则认为出错，这和zsh是一样的，和bash不同
(setq eshell-cmpl-ignore-case t)	;在补全filename的时候不区分大小写
(setq eshell-history-size 10000)	;记录很多命令，方便直接调用

;;; copy from the website
(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)
;;; copy from the website

;;; 自己写的`advice'。将`buffer-name'修改为当前目录。只是我的个人习惯
(defadvice eshell/cd (after peng-eshell-change-buffer-name activate)
  (rename-buffer (concat "*eshell*:"
		       default-directory) t))

;;; 同时对这几个函数也做一些`advice'。每次进入都会显示当前目录了
(defadvice shell-switcher-switch-buffer (after peng-eshell-change-buffer-name activate)
  (rename-buffer (concat "*eshell*:"
		       default-directory) t))
(defadvice shell-switcher-new-shell (after peng-eshell-change-buffer-name activate)
  (rename-buffer (concat "*eshell*:"
		       default-directory) t))

;;; 这个find-file比我自己定义的好很多。可以同时打开多个文件。我最后定
;;; 义了两个alias
(defun eshell/ff (&rest args)
  "Opens a file in emacs."
  (when (not (null args))
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))

(defun eshell/f (&rest args)
  "Opens a file in emacs."
  (when (not (null args))
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))

(if (string= system-type "darwin")
;;; 照着`eshell/ff'定义了一个`eshell/o'函数
    (defun eshell/o (&rest args)
      "Opens a file in emacs."
      (when (not (null args))
	(mapc '(lambda (a)
		 (shell-command (concat "open "
					a)))
	      (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))
  )

(defun eshell/lg (&rest args)
  "因为经常使用`ls|grep xxx'这样的命令，就自己包装了一个"
  (when (not (null args))
    (shell-command-to-string (concat "ls|grep -i "
				     (format "%s" (car args))))))

(defun eshell/idolg (&rest args)
  "调用ido来读取`ls|grep xxx'的结果"
  (if (not (null args))
      (progn
	(setq result (ido-completing-read "Which one: "
					  (split-string
					   (shell-command-to-string (concat "ls|grep -i "
									    (format "%s" (car args)))) "\n"))))
    (progn
      (setq result (ido-completing-read "Which one: "
					(split-string
					 (shell-command-to-string "ls|grep -i .") "\n"))))))


(if (string-equal system-type "darwin")
    (progn
      (defun eshell/lfdeepa (&rest args)
	"使用find来递归地查找当前目录中名为args的文件，还可以通过
使用gnu/find中的-maxdepth选项来控制递归的深度，异步执行"
	(when (not (null args))
	  (async-shell-command (concat "gfind -type f -name '*"
					   (format "%s" (car args))
					   "*'"))))
      (defun eshell/lfnodeep (&rest args)
	"使用find来递归地查找当前目录中名为args的文件，还可以通过
使用gnu/find中的-maxdepth选项来控制递归的深度，同步执行"
	(when (not (null args))
	  (shell-command-to-string (concat "gfind -maxdepth 1 -name '*"
					   (format "%s" (car args))
					   "*'"))))
      (defun eshell/lf (&rest args)
        (when (not (null args))
          (cond ((= (length args) 1)
                 (shell-command-to-string (concat "gfind -name '*"
                                                  (format "%s" (car args))
                                                  "*'")))
                ((= (length args) 2)
                 (shell-command-to-string (concat "gfind "
                                                  (format "%s" (car args))
                                                  " -name '*"
                                                  (format "%s" (car (cdr args)))
                                                  "*'")))

                ((= (length args) 3)
                 (shell-command-to-string (concat "gfind "
                                                  (format "%s" (car args))
                                                  " -name '*"
                                                  (format "%s" (car (cdr args)))
                                                  "*'"
                                                  " -name '*"
                                                  (format "%s" (car (cdr (cdr args))))
                                                  "*'"
                                                  )
                                          )))))


      (defun eshell/idoff (&rest args)
	"调用ido来读取eshell/lf的结果"
	(if (not (null args))
	    (progn
	      (setq result (ido-completing-read "Which one: "
						(split-string
						 (shell-command-to-string (concat "gfind -type f -name '*"
										  (format "%s" (car args))
										  "*' &")) "\n"))))
	  (progn
	    (setq result (ido-completing-read "Which one: "
					      (split-string
					       (shell-command-to-string (concat "gfind -type f -name '*' &")) "\n"))))))
      )

  )

(if (string-equal system-type "gnu/linux")
    (progn
      (defun eshell/lf (&rest args)
	"使用find来递归地查找当前目录中名为args的文件，还可以通过
使用gnu/find中的-maxdepth选项来控制递归的深度，"
	(when (not (null args))
	  (shell-command-to-string (concat "find -type f -name '*"
					   (format "%s" (car args))
					   "*'"))))
      (defun eshell/idoff (&rest args)
	"调用ido来读取eshell/lf的结果"
	(if (not (null args))
	    (progn
	      (setq result (ido-completing-read "Which one: "
						(split-string
						 (shell-command-to-string (concat "find -type f -name '*"
										  (format "%s" (car args))
										  "*' &")) "\n"))))
	  (progn
	    (setq result (ido-completing-read "Which one: "
					      (split-string
					       (shell-command-to-string (concat "find -type f -name '*' &")) "\n"))))))))

(defalias 'eshell/idofind 'eshell/idoff)  ;这只是一个alias

;;; 根据我的个人爱好设置一下company-mode在eshell中的补全，这个在有了
;;; `eshell-ido-pcomplete'后就可能用得少了

(defun peng-eshell-company-files ()
  (interactive)
  (company-begin-backend 'company-files)
  )

(defun peng-ivy-eshell-history ()
  "use ido-style to read  eshell-history"
  (interactive)
  (let* ((index 0)
	 (peng-ido-eshell-list nil)
	 (end (point))
	 (beg (save-excursion (eshell-bol) (point)))
	 (input (buffer-substring beg end)))
    (while (<= index eshell-history-size)
      (add-to-list 'peng-ido-eshell-list (eshell-get-history index))
      (setq index (1+ index)))
    (setq peng-ido-eshell-list (delete-dups (reverse peng-ido-eshell-list)))
    (if (equal input "")
	(insert (ivy-read "Eshell-history: " peng-ido-eshell-list))
      (goto-char beg)
      (kill-line)
      (insert (ivy-read "Eshell-history: " peng-ido-eshell-list
                                   nil
                                   nil
                                   :initial-input input)))))

(defun peng-ido-eshell-history ()
  "use ido-style to read  eshell-history"
  (interactive)
  (let* ((index 0)
	 (peng-ido-eshell-list nil)
	 (end (point))
	 (beg (save-excursion (eshell-bol) (point)))
	 (input (buffer-substring beg end)))
    (while (<= index eshell-history-size)
      (add-to-list 'peng-ido-eshell-list (eshell-get-history index))
      (setq index (1+ index)))
    (setq peng-ido-eshell-list (delete-dups (reverse peng-ido-eshell-list)))
    (if (equal input "")
	(insert (ido-completing-read "Eshell-history: " peng-ido-eshell-list))
      (goto-char beg)
      (kill-line)
      (insert (ido-completing-read "Eshell-history: " peng-ido-eshell-list
                                   nil
                                   nil
                                   input)))))
(defun peng-eshell-mode-hook ()
  ;; (linum-mode 1)
  (peng-local-set-key (kbd "C-r") 'peng-ivy-eshell-history)
  (peng-local-set-key (kbd "C-a") 'eshell-bol)
  (peng-local-set-key (kbd "C-e") 'move-end-of-line)
  (setq eshell-last-dir-ring-size 200)	;记录200个目录

  ;; `eshell'中打开`company-mode'后只想开`company-files'这一个backend
  (company-mode -1)
  )

(add-hook 'eshell-mode-hook 'peng-eshell-mode-hook)

;;; ielm-mode hook
(defun peng-ielm-mode-hook ()
  (company-mode -1))
(add-hook 'ielm-mode-hook 'peng-eshell-mode-hook)

(if (string= system-type "darwin")
    (defun eshell/pengpwd ()
      "copy current dirctory to clipboard, only usefull on mac"
      (shell-command-to-string "pwd|pbcopy")))



(defun eshell/clear ()
  "Clears the shell buffer ala Unix's clear or DOS' cls"
  ;; the shell prompts are read-only, so clear that for the duration
  (let ((inhibit-read-only t))
    ;; simply delete the region
    (delete-region (point-min) (point-max))))

(defalias 'eshell/c  'eshell/clear)
;; (defun eshell/vi (arg)
;;   "use vi as find-file"
;;   (find-file arg))

;;; 后面这几个以`,'号开头的命令使用很少
(defun eshell/cj ()
  "jump to bookmark"
  (let ((temp (completing-read "Bookmarks: " (bookmark-all-names))))
    (bookmark-jump temp)))

(defun eshell/\,cj ()
  "jump to bookmark"
  (let ((temp (completing-read "Bookmarks: " (bookmark-all-names))))
    (bookmark-jump temp)))

;; (defun eshell/\,xb ()
;;   "switch buffer in eshell"
;;   (let ((buffer (completing-read "Buffers: " 
;; 				 (mapcar 'buffer-name (buffer-list)))))
;;     (switch-to-buffer buffer)))

(defun eshell/\,xb ()
  "switch buffer in eshell"
  (let ((buffer (buffer-name (other-buffer))))
    (switch-to-buffer buffer)))

(defun eshell/\,xf ()
  "use xf as find-file"
  (let ((file (read-file-name "FILE: ")))
    (find-file file)))

(defun eshell/\,cu ()
  "winner-undo"
  (winner-undo))

(defun eshell/\,cr ()
  "winner-redo"
  (winner-redo))

(defun eshell/\,ca ()
  "org-agenda"
  (org-agenda))


;;; 这儿使用`helm-esh-pcomplete'有bug。只能使用`completion-at-point'，
;;; 结果使用`completion-at-point'补全中文的时候出现多于的`\'。所以换回
;;; 来了。凑合着先用着。
;; (add-hook 'eshell-mode-hook
;;           #'(lambda ()
;;               (define-key eshell-mode-map
;;                 [remap eshell-pcomplete]
;;                 'helm-esh-pcomplete)))

;; ;;;; quik jump in eshell，这个使用很少，下面的`eshell/j'很好用
;; (require 'eshell-z)			
;; (cond ((string-equal system-type "darwin")
;;        (defun eshell/zo (arg)
;; 	 "zo to open current directory"
;; 	 (peng-async-shell-command (concat "open "
;; 					   arg
;; 					   "&"))))
;;       )

;;; 看了别人的配置，自己定制的，可以使用结合helm来跳转和打开目录
;; (defun eshell/j ()
;;   "Quickly jump to previous directories."
;;   (eshell/cd (helm-comp-read "Jump to directory: "
;;                                   (delete-dups (ring-elements eshell-last-dir-ring)))))


;;; 这个配合`ido'使用很方便
(defun eshell/j ()
  "Quickly jump to previous directories."
  (eshell/cd (ido-completing-read "Jump to directory: "
                                  (delete-dups (ring-elements eshell-last-dir-ring)))))

(if (string= system-type "darwin")
    (defun eshell/jo ()
      "Quickly jump to previous directories."
      (let ((result (helm-comp-read "Open the directory: "
				    (delete-dups (ring-elements eshell-last-dir-ring)))))
	(peng-async-shell-command (concat "open " result)))))

;;; pengpengxp's eshell prompt
(defun my-current-git-branch ()
  (let ((branch (car (loop for match in (split-string (shell-command-to-string "git branch") "\n")
                           when (string-match "^\*" match)
                           collect match))))
    (if (not (eq branch nil))
        (concat " [" (substring branch 2) "]")
      "")))

(defun pengpengxp-eshell-prompt ()
  (concat (propertize (abbreviate-file-name (eshell/pwd)) 'face 'eshell-prompt)
          (propertize (my-current-git-branch) 'face 'font-lock-function-name-face)
          (propertize " $ " 'face 'font-lock-constant-face)))

(setq eshell-prompt-function #'pengpengxp-eshell-prompt)

;; ;; ********************************copy from others********************************
;; ;; 可以比较智能，但是我暂时没使用
;; (defun user-tab ()
;;   (interactive)
;;   (let ((input (eshell-get-old-input)))
;;     (if (string-equal input "")
;;         (insert-string "cd ")
;;       (progn
;;         (cond
;;          ((string-equal input "cd  ")
;;           (delete-backward-char 1)
;;           (insert-string "-0"))
;;          ((string-match "^cd\\ -[0-9]+$" input)
;;           (let ((len (length input)))
;;             (delete-backward-char (- len 4))
;;             (insert-string (1+ (read(substring input 4 len))))))
;;          (t
;;           (pcomplete))
;;          )))))

;; ;; * ret
;; (defun user-ret ()
;;   (interactive)
;;   (let ((input (eshell-get-old-input)))
;;     (if (string-equal input "")
;;         (progn
;;           (insert-string "ls")
;;           (eshell-send-input))
;;       (progn
;;         (cond
;;          ((string-match "^cd\\ \\.\\{2,\\}$" input)
;;           (let ((len (- (length input) 5))
;;                 (dots (lambda (n d)(if (<= n 0) nil (concat (funcall dots (1- n) d) d)))))
;;             (eshell-bol)(kill-line)
;;             (insert-string (concat "cd .." (funcall dots len "/..")))
;;             (eshell-send-input)))
;;          ((string-match "^\\.\\{2,\\}$" input)
;;           (let ((len (- (length input) 2))(p ".."))
;;             (while (> len 0)
;;               (setq len (1- len))(setq p (concat p "/..")))
;;             (eshell-bol)(kill-line)
;;             (insert-string p)
;;             (eshell-send-input)))
;;          (t
;;           (eshell-send-input))))
;;       )))

;; ;; * spc
;; (defun user-spc ()
;;   (interactive)
;;   (let ((input (eshell-get-old-input)))
;;     (if (string-equal input "")
;;         (insert-string "!-1")
;;       (progn
;;         (cond
;;          ((string-match "^!-[0-9]+$" input)
;;           (let ((len (length input)))
;;             (delete-backward-char (- len 2))
;;             (insert-string (1+ (read(substring input 2 len))))))
;;          (t
;;           (self-insert-command 1))
;;          )))))

;; ;; * del
;; ;; (defun user-del ()
;; ;;   (interactive)
;; ;;   (let ((input (eshell-get-old-input)))
;; ;;     (if (string-equal input "")
;; ;;         (progn
;; ;;           (insert-string "..")
;; ;;           (eshell-send-input))
;; ;;         (delete-backward-char 1)
;; ;;         )))

;; ;; ********************************copy from others********************************


;;; ****************************************************************
;;;
;;; 可以使`ei,vi'等命令在eshell中不敲回车直接就调用`ido-find-file'
;;; 
;;; ****************************************************************
(defvar eshell-auto-executable-commands '(ei\  vi\  ri\  hi\  di\  )
  "允许自动执行的command")
;;; 把这两个命令定义成alias就可以了，注意上面的空格有`\'，下面的没有，
;;; 但是应该把` '的位置留出来
(defalias 'eshell/ei  'ido-find-file)
(defalias 'eshell/vi  'ido-find-file)
;; (defalias 'eshell/ri  'ido-recentf-find-file)
(defalias 'eshell/ri  'counsel-recentf)
;; (defalias 'eshell/hi  'peng-ido-eshell-history)
(defalias 'eshell/hi  'peng-ivy-eshell-history)
(defalias 'eshell/di  'iterm-goto-filedir-or-home)

(defun eshell-auto-execute-commands ()
  "自动执行command"
  (when (and (eq major-mode 'eshell-mode)
	     (cl-member-if (lambda (x)
			     "判断已输入的命令是否在`eshell-auto-executable-commands'中"
			     (string= (eshell-get-old-input) (format "%s" x)))
			   eshell-auto-executable-commands))
    (eshell-send-input)))

(defun turn-on-eshell-auto-execute-commands ()
  "开启自动执行command,开启后,只要输入的命令在变量
`eshell-auto-executable-commands'中,则会自动执行,不需要按回车"
  (interactive)
  (unless (eq major-mode 'eshell-mode)
    (error "只能在eshell-mode下开启自动执行command"))
  (add-hook 'post-self-insert-hook #'eshell-auto-execute-commands t t))
(defun turn-off-eshell-auto-execute-commands ()
  "关闭自动执行command"
  (interactive)
  (remove-hook 'post-self-insert-hook #'eshell-auto-execute-commands t))

(add-hook 'eshell-mode-hook 'turn-on-eshell-auto-execute-commands)

;;; ****************************************************************
;;;
;;; 可以使用`ido'来做eshell的补全，还是有一些问题，比如不能连续补全`cd
;;; /tm'这样就不好补全，只有单个候选词的时候不能直接上屏
;;; 
;;; ****************************************************************
;; (defun ido-pcomplete ()
;;   "使用ido作为eshell的pcomplete方法"
;;   (interactive)
;;   (let* (pcomplete-stub
;; 		 (completions (pcomplete-completions))
;; 		 (completion-result (ido-completing-read ": " (all-completions pcomplete-stub completions) nil nil pcomplete-stub)))
;; 	(delete-char (- (length pcomplete-stub)))
;; 	(insert completion-result)))
;; (defun ido-pcomplete ()
;;   "使用ido作为eshell的pcomplete方法"
;;   (interactive)
;;   (let* (completion-result
;; 	 (completions (pcomplete-completions))
;; 	 (candidates (all-completions pcomplete-stub completions))
;; 	 (pcomplete-stub (replace-regexp-in-string ".*[\/]" "" pcomplete-stub))
;; 	 )
;;     (cond ((null candidates)
;; 	   (error "没有匹配项"))
;; 	  ((= 1 (length candidates))
;; 	   (setq completion-result (car candidates)))
;; 	  (t (setq completion-result (ido-completing-read ": " candidates nil nil pcomplete-stub))))
;;     (delete-char (- (length pcomplete-stub)))
;;     (insert completion-result)))

;; (add-hook 'eshell-mode-hook (lambda ()
;; 			      (define-key evil-insert-state-local-map (kbd "<tab>") 'ido-pcomplete)))

;; ;;; 这下面的用处不大
;; (defvar pcomplete-fn 'ido-pcomplete
;;   "用于补全的方法
;; 目前可以选择'eshell-pcomplete或'ido-pcomplete
;; 默认为'ido-pcomplete,但推荐'eshell-pcomplete")

;; (defun turn-on-eshell-auto-pcomplete ()
;;   "开启自动执行pcomplete补全
;; 开启后,每输入一个字符,都会自动调用eshell-pcomplete进行补全"
;;   (interactive)
;;   (unless (eq major-mode 'eshell-mode)
;;     (error "只能在eshell-mode下开启自动执行command"))
;;   (add-hook 'post-self-insert-hook pcomplete-fn t t))

;; (defun turn-off-eshell-auto-pcomplete ()
;;   "关闭自动执行pcomplete不全"
;;   (interactive)
;;   (remove-hook 'post-self-insert-hook pcomplete-fn t))

(defun eshell-ido-pcomplete--input-lisp-p()
  "判断eshell的输入是否为lisp
以(开头的输入被认为是lisp"
  (= ?\( (elt (eshell-get-old-input) 0)))

(defun eshell-ido-pcomplete--incomplete-input-lisp-function-p()
  "判断待补全的输入是否为函数,若为函数,则返回待补全的输入,否则返回nil"
  (when (eshell-ido-pcomplete--input-lisp-p)
    (save-excursion
      (let ((cur-point (point))
	    (delim-point (search-backward-regexp  "([ \t\r\n]*\\|'\\|[^( \t\r\n][ \t\r\n]+")))
	(if (= ?\( (char-after delim-point))
	    (string-trim (buffer-substring-no-properties (+ 1 delim-point) cur-point))
	  nil)))))

(defun eshell-ido-pcomplete--incomplete-input-lisp-symbol-p()
  "判断待补全的输入是否为symbol,若为symbol,则返回待补全的输入,否则返回nil"
  (when (eshell-ido-pcomplete--input-lisp-p)
    (save-excursion
      (let ((cur-point (point))
	    (delim-point (search-backward-regexp "([ \t\r\n]*\\|'\\|[^( \t\r\n][ \t\r\n]+")))
	(if (= ?\' (char-after delim-point))
	    (string-trim (buffer-substring-no-properties (+ 1 delim-point) cur-point))
	  nil)))))

(defun eshell-ido-pcomplete--incomplete-input-lisp-variable-p()
  "判断待补全的输入是否为变量,若为变量,则返回待补全的输入,否则返回nil"
  (when (eshell-ido-pcomplete--input-lisp-p)
    (save-excursion
      (let ((cur-point (point))
	    (delim-point (search-backward-regexp "([ \t\r\n]*\\|'\\|[^( \t\r\n][ \t\r\n]+")))
	(if (find (char-after (1+ delim-point)) " )")
	    (string-trim (buffer-substring-no-properties (+ 1 delim-point) cur-point))
	  nil)))))

(defun eshell-ido-pcomplete--special-form-or-function-p (object)
  "判断object是function或special-form"
  (or (functionp object)
      (special-form-p object)))

(defun eshell-ido-pcomplete--pcomplete-completions()
  "用于eshell-ido-pcomplete中生产补全内容的函数,会设置变量`pcomplete-stub'为待补全的内容,并返回补全的后选项"
  (let (completions)
    (cond ((setq pcomplete-stub (eshell-ido-pcomplete--incomplete-input-lisp-function-p))
	   (mapatoms (lambda (x)
		       (when (eshell-ido-pcomplete--special-form-or-function-p x)
			 (push x completions))))
	   completions)
	  ((setq pcomplete-stub (eshell-ido-pcomplete--incomplete-input-lisp-variable-p))
	   (mapatoms (lambda (x)
		       (unless (eshell-ido-pcomplete--special-form-or-function-p x)
			 (push x completions))))
	   completions)
	  ((setq pcomplete-stub (eshell-ido-pcomplete--incomplete-input-lisp-symbol-p))
	   (mapatoms (lambda (x)
		       (push x completions)))
	   completions)
	  (t (pcomplete-completions)))))

(defun eshell-ido-pcomplete ()
  "使用ido作为eshell的pcomplete方法"
  (interactive)
  ;; @ To simplify completion function logic, the tag `pcompleted' may be thrown with a value of nil in order to abort the function.  It means that there were no completions available.
  (catch 'pcompleted
    (let* (completion-result
	   (completions (eshell-ido-pcomplete--pcomplete-completions))
	   (candidates (all-completions pcomplete-stub completions))
	   (pcomplete-stub (replace-regexp-in-string ".*[\/]" "" pcomplete-stub))
	   )
      (cond ((null candidates)
	     (error "没有匹配项"))
	    ((= 1 (length candidates))
	     (setq completion-result (car candidates)))
	    (t (setq completion-result (ido-completing-read ": " candidates nil nil pcomplete-stub))))
      (delete-char (- (length pcomplete-stub)))
      (insert (eshell-quote-argument completion-result)))))

(add-hook 'eshell-mode-hook (lambda ()
			      (define-key evil-insert-state-local-map (kbd "<tab>") 'eshell-ido-pcomplete)
                              ))

(defadvice eshell/grep (after peng-eshell-change-buffer-name activate)
  (switch-to-buffer "*grep*")
  (delete-other-windows)
  (kill-buffer "*compilation*")
  )
;;; 将就把`rgrep'和`grep'的advice定义在这里
(defadvice rgrep (after peng-rgrep activate)
  (switch-to-buffer "*grep*")
  (delete-other-windows)
  (kill-buffer "*compilation*")
  )
(defadvice grep (after peng-grep activate)
  (switch-to-buffer "*grep*")
  (delete-other-windows)
  (kill-buffer "*compilation*")
  )


(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
  current buffer's file. The eshell is renamed to match that
  directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

;;; to fix a bug of eshell
;;; `http://emacs.stackexchange.com/questions/2107/run-application-in-cwd-on-remote-host-from-within-eshell'
(defadvice eshell-gather-process-output (before absolute-cmd (command args) act)
  (setq command (file-truename command)))

;;; for remote exec
(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path) ;This can make emacs recognize remote PATH
;; (add-to-list 'tramp-remote-path "/root/bin")


(defalias 'eshell/e' eshell/exit)  ;快速退出
(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))


(provide 'init-eshell)
