(require 'init-keys)
;;;ibuffer filter
(setq ibuffer-saved-filters
      '(
	("org"
	 ((or 
	   (mode . org-mode)
	   )))
	("c"
	 ((or 
	   (mode . c-mode)
	   )))
	("cpp"
	 ((or 
	   (mode . c++-mode)
	   (mode . c-mode)
	   )))
	("lisp"
	 ((or 
	   (mode . emacs-lisp-mode)
	   )))
	("sql"
	 ((or 
	   (mode . sql-mode)
	   (mode . sql-interactive-mode)
	   )))
	("dired"
	 ((or 
	   (mode . dired-mode)
	   )))
	))
(defun peng-ibuffer-filter-c-mode ()
  (interactive)
  (ibuffer)
  (ibuffer-switch-to-saved-filters "c"))
(defun peng-ibuffer-filter-c++-mode ()
  (interactive)
  (ibuffer)
  (ibuffer-switch-to-saved-filters "cpp"))
(defun peng-ibuffer-filter-org-mode ()
  (interactive)
  (ibuffer)
  (ibuffer-switch-to-saved-filters "org"))
(defun peng-ibuffer-filter-emacs-lisp-mode ()
  (interactive)
  (ibuffer)
  (ibuffer-switch-to-saved-filters "lisp"))
(defun peng-ibuffer-filter-sql-mode ()
  (interactive)
  (ibuffer)
  (ibuffer-switch-to-saved-filters "sql"))
(defun peng-ibuffer-filter-dired-mode ()
  (interactive)
  (ibuffer)
  (ibuffer-switch-to-saved-filters "dired"))


;;; 不显示某些buffer

;;; 默认不显示`*'开头的buffer
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")
(add-to-list 'ibuffer-never-show-predicates "TAGS")

;;; 下面两个函数用来自己使用，分别绑定在`ibuffer-mode'中梆到`f'和`a'上
(defun peng-ibuffer-filter-fun ()
  "进滤一些无用的buffer再显示"
  (interactive)
  (setq ibuffer-never-show-predicates nil)
  (add-to-list 'ibuffer-never-show-predicates "^\\*")
  (add-to-list 'ibuffer-never-show-predicates "TAGS")
  (ibuffer)
  )
(defun peng-ibuffer-show-all-buffer ()
  "显示所有buffer"
  (interactive)
  (setq ibuffer-never-show-predicates nil)
  (ibuffer)
  )

(defun peng-ibuffer-unshow-all-buffer ()
  "显示所有buffer"
  (interactive)
  (add-to-list 'ibuffer-never-show-predicates "^\\*")
  (ibuffer)
  )

(setq peng-ibuffer-filter-map (make-sparse-keymap))
(define-key peng-ibuffer-filter-map (kbd "o") 'peng-ibuffer-filter-org-mode)
(define-key peng-ibuffer-filter-map (kbd "c") 'peng-ibuffer-filter-c-mode)
(define-key peng-ibuffer-filter-map (kbd "e") 'peng-ibuffer-filter-emacs-lisp-mode)
(define-key peng-ibuffer-filter-map (kbd "s") 'peng-ibuffer-filter-sql-mode)
(define-key peng-ibuffer-filter-map (kbd "d") 'peng-ibuffer-filter-dired-mode)
(define-key peng-ibuffer-filter-map (kbd "p") 'peng-ibuffer-filter-c++-mode)

;;; ibuffer mode
(defun peng-ibuffer-mode ()
  (hl-line-mode 1)
  ;; (define-key (current-local-map) (kbd ",") peng-evil-insert-map)
  ;; (define-key (current-local-map) (kbd "SPC") peng-evil-normal-map)

  (define-key evil-normal-state-local-map (kbd "SPC") peng-evil-normal-map)
  (peng-local-set-key (kbd "RET") 'ibuffer-visit-buffer)

  (peng-local-set-key (kbd "a") 'peng-ibuffer-show-all-buffer)
  (peng-local-set-key (kbd "A") 'peng-ibuffer-unshow-all-buffer)
  (peng-local-set-key (kbd "f") 'peng-ibuffer-filter-fun)
  ;; (peng-ibuffer-show-all-buffer)
  (peng-ibuffer-filter-fun)
  (define-key evil-normal-state-local-map (kbd "<C-return>") 'ibuffer-visit-buffer-other-window-noselect)
  (define-key evil-normal-state-local-map (kbd "M-s") 'ace-window)
  (peng-local-set-key (kbd "<down-mouse-1>") 'ibuffer-visit-buffer)
  (peng-local-set-key (kbd "v") peng-ibuffer-filter-map)
  )

(add-hook 'ibuffer-mode-hook 'peng-ibuffer-mode)


;;; set ibuffer display as group
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("asp" (filename . ".*/src/asp/.*"))
               ("python" (mode . python-mode))
               ("shell-script" (mode . sh-mode))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")
                         (mode . emacs-lisp-mode)
                         ))
               ("w3m" (or
                         (mode . w3m-mode)
                         ))
               ("blog" (or
                        (filename . "^.*blog/org/_posts/.*")))
               ("scratch" (or (filename . ".*/record/.*")))
               ("dired" (mode . dired-mode))
               ("planner" (or
                           (name . "^Calendar$")
                           (name . "^diary$")
                           (name . "^inbox.org$")
                           (name . "^Tips.org$")
                           (name . "^note.org$")
                           (name . "^daily.org$")
                           (name . "^test.org$")
                           (mode . muse-mode)
                           ))
               ("other-org" (mode . org-mode))
               ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))


;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
  (setq ibuffer-formats
	'((mark modified read-only " "
		(name 18 18 :left :elide)
		" "
		(size-h 9 -1 :right)
		" "
		(mode 16 16 :left :elide)
		" "
		filename-and-process)))


;; Enable ibuffer-filter-by-filename to filter on directory names too.
(eval-after-load "ibuf-ext"
  '(define-ibuffer-filter filename
       "Toggle current view to buffers with file or directory name matching QUALIFIER."
     (:description "filename"
                   :reader (read-from-minibuffer "Filter by file/directory name (regexp): "))
     (ibuffer-awhen (or (buffer-local-value 'buffer-file-name buf)
                        (buffer-local-value 'dired-directory buf))
       (string-match qualifier it))))

(provide 'init-ibuffer)
