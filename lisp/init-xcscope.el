;;; 在写C的时候使用cscope来查看源码
(require 'xcscope)

(peng-global-set-key (kbd "C-c s s") 'cscope-find-this-symbol)
(peng-global-set-key (kbd "C-c s d") 'cscope-find-global-definition)
(peng-global-set-key (kbd "C-c s g") 'cscope-find-global-definition)
(peng-global-set-key (kbd "C-c s G") 'cscope-find-global-definition-no-prompting)
(peng-global-set-key (kbd "C-c s c") 'cscope-find-functions-calling-this-function)
(peng-global-set-key (kbd "C-c s C") 'cscope-find-called-functions)
(peng-global-set-key (kbd "C-c s t") 'cscope-find-this-text-string)
(peng-global-set-key (kbd "C-c s e") 'cscope-find-egrep-pattern)
(peng-global-set-key (kbd "C-c s f") 'cscope-find-this-file)
(peng-global-set-key (kbd "C-c s i") 'cscope-find-files-including-file)
(peng-global-set-key (kbd "C-c s b") 'cscope-display-buffer)
(peng-global-set-key (kbd "C-c s B") 'cscope-display-buffer-toggle)
(peng-global-set-key (kbd "C-c s n") 'cscope-next-symbol)
(peng-global-set-key (kbd "C-c s N") 'cscope-next-file)
(peng-global-set-key (kbd "C-c s p") 'cscope-prev-symbol)
(peng-global-set-key (kbd "C-c s P") 'cscope-prev-file)
(peng-global-set-key (kbd "C-c s u") 'cscope-pop-mark)
(peng-global-set-key (kbd "C-c s a") 'cscope-set-initial-directory)
(peng-global-set-key (kbd "C-c s A") 'cscope-unset-initial-directory)
(peng-global-set-key (kbd "C-c s L") 'cscope-create-list-of-files-to-index)
(peng-global-set-key (kbd "C-c s I") 'cscope-index-files)
(peng-global-set-key (kbd "C-c s E") 'cscope-edit-list-of-files-to-index)
(peng-global-set-key (kbd "C-c s W") 'cscope-tell-user-about-directory)
(peng-global-set-key (kbd "C-c s S") 'cscope-tell-user-about-directory)
(peng-global-set-key (kbd "C-c s T") 'cscope-tell-user-about-directory)
(peng-global-set-key (kbd "C-c s D") 'cscope-dired-directory)


(defun pengpengxp-cscope-common-mode ()
  (interactive)
  (peng-local-set-key (kbd "q") 'delete-window)
  (peng-local-set-key (kbd "<M-backspace>") 'cscope-pop-mark)
  (peng-local-set-key (kbd "<kp-enter>") 'cscope-select-entry-other-window)
  (peng-local-set-key (kbd "<return>") 'cscope-select-entry-other-window)
  (peng-local-set-key (kbd "RET") 'cscope-select-entry-other-window)
  (hl-line-mode 1)
  )

(add-hook 'cscope-list-entry-hook 'pengpengxp-cscope-common-mode)

(defun peng-cscope-find-curren-files-including-file ()
  (interactive)
  (let ((name (file-name-nondirectory (buffer-file-name))))
    (if name
        (cscope-find-files-including-file name)
      (message "Sorry, current buffer is not related to file."))))


;;; use `ivy' to walk throud cscope-history
(require 'ivy)
(defun peng-ring-to-filename-and-position (marker)
  "change ring to string format `filename:position'"
  (let* ((buffername (marker-buffer marker))
         (position (marker-position marker)))
    (format "%s:%s" buffername position)))

(defun peng-add-content (file-name-and-position)
  "change `filename:position' to
`filename:position:content-of-line'"
  (let* ((rlist (split-string file-name-and-position ":"))
         bufffer
         position
         content
         )
    (if (or (string= (car rlist)
                     "nil")
            (string= (cadr rlist)
                     "nil"))
        nil
      (progn
        (setq buffer (car rlist))
        (setq position (string-to-int (cadr rlist)))
        (set-buffer buffer)
        (goto-char position)
        (setq content (buffer-substring-no-properties
                       (line-beginning-position)
                       (line-end-position)))
        (format "%s:%s:%s" buffer
                 position
                 content)
        ))))

(defun peng-walk-through-cscope-ring ()
  (interactive)
  (let* ((mymarker cscope-marker-ring)
         (file-name-and-position (mapcar 'peng-ring-to-filename-and-position (ring-elements mymarker)))
         (result (ivy-read "where do you want to jump: "
                           (remove nil (mapcar 'peng-add-content file-name-and-position))))
         (rlist (split-string result ":"))
         (buffer (car rlist))
         (position (string-to-int (cadr rlist))))
    (progn
      (switch-to-buffer buffer)
      (goto-char position))))

(defun peng-cscope-find-functions-calling-this-function ()
  (interactive)
  (deactivate-mark)
  (ring-insert find-tag-marker-ring (point-marker))
  (cscope-find-functions-calling-this-function (thing-at-point 'symbol)))

(provide 'init-xcscope)
