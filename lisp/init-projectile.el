(projectile-mode 1)

;;; config ivy as its complete engins
(setq projectile-completion-system 'ivy)

;;; enable cache for speed
(setq projectile-enable-caching t)

;;; setting some default project
(setq projectile-known-projects '("~/src/ASP-Engine/"))


;;; 使在project中切换buffer时，不显示 `*buffer-name*'这种buffer，主要
;;; 就是在判断的时候加了这两行：

;; ;; hack here to filter `*buffer-name*'
;; (or (not (string/starts-with (format "%s" buffer)
;;                              "*"))
;;     (not (string/ends-with (format "%s" buffer)
;;                            "*")))))
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun string/ends-with (string suffix)
  "Return t if STRING ends with SUFFIX."
  (and (string-match (rx-to-string `(: ,suffix eos) t)
                     string)
       t))

(defun string/starts-with (s begins)
  "Return non-nil if string S starts with BEGINS."
  (cond ((>= (length s) (length begins))
         (string-equal (substring s 0 (length begins)) begins))
        (t nil)))

(defun my-projectile-project-buffers ()
  "Get a list of project buffers."
  (let* ((project-root (projectile-project-root))
         (all-buffers (cl-remove-if-not
                       (lambda (buffer)
                         (and
                          (projectile-project-buffer-p buffer project-root)
                          
                          ;; hack here to filter `*buffer-name*'
                          (or (not (string/starts-with (format "%s" buffer)
                                                       "*"))
                              (not (string/ends-with (format "%s" buffer)
                                                     "*")))
                          (not (string-equal (format "%s" buffer)
                                             "TAGS"))
                          ))
                       
                       (buffer-list))))
    (if projectile-buffers-filter-function
        (funcall projectile-buffers-filter-function all-buffers)
      all-buffers)))

(defun my-projectile-switch-to-buffer ()
  "Switch to a project buffer."
  (interactive)
  (switch-to-buffer
   (my-projectile-read-buffer-to-switch "Switch to buffer: ")))

(defun my-projectile-read-buffer-to-switch (prompt)
  "Read the name of a buffer to switch to, prompting with PROMPT.

This function excludes the current buffer from the offered
choices."
  (projectile-completing-read
   prompt
   (delete (buffer-name (current-buffer))
           (my-projectile-project-buffer-names))))

(defun my-projectile-project-buffer-names ()
  "Get a list of project buffer names."
  (mapcar #'buffer-name (my-projectile-project-buffers)))

(defadvice projectile-ag (after peng-after-projectile-ag activate)
  (progn
    ;; (switch-to-buffer "*compilation*")
    ;; (delete-window)
    (define-key evil-normal-state-local-map (kbd "k") 'evil-previous-line)
    (define-key evil-normal-state-local-map (kbd "j") 'evil-next-line)
    (define-key evil-normal-state-local-map (kbd "SPC") peng-spc-main-map)
    (define-key evil-normal-state-local-map (kbd "h") 'evil-backward-char)
    (define-key evil-normal-state-local-map (kbd "l") 'evil-forward-char)
    ))

(provide 'init-projectile)
