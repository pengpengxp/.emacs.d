;;pengpengxp's org-mode
;;; ----------------------------------------------------------------------
;;; hook
;;; ----------------------------------------------------------------------

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c l") 'org-store-link)

(defun peng-org-mode ()
  (interactive)
  (require 'evil)
  (require 'org)
;;; ----------------------------------------------------------------------
;;;refile in several files,here is in the all org-agenda-files
;;; ----------------------------------------------------------------------
  (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                   (ORG-REFILE-FILES :maxlevel . 9))))

;;; ----------------------------------------------------------------------
;;; ----------------------------------------------------------------------
  ;; 设置org-mode中对各种Babel语言支持，这样就可以通过`C-c C-c'执行这些命
  ;; 令了
;;; ----------------------------------------------------------------------
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (emacs-lisp . t)
     (C . t)
     (perl . t)
     (shell . t)
     (python . t)
     (latex . t)
     (js . t)
     (ruby . t)
     (ditaa . t)
     (R . t)
     (ditaa . t)
     (calc . t)
     ))
;;; 可以禁止`C-c C-c`在code block中进行执行命令，但是我不需要
  ;; (setq org-babel-no-eval-on-ctrl-c-ctrl-c nil)

;;; 每次执行的时候不再询问了yes-or-no了
  (setq org-confirm-babel-evaluate nil)
;;; ----------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; for the footnote: insert footnote inline by default
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq org-footnote-define-inline  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; personal function for org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; 在org-mode中方便地截图并显示
  (defcustom peng-org-screenshot-dir-name  "images"
    "default image directory name for org screenshot"
    :type 'string
    )

  (defun peng-org-screenshot ()
    (interactive)
    "Take a screenshot into a user specified file in the current
     buffer file directory and insert a link to this file."
    (let* ((img-dir peng-org-screenshot-dir-name))
      (progn
        (if (file-exists-p img-dir)
            (print "yes")
          (mkdir img-dir))
        (let ((temp-name (ivy-read "please selete a image name:"
                                   (delete ".." (delete "." (directory-files img-dir))))))
          (setq filename (concat img-dir
                                 "/"
                                 (file-name-base temp-name)
                                 ".png"))
          (call-process-shell-command "import" nil nil nil nil "" (concat
                                                                   "\"" filename "\"" ))
          (insert (concat "[[./" filename "]]"))))))

  (defun peng-delete-org-screenshot-image-file ()
    "use ivy-read to delete org-screenshot imges"
    (interactive)
    (let* ((img-dir peng-org-screenshot-dir-name))
      (progn
        (if (file-exists-p img-dir)
            (print "yes")
          (mkdir img-dir))
        (let ((temp-name (ivy-read "please selete a image name"
                                   (delete ".." (delete "." (directory-files img-dir))))))
          (if (yes-or-no-p "Do you really want to delete this png files?")
              (delete-file (concat img-dir "/" temp-name))
            (message "Exit without doing anything"))))))

  (defun peng-find-org-link-begin-and-end (plist string)
    (let ((return-list '()))
      (progn
        (while plist
          (progn
            (if (string-equal (car (car plist))
                              string)
                (add-to-list 'return-list (cdr (car plist))))
            (setq plist (cdr plist))))
        return-list)))

  (defun peng-do-delete-link-function (be-list)
    "goto the begining of link and delete it, be-list is a list
  just like `((name begin-position end-position))'"
    (while be-list
      (progn
        (goto-char (car (car be-list)))
        (delete-char (- (car (cdr (car be-list)))
                        (car (car be-list))))
        (setq be-list (cdr be-list)))))

  (defun peng-delete-org-screenshot-image-file-and-link ()
    (interactive)
    (let* ((link-list (org-element-map (org-element-parse-buffer) 'link
                        (lambda (link)
                          (when (string= (org-element-property :type link) "file")
                            (list (org-element-property :path link)
                                  (org-element-property :begin link)
                                  (org-element-property :end link))))))
           (img-dir peng-org-screenshot-dir-name)
           (temp-name (concat "./" img-dir "/"
                              (ivy-read "please selete a image name you want to delete"
                                        (delete ".." (delete "." (directory-files img-dir))))))
           (begin-end-list (peng-find-org-link-begin-and-end link-list temp-name)))
      (progn
        (if (yes-or-no-p "Do you really want to delete the image file? This can't be revertable!!")
            (delete-file temp-name))
        (if (yes-or-no-p "Do you also want to delete the image links?")
            (peng-do-delete-link-function begin-end-list)))))
  (defun peng-org-latex-insert-math ()
    "To insert math convenient in org or latex"
    (interactive)
    (insert " \\(\\)")
    (goto-char (- (point) 2)))

  (defun peng-org-view ()
    "Veiw the pdf file generated by current org source file"
    (interactive)
    (let ((TEMPBASE (format "%s" (file-name-base))))
      (peng-async-shell-command (concat "open "
                                        TEMPBASE
                                        ".pdf"))))

  (defun peng-org-latex-export-to-pdf-and-open ()
    "Export the org source file to pdf, delete the intermediate
file and open the pdf file."
    (interactive)
    (save-excursion
      (let ((TEMPFILE (message "%s" (file-name-base))))
        (progn
          (shell-command (concat "rm -rf " TEMPFILE ".pdf"))
          (org-latex-export-to-latex)
          (compile (concat "xelatex "
                           (concat TEMPFILE ".tex")
                           ";xelatex "
                           (concat TEMPFILE ".tex")
                           ";xelatex "
                           (concat TEMPFILE ".tex")
                           (concat  ";rm -rf " TEMPFILE ".bbl " TEMPFILE ".blg " 
                                    TEMPFILE ".out " TEMPFILE ".log " TEMPFILE ".aux " 
                                    TEMPFILE ".toc" ";rm -f " TEMPFILE ".tex"
                                    ";open " TEMPFILE ".pdf")))
          ))))

  (defun peng-org-latex-export-to-pdf-and-open-no-content ()
    "Export the org source file to pdf, delete the intermediate
file and open the pdf file."
    (interactive)
    (save-excursion
      (let ((TEMPFILE (message "%s" (file-name-base))))
        (progn
          (shell-command (concat "rm -rf " TEMPFILE ".pdf"))
          (org-latex-export-to-latex)
          (compile (concat "xelatex "
                           (concat TEMPFILE ".tex")
                           ;; ";xelatex "
                           ;; (concat TEMPFILE ".tex")
                           ;; ";xelatex "
                           ;; (concat TEMPFILE ".tex")
                           (concat  ";rm -rf " TEMPFILE ".bbl " TEMPFILE ".blg " 
                                    TEMPFILE ".out " TEMPFILE ".log " TEMPFILE ".aux " 
                                    TEMPFILE ".toc" ";rm -f " TEMPFILE ".tex"
                                    ";open " TEMPFILE ".pdf")))
          ))))
  (defun peng-highlight ()
    "利用 highlight-regexp 高亮指定的正
                              则表达式 "
    (interactive)
    (highlight-regexp "`.*'" 'language-lock-face))

;;; 使用`org-tree-slide-mode'可以在org-mode中直接进行幻灯片类型的演示
  ;; (require 'init-org-tree-slide-mode)

;;; 执行代码块进如果有错会产生一个名为`*Org-Babel Error Output*'的
;;; buffer显示错误，但是把错误改正确后再执行，还需要再手动把这个显示错
;;; 误的buffer删除，下面这样设置后，修改了错误就不需要手动删除了，直接
;;; 运行即可。
  (defvar org-babel-eval-verbose t
    "A non-nil value makes `org-babel-eval' display")
  (defun org-babel-eval (cmd body)
    "Run CMD on BODY.
If CMD succeeds then return its results, otherwise display
STDERR with `org-babel-eval-error-notify'."
    (let ((err-buff (get-buffer-create " *Org-Babel Error*")) exit-code)
      (with-current-buffer err-buff (erase-buffer))
      (with-temp-buffer
        (insert body)
        (setq exit-code
              (org-babel--shell-command-on-region
               (point-min) (point-max) cmd err-buff))
        (if (or (not (numberp exit-code)) (> exit-code 0)
                (and org-babel-eval-verbose (> (buffer-size err-buff) 0))) ; new condition
            (progn
              (with-current-buffer err-buff
                (org-babel-eval-error-notify exit-code (buffer-string)))
              nil)
          (buffer-string)))))


;;; make all the screenshot image the same size in org-mode file
  (setq org-image-actual-width 200)

  (defun peng-org-latex-export-to-pdf-and-open-with-bib ()
    "Export the org source file to pdf, delete the intermediate
file and open the pdf file. also compile the bibliography"
    (interactive)
    (save-excursion
      (let ((TEMPFILE (message "%s" (file-name-base))))
        (progn
          (shell-command (concat "rm -rf " TEMPFILE ".pdf"))
          (org-latex-export-to-latex)
          (compile (concat "xelatex "
                           (concat TEMPFILE ".tex")
                           ";bibtex "
                           (concat TEMPFILE ".aux")
                           ";xelatex "
                           (concat TEMPFILE ".tex")
                           ";xelatex "
                           (concat TEMPFILE ".tex")
                           (concat  ";rm -rf " TEMPFILE ".bbl " TEMPFILE ".blg " 
                                    TEMPFILE ".out " TEMPFILE ".log " TEMPFILE ".aux " 
                                    TEMPFILE ".toc" ";rm -f " TEMPFILE ".tex"
                                    ";open " TEMPFILE ".pdf")))
          ))))


;;; grab firefox link to w3m bookmarkd
  (require 'grab-x-link)

  (defun peng-grab-firefox-tab-to-w3m-todo-file ()
    "save firefox tab url and title to w3m bookmarks"
    (interactive)
    (let* (
           (result (grab-x-link-firefox))
           (url (car result))
           (title (concat "todo:"
                          (cdr result)))
           (w3m-bookmark-default-section "todo")
           )
      (w3m-bookmark-add url title)))

  (defun peng-grab-firefox-tab-to-org-todo-file ()
    "save firefox tab url and title to org bookmarks"
    (interactive)
    (let ((file-name "/home/pengpengxp/github/pengpengxp.github.io/source/2017-06-29-my-saved-website.org"))
      (with-temp-buffer (progn
                          (insert-file file-name)
                          (goto-char (point-max))
                          (insert "* ")
                          (goto-char (point-max))
                          (grab-x-link-firefox-insert-org-link)
                          (write-file file-name)))
      (find-file file-name)
      (goto-char (point-max))))

  (hi-lock-mode 1)
  (peng-highlight)
  (hl-line-mode 1)
  (toggle-word-wrap -1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  ;; (helm-mode t)

  ;; 在normal是用回车来执行命令，其它还就是`org-return'
  (peng-local-set-key (kbd "<C-M-return>") 'completion-at-point)
  (peng-local-set-key (kbd "<return>") 'org-return)
  (peng-local-set-key (kbd "<S-iso-lefttab>") 'org-cycle)
  (define-key evil-normal-state-local-map (kbd "RET") 'peng-async-exec-current-line-or-marked-region)
  (define-key evil-normal-state-local-map (kbd "<return>") 'peng-async-exec-current-line-or-marked-region)

  ;; (peng-local-set-key (kbd "<f5> <f5>") 'peng-org-latex-insert-math)

  (define-key evil-normal-state-local-map (kbd "C-c C-n") 'outline-next-visible-heading)
  (define-key evil-visual-state-local-map (kbd "C-c C-n") 'outline-next-visible-heading)

  (define-key evil-normal-state-local-map (kbd "C-c C-u") 'outline-up-heading)
  (define-key evil-visual-state-local-map (kbd "C-c C-u") 'outline-up-heading)

  (define-key evil-visual-state-local-map (kbd "j") 'next-line)
  (define-key evil-visual-state-local-map (kbd "<down>") 'next-line)
  (define-key evil-visual-state-local-map (kbd "k") 'previous-line)
  (define-key evil-visual-state-local-map (kbd "<up>") 'previous-line)

  
  ;; (define-key evil-normal-state-local-map (kbd "SPC c '") 'org-edit-special)
  ;; (define-key evil-normal-state-local-map (kbd "SPC c o") 'org-open-at-point)
  ;; (define-key evil-normal-state-local-map (kbd "SPC c q") 'org-set-tags-command)
  ;; (define-key evil-normal-state-local-map (kbd "SPC c t") 'org-todo)
  ;; (define-key evil-normal-state-local-map (kbd "SPC c h") 'org-hide-block-all)
  ;; (define-key evil-normal-state-local-map (kbd "SPC c s") 'org-show-block-all)
  
  (define-key evil-normal-state-local-map (kbd "j") 'next-line)
  (define-key evil-normal-state-local-map (kbd "<down>") 'next-line)
  (define-key evil-normal-state-local-map (kbd "C-n") 'next-line)
  (define-key evil-normal-state-local-map (kbd "l") 'forward-char)
  (define-key evil-normal-state-local-map (kbd "h") 'backward-char)
  (define-key evil-normal-state-local-map (kbd "k") 'previous-line)
  (define-key evil-normal-state-local-map (kbd "<up>") 'previous-line)
  (define-key evil-normal-state-local-map (kbd "C-p") 'previous-line)

  ;; (define-key evil-normal-state-local-map (kbd "SPC v") 'peng-org-latex-export-to-pdf-and-open)
  ;; (define-key evil-normal-state-local-map (kbd "SPC cv") 'peng-org-view)

  ;; (define-key evil-normal-state-local-map (kbd "<f5> cv") 'peng-org-view)
  (define-key evil-insert-state-local-map (kbd "<M-tab>") 'ispell-complete-word)
  (define-key evil-emacs-state-local-map (kbd "<M-tab>") 'ispell-complete-word)
  (local-set-key (kbd "<C-tab>") 'other-window)
  (local-set-key (kbd "<C-return>") 'org-insert-heading-respect-content)
  (peng-local-set-key (kbd "C-c (") 'reftex-citation)
  (peng-local-set-key (kbd "C-c )") 'reftex-reference)
  (peng-local-set-key (kbd "M-e") 'org-forward-sentence)
  ;; (peng-local-set-key (kbd "<f9>") 'peng-org-latex-export-to-pdf-and-open-no-content)
  (peng-local-set-key (kbd "<f10>") 'peng-org-latex-export-to-pdf-and-open)
  (setq truncate-lines nil)
  (yas-minor-mode 1)
  (local-set-key (kbd "C-c a") 'org-agenda)

  (if (not (display-graphic-p))
      (progn
        (peng-local-set-key (kbd "<tab>") 'org-cycle)
        (peng-local-set-key (kbd "TAB") 'org-cycle)
        ))
  (peng-local-set-key (kbd "C-c &") 'org-mark-ring-goto)

  (setq org-agenda-files ORG-AGENDA-FILES)
  (setq org-directory ORG-HOME)
  ;; (org-indent-mode 1)	;不显示那么多个*
  (setq org-return-follows-link t) ;超连接可以使用回车打开
  (if (display-graphic-p)
      (local-set-key (kbd "<s-return>") 'org-insert-subheading)))


;;; 默认情况下，org会把src block中的tab都转换成space。这样makefile文件
;;; tangle后不能使用。可以设置变量 `org-src-preserve-indentation' 为t
;;; 表示不把tab转化为space。
(setq org-src-preserve-indentation t)

(use-package org
  :defer t
  :init
  (add-hook 'org-mode-hook 'peng-org-mode)
  )

;;; add toc-org to generate toc automatically
(if (require 'toc-org nil t)
    (add-hook 'org-mode-hook 'toc-org-enable)
  (warn "toc-org not found"))

(provide 'init-org)
