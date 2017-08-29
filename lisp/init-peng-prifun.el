;;; This is pengpengxp's private function

(defun  peng-reset-tags-table ()
  "reset the tags table to my defalt TAGS"
  (interactive)
  (setq tags-table-list
	'("~/.emacs.d/TAGS" "/usr/share/emacs/24.3/TAGS"))
  (setq tags-file-name nil)
  )

;;; ----------------------------------------------------------------------
;;; My own copy and paste line functon
;;; ----------------------------------------------------------------------
(defun peng-copy-one-line ()
  "copy one line in my favourite way"
  (interactive)
  (let ((start (line-beginning-position))
	(end (line-end-position)))
    (kill-ring-save start end)
    (goto-char end)))
(defun peng-yank-one-line ()
  "paste one line in my favourite way"
  (interactive)
  (yank)
  (newline))
;;; ----------------------------------------------------------------------


(defun peng-unshow-all-tools ()
  "hide menu and tool and scroll bar"
  (interactive)
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1))
(defun peng-show-all-tools ()
  "show menu and tool and scroll bar"
  (interactive)
    (menu-bar-mode t)
    (tool-bar-mode t)
    (scroll-bar-mode t))

;;; referenced from others
(defun peng-edit-current-file-as-root ()
  "edit current file as root"
  (interactive)
  (if (buffer-file-name)
      (progn
	(setq FILE (concat "/sudo:root@localhost:" (buffer-file-name)))
	(find-file FILE))
    (message "Current buffer does not have an associated file")))

;;; scroll like vim
(defun peng-line-up ()
  "Scroll the page with the cursor in the same line"
  (interactive)
  ;; move the cursor also
  (let ((tmp (current-column)))
    (scroll-down 1)
    (line-move-to-column tmp)
    (forward-line -1)
    )
  )
(defun peng-line-down ()
  "Scroll the page with the cursor in the same line"
  (interactive)
  ;; move the cursor also
  (let ((tmp (current-column)))
    (scroll-up 1)
    (line-move-to-column tmp)
    (forward-line 1)
    )
  )

;;; ----------------------------------------------------------------------
;;; to print current buffer to pdf files
;;; ----------------------------------------------------------------------
(defun peng-print-current-buffer ()
  (interactive)
  (let ((OUTPUT (concat "/tmp/"
			(buffer-name)
			".ps")))
    (save-excursion
      (save-restriction
	(widen)
	(ps-print-buffer OUTPUT)
	(cd "/tmp/")
	(shell-command (concat "ps2pdf "
			       OUTPUT))))))
;;; need to install emacs-intl-fonts in ubuntu,and then set this variable,it can print chinese now
(setq ps-multibyte-buffer 'bdf-font-except-latin)
;;; ----------------------------------------------------------------------

;;; ----------------------------------------------------------------------
;;; need to be improved
;;; ----------------------------------------------------------------------
(defun peng-list-current-file-tags ()
  "list current files tags"
  (interactive)
  (flet ((yes-or-no-p (args) t)
	    (y-or-n-p (args) t))
    (shell-command (concat "etags " 
			   (format "%s" (buffer-file-name))))
    (visit-tags-table (concat (helm-current-directory)
			      "TAGS"))
    (list-tags (buffer-file-name))
    (delete-window)
    (switch-to-buffer "*Tags List*")
    (delete-other-windows)
    ))
;;; ----------------------------------------------------------------------

;;; ----------------------------------------------------------------------
;;; eyerest function
;;; ----------------------------------------------------------------------
(defun peng-eyerest-reset ()
  (interactive)
  (shell-command "eyerest-cli -r"))
(defun peng-eyerest-show-rest ()
  (interactive)
  (let ((time (string-to-int (shell-command-to-string "eyerest-cli -t %s"))))
    (message "%d:%d" (/ time 60)
	     (% time 60))))
(defun peng-eyerest-pause()
  (interactive)
  (shell-command "eyerest-cli -p"))
(defun peng-eyerest-continue ()
  (interactive)
  (shell-command "eyerest-cli -c"))
(defun peng-eyerest-restart ()
  (interactive)
  (let ((iseyerest (shell-command-to-string "eyerest-cli -s|grep -i active")))
    (if (string= iseyerest "")
	(shell-command "eyerest-daemon")
      (shell-command "killall eyerest-daemon;eyerest-daemon"))))
(defun peng-eyerest-kill ()
  (interactive)
  (shell-command "killall eyerest-daemon"))
(defun peng-eye-gymnistic ()
  (interactive)
  (async-shell-command "mplayer /home/pengpengxp/music/eye_gymnastics.mp3" nil))
;;; ----------------------------------------------------------------------


(defun peng-goto-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))
(defun peng-show-major-mode ()
  (interactive)
  (message "%s" major-mode))

;;; ----------------------------------------------------------------------
;;; global-set-key with evil
;;; ----------------------------------------------------------------------
(defun peng-global-set-key (keys function)
  "use for key-binding with evil
bind in global map and all evil map to make sure it works as I want
绑定所有map。这才是是我需要的global-set-key
usage: (peng... \"keys-you-want-to-bind\" 'function-you-want-to-bind  "
  (define-key evil-normal-state-map keys function)
  (define-key evil-emacs-state-map keys function)
  (define-key evil-insert-state-map keys function)
  (define-key evil-motion-state-map keys function)
  (define-key evil-visual-state-map keys function)
  (define-key evil-replace-state-map keys function)
  (define-key evil-operator-state-map keys function)
  (define-key global-map keys function)
  )

(defun peng-global-set-evil-non-edit-mode-key (keys function)
  "use for key-binding with evil
bind in global map and all evil map to make sure it works as I want
绑定所有evil的操作模式的map。这才是是我需要的global-set-key
usage: (peng... \"keys-you-want-to-bind\" 'function-you-want-to-bind  "
  (define-key evil-normal-state-map keys function)
  (define-key evil-motion-state-map keys function)
  (define-key evil-visual-state-map keys function)
  )
;;; ----------------------------------------------------------------------


;;; ----------------------------------------------------------------------
;;; local-set-key with evil
;;; ----------------------------------------------------------------------
(defun peng-local-set-key (keys function)
  "use for key-binding with evil bind in local map and all evil
map to make sure it works as I want

绑定所有local-map。这才是是我需要的每个不同mode中的local-set-key
usage: (peng... \"keys-you-want-to-bind\"
'function-you-want-to-bind "
  (define-key evil-normal-state-local-map keys function)
  (define-key evil-emacs-state-local-map keys function)
  (define-key evil-insert-state-local-map keys function)
  (define-key evil-motion-state-local-map keys function)
  (define-key evil-visual-state-local-map keys function)
  (define-key evil-replace-state-local-map keys function)
  (define-key evil-operator-state-local-map keys function)
  )
;;; ----------------------------------------------------------------------

;; ;;; ----------------------------------------------------------------------
;; ;;; I modified the from the helm-src file
;; ;;; ----------------------------------------------------------------------
;; (defun peng-helm-etags-select (arg)
;;   "Preconfigured helm for etags.
;; If called with a prefix argument or if any of the tag files have
;; been modified, reinitialize cache.

;; This function aggregates three sources of tag files:

;;   1) An automatically located file in the parent directories, by `helm-etags-get-tag-file'.
;;   2) `tags-file-name', which is commonly set by `find-tag' command.
;;   3) `tags-table-list' which is commonly set by `visit-tags-table' command."
;;   (interactive "P")
;;   (let ((tag-files (helm-etags-all-tag-files))
;;         ;; (helm-execute-action-at-once-if-one helm-etags-execute-action-at-once-if-one)
;;         (helm-execute-action-at-once-if-one nil)
;;         (str (thing-at-point 'symbol))
;; 	)
;;     (if (cl-notany 'file-exists-p tag-files)
;;         (message "Error: No tag file found. Create with etags shell command, or visit with `find-tag' or `visit-tags-table'.")
;;       (cl-loop for k being the hash-keys of helm-etags-cache
;;             unless (member k tag-files)
;;             do (remhash k helm-etags-cache))
;;       (mapc (lambda (f)
;;               (when (or (equal arg '(4))
;;                         (and helm-etags-mtime-alist
;;                              (helm-etags-file-modified-p f)))
;;                 (remhash f helm-etags-cache)))
;;             tag-files)
;;       (helm :sources 'helm-source-etags-select
;;             :keymap helm-etags-map
;;             :default (list (concat "\\_<" str "\\_>") str)
;;             :buffer "*helm etags*"))))
;; ;;; ----------------------------------------------------------------------

(defun peng-compile-current-file-as-plain-tex ()
  "compile current file as plain tex.
This function will send the current file to tex, and then input
the `\end' to end the tex program. At last, use evince to display the result"
  (interactive)
  (let ((file-name (file-name-base)))
    (compile (concat "tex "
		     file-name
		     ".tex"
		     "'\\end';"
		     "evince "
		     file-name
		     ".dvi"))))

(defun peng-change-current-file-to-executable ()
  "Change current file to executable"
  (interactive)
  (let ((file-name (buffer-file-name)))
    (shell-command (concat "chmod a+x "
			   file-name))))

(defun peng-run-current-script ()
  "make current file excutbale and just run it

Not just shell-script, You can run any script as you like"
  (interactive)
  (let ((temp-file-full-name (buffer-file-name))
	(temp-file-base-name (file-name-base)))
    (if temp-file-full-name
	(if (not (= (shell-command (concat "test -x " temp-file-full-name)) 0))
	    (progn
	      (shell-command (concat "chmod a+x " temp-file-full-name))
	      (compile temp-file-full-name))
	  (progn
	    (compile temp-file-full-name)))
      )))

(defun peng-async-shell-command (COM)
  "Run the shell command asynchronize Don't ask me whether to
create a new buffer just because the default buffer is used.

For this reason, I create a random output buffer rather than the
default one every time I launch a shell command.

The COM is what you want to excute. It MUST be a string."
  (save-window-excursion
    (save-excursion
      (let ((RANDOM-NUM (message "%s" (random 10000))))
      (async-shell-command COM
			   (get-buffer-create 
			    (concat "peng-async-shell-command-output-" RANDOM-NUM)))  
	))))

(defun peng-switch-to-org-agenda ()
  "switch to buffer *Org Agenda*
if that buffer is not exits,call org-agenda"
  (interactive)
  (let ((buffer (get-buffer "*Org Agenda*")))
    (if buffer
	(switch-to-buffer "*Org Agenda*")
      (org-agenda))))

;;; only usefull on mac
(if (string= system-type "darwin")
    (progn
      (require 'org-capture)
      (defun peng-get-chrome-current-tab-url ()
	"Get the URL of the active tab of the first window"
	(interactive)
	(let ((result (do-applescript
		       (concat
			"set frontmostApplication to path to frontmost application\n"
			"tell application \"Google Chrome\"\n"
			"	set theUrl to get URL of active tab of first window\n"
			"	set theResult to (get theUrl) \n"
			"end tell\n"
			"activate application (frontmostApplication as text)\n"
			"set links to {}\n"
			"copy theResult to the end of links\n"
			"return links as string\n"))))
	  (insert result)))

      (defun peng-get-chrome-current-tab-title ()
	"Get the title of the active tab of the first window"
	(interactive)
	(let ((title (do-applescript
                      (concat
                       "tell application \"Google Chrome\"to return title of active tab of front window\n"
                       ))))
	  (format "%s" title)))

      (defun peng-get-chrome-current-tab-url-to-org-capture ()
        "Get the URL of the active tab of the first window"
        (interactive)
        (let ((result (replace-regexp-in-string "\""
                                                ""
                                                (do-applescript
                                                 (concat
                                                  "set frontmostApplication to path to frontmost application\n"
                                                  "tell application \"Google Chrome\"\n"
                                                  "	set theUrl to get URL of active tab of first window\n"
                                                  "	set theResult to (get theUrl) \n"
                                                  "end tell\n"
                                                  "activate application (frontmostApplication as text)\n"
                                                  "set links to {}\n"
                                                  "copy theResult to the end of links\n"
                                                  "return links as string\n"))))
              (title  (read-from-minibuffer "The title of your linke: " (concat (format-time-string "%Y-%m-%d ")
                                                                                (peng-get-chrome-current-tab-title)))
                      ))
          (org-capture nil "w")
          (insert (format "%s" (concat "[[" (format "%s" result) "]" "[" title "]]")))
          (org-capture-finalize nil))

        (progn
          (org-capture-goto-last-stored)

          ;; replace `*' to `+'
          (replace-regexp "^*" "+" nil (line-beginning-position)
                          (line-end-position))))

      ))

(defun peng-switch-to-other-buffer ()
  "switch to other buffer without ask"
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun peng-mark-line ()
  "mark the current line"
  (interactive)
  (push-mark (point))
  (push-mark (beginning-of-line) nil t)
  (end-of-line))

(defun peng-mark-to-beginning-of-line ()
  "mark from current point to the beginning of current line"
  (interactive)
  (push-mark (point) nil t)
  (beginning-of-line))

(defun peng-mark-to-end-of-line ()
  "mark from current point to the end of current line"
  (interactive)
  (push-mark (point) nil t)
  (end-of-line))

(defun peng-mark-back-to-indentation ()
  "mark from current point back to the indentation point"
  (interactive)
  (push-mark (point) nil t)
  (back-to-indentation))

;;; copy from wiki
(defun peng-mark-current-word (&optional arg allow-extend)
  "Put point at beginning of current word, set mark at end."
  (interactive "p\np")
  (setq arg (if arg arg 1))
  (if (and allow-extend
           (or (and (eq last-command this-command) (mark t))
               (region-active-p)))
      (set-mark
       (save-excursion
         (when (< (mark) (point))
           (setq arg (- arg)))
         (goto-char (mark))
         (forward-word arg)
         (point)))
    (let ((wbounds (bounds-of-thing-at-point 'word)))
      (unless (consp wbounds)
        (error "No word at point"))
      (if (>= arg 0)
          (goto-char (car wbounds))
        (goto-char (cdr wbounds)))
      (push-mark (save-excursion
                   (forward-word arg)
                   (point)))
      (activate-mark))))

(defun peng-insert-buffer-file-name ()
  "insert the name of the current buffer, don't insert the
absolute path."
  (interactive)
  (let ((current-file-name
	 (file-name-nondirectory (expand-file-name
				  (buffer-file-name)))))
    (message current-file-name)
    (insert current-file-name)))

(defun peng-yank-or-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun peng-copy-current-directory-or-name-for-git-log ()
  (interactive)
  (let* ((filename (if (equal major-mode 'dired-mode)
                       default-directory
                     (buffer-file-name)))
         (result (if (equal major-mode 'dired-mode)
                     (replace-regexp-in-string
                      "~/src/ASP-Engine/" "" filename)
                   (replace-regexp-in-string
                    "/home/pengpengxp/src/ASP-Engine/" "" filename))))
    (when filename
      (kill-new result)
      (message "Copied buffer file name '%s' to the clipboard." result))))

(defun peng-yank-file-name ()
  "yank the file name"
  (interactive)
  (let ((name (file-name-nondirectory (buffer-file-name))))
    (kill-new name)
    (message "Copied buffer file name '%s' to the clipboard" name)))

(defun peng-yank-symbol-name ()
  (interactive)
  (let ((symbol (thing-at-point 'symbol)))
    (progn
      (kill-new symbol)
      (message "symbol %s is copyed" symbol))))

(defun peng-yank-buffer-name ()
  (interactive)
  (let ((buffer (buffer-name)))
    (progn
      (kill-new buffer)
      (message "buffer name %s is copyed" buffer))))

(defun peng-select-symbol ()
  "mark current symbol"
  (interactive)
  (beginning-of-thing 'symbol)
  (push-mark (point) nil t)
  (end-of-thing 'symbol))

(defun peng-select-line ()
  "mark current line"
  (interactive)
  (beginning-of-thing 'line)
  (push-mark (point) nil t)
  (mwim-end-of-code-or-line)
  (backward-char))

(defun peng-select-word ()
  "mark current word"
  (interactive)
  (beginning-of-thing 'word)
  (push-mark (point) nil t)
  (end-of-thing 'word))

(defun peng-yank-word-name ()
  (interactive)
  (let ((symbol (thing-at-point 'word)))
    (progn
      (kill-new symbol)
      (message "symbol %s is copyed" symbol))))

(defun peng-yank-directory-name ()
  "yank the current directory name"
  (interactive)
  (let ((name (file-name-directory (buffer-file-name))))
    (kill-new name)
    (message "Copied buffer file name '%s' to the clipboard" name)))

(defun peng-unhighlight-all ()
  (interactive)
  (unhighlight-regexp t))

(defun peng-auto-revert ()
  "revert buffer without ask"
  (interactive)
  (revert-buffer nil t ))

(defun peng-find-rs-file ()
  "easy wrap for open remote file system"
  (interactive)
  (find-file "/ssh:root@pt:/"))


(defun peng-mark-real-line ()
  "mark the real body of a line"
  (interactive)
  (mwim-beginning-of-code-or-line)
  (set-mark (point))
  (mwim-end-of-code-or-line)
  (backward-char)
  )

(defun peng-mac-open-gui-calc ()
  (interactive)
  (save-window-excursion
    (async-shell-command  "open /Applications/Calculator.app")
    )
  )

(defun peng-mac-open-gui-calendar ()
  (interactive)
  (save-window-excursion
    (async-shell-command  "open /Applications/Calendar.app")
    )
  )

;;; kill all buffers end
(defun peng-get-buffer-mode (buffer-or-string)
  "Returns the major mode associated with a buffer."
  (with-current-buffer buffer-or-string
    major-mode))
(defun peng-real-buffer (&optional buffer)
  (cond ((buffer-file-name buffer)
         t)
        ((equal (peng-get-buffer-mode buffer) 'dired-mode)
         t)
        (t
         nil)))
(defun peng-kill-all-file-relative-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer 
        (remove-if-not 'peng-real-buffer (buffer-list))
        )
  (message "All buffer killed"))
;;; kill all buffers end

(defun peng-copy-current-line-position-to-clipboard ()
  "Copy current line in file to clipboard as '</path/to/file>:<line-number>'"
  (interactive)
  (let ((path-with-line-number
         (concat (file-name-nondirectory (buffer-file-name)) ":" (number-to-string (line-number-at-pos)))))
    ;; (x-select-text path-with-line-number)
    (kill-new  path-with-line-number)
    (message (concat path-with-line-number " copied to clipboard"))))


(defun peng-copy-current-fun-name ()
  "Copy current function name."
  (interactive)
  (kill-new (which-function))
  (message "copy %s to clipboard..." (which-function)))


(defun peng-open-in-desktop-and-select ()
  "select file in finder"
  (interactive)
  (let* (
         (ξfile-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         (ξdo-it-p (if (<= (length ξfile-list) 5)
                        t
                      (y-or-n-p "Open more than 5 files? "))))

    (when ξdo-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda (fPath)
           (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t))) ξfile-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda (fPath) (shell-command (format "open -R \"%s\"" fPath)))  ξfile-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath))) ξfile-list))))))


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my-global-temp-buffer-name nil)
(defvar my-global-org-buffer-name nil)
(defun peng-generate-temp-buffer ()
  (interactive)
  (let* ((name (concat (getenv "HOME")
                       "/record/"
                       (format-time-string "%Y-%m-%d")
                       ;; (make-temp-name "tempbuffer")
                       "-scratch.org")))
    (progn
      (find-file name)
      (save-buffer)
      (setq my-global-temp-buffer-name name)
      (message "Generate a tempbuffer!"))))

(defun peng-switch-to-temp-buffer ()
  (interactive)
  (cond
   ((equal my-global-temp-buffer-name nil) (progn
                                             (peng-generate-temp-buffer)
                                             (message "It's nil, Create a new buffer")))
   (my-global-temp-buffer-name (progn
                                 (find-file  my-global-temp-buffer-name)
                                 (message "switch to it %s" my-global-temp-buffer-name)))
   ))

(defun peng-generate-org-buffer ()
  (interactive)
  (let* ((name (concat (getenv "HOME")
                       "/record/"
                       (format-time-string "%Y-%m-%d")
                       "-note.org")))
    (progn
      (find-file name)
      (save-buffer)
      (setq my-global-org-buffer-name name)
      (message "Generate a org buffer!"))))

(defun peng-switch-to-org-buffer ()
  (interactive)
  (cond
   ((equal my-global-org-buffer-name nil) (progn
                                            (peng-generate-org-buffer)
                                            (message "It's nil, Create a new buffer")))
   (my-global-org-buffer-name (progn
                                (find-file  my-global-org-buffer-name)
                                (message "switch to it %s" my-global-org-buffer-name)))
   ))
(defun toggle-fullscreen ()
  "Toggle full screen on mac"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(defun peng-insert-counter-column ()
  "Input : Begin and End Number.
Insert continuous number"
  (interactive)
  (let ((i (string-to-number (read-from-minibuffer "Begin: ")))
        (n (string-to-number (read-from-minibuffer "End: ")))
        (colpos (- (point) (point-at-bol))))
    (while (<= i n)
      (insert (number-to-string i))
      (newline)
      (beginning-of-line)
      (forward-char colpos)
      (setq i (1+ i))
      )))

(defun peng-add-counter-column ()
  "insert 1 to n in n column
    Example: n = 3,insert:
    insert: 1
    insert: 2
    insert: 3
    NOTE:referenced from xahlee
add continuous number for exists line, little difference of `peng-insert-counter-column'"
  (interactive)
  (let ((colpos (- (point) (point-at-bol)))
	(i (string-to-number (read-from-minibuffer "Begin: " "1")))
        (n (string-to-number (read-from-minibuffer "End: "))))
    (while (<= i n)
      (insert (number-to-string i))
      (next-line)
      (beginning-of-line)
      (forward-char colpos)
      (setq i (1+ i)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; my own `window-configuration-to-register' function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun peng-found-in-register-alist-p (r)
  "whether the register is in `register-alist'"
  (let ((plist register-alist)
        (value)
        (flag-p nil))

    (while (and plist
                (not flag-p))
      (setq value (car (car plist)))
      (if (equal value r)
          (progn
            (setq flag-p t)
            t))
      (setq plist (cdr plist))
      )

    ;; flag-p is t when found
    (if flag-p
        t
      nil))) 
(defun peng-window-configuration-to-register ()
  "put window configuration to register, when register is
used. Make sure override or not"
  (interactive)
  (let ((r (read-char  "Put windows  to register: ")))

    (if (peng-found-in-register-alist-p  r)
        (progn
          (if (y-or-n-p "The register is in using, Override or not?")
              (progn
                (window-configuration-to-register r)
                (message "Save windows-conf-in %s" (char-to-string r))
                )
            (message "Do not thing")))
      (progn
        (window-configuration-to-register r)
        (message "Save windows-conf-in %s" (char-to-string r))
        )
      )))

(defun peng-evil-insert-to-normal-mode ()
  "save buffer and return normal mode"
  (interactive)
  (save-buffer)
  (evil-normal-state))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; extract bookmark from html file exported from chrome
(defun peng-extract-htmlurls-to-buffer (fname)
  "Extract HTML href url's,titles to org-mode buffers"
  (setq in-buf (set-buffer (find-file fname))); Save for clean up
  (beginning-of-buffer); Need to do this in case the buffer is already open
  (setq u1 '())
  (while
      (re-search-forward "^.*<a href=\"\\([^\"]+\\)\"[^>]+>\\([^<]+\\)</a>" nil t)

    (when (match-string 0)            ; Got a match
      (setq url (match-string 1) )    ; URL
      (setq title (match-string 2) )  ; Title
      (setq title (replace-regexp-in-string "\\[" "{" title))
      (setq title (replace-regexp-in-string "\\]" "}" title))
      (setq u1 (cons (concat "[[" url "][" title "]]\n") u1)) ; Build the list of URLs
      ))
  (kill-buffer in-buf)          ; Don't leave a mess of buffers

  (progn
    (with-current-buffer (get-buffer-create "new-urls.org"); Send results to new buffer
      (mapcar 'insert u1))
    (switch-to-buffer "new-urls.org"); Finally, show the new buffer
    (org-mode)
    ))

(defun peng-create-my-bookmarks ()
  "Create org format bookmarks interactively."
  (interactive)
  (let ((input-file (ido-read-file-name "From html bookmark file:")))
    (peng-extract-htmlurls-to-buffer input-file)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun peng-test ()
  "Kill all buffers."
  (interactive)
  (mapc 'kill-buffer 
        (buffer-list))
  (message "All buffer killed"))

(defun peng-ivy-ls-git ()
  "Find file in the current Git repository."
  (interactive)
  (let* ((default-directory (locate-dominating-file
                             default-directory ".git"))
         (cands (split-string
                 (shell-command-to-string
                  "git ls-files --full-name --")
                 "\n"))
         (file (ivy-read "Find file: " cands)))
    (when file
      (find-file file))))

(defun peng-recompile ()
  "recompile and switch back to the previous buffer"
  (interactive)
  (let ((bname (buffer-name)))
    (recompile)
    (switch-to-buffer-other-window bname)))

(defun peng-edit-current-file-as-root ()
  "edit current file as root and kill the general buffer"
  (interactive)
  (let ((root-name (concat "/sudo::" (buffer-file-name)))
        (killed-buffer (buffer-name)))
    (kill-buffer killed-buffer)
    (find-file root-name)))


(defun peng-async-exec-current-line ()
  "exec current lineas shell command"
  (interactive)
  (async-shell-command (thing-at-point 'line t)))

(defun peng-async-exec-current-line-or-marked-region ()
  "exec current lineas shell command if not mark. or, exec the
marked region"
  (interactive)
  (if mark-active
      (async-shell-command (buffer-substring (mark) (point)))
    (async-shell-command (thing-at-point 'line t))))

(defun peng-swiper-current-symbol ()
  (interactive)
  (let ((symbol (thing-at-point 'symbol)))
    (swiper symbol)))

(defun peng-clear-register ()
  (interactive)
  (setq register-alist nil))

(defun peng-isearch-select-region-forward ()
  "search the select region forward"
  (interactive)
  (if (use-region-p)
      (let* ((beg (region-beginning))
             (text (buffer-substring-no-properties beg (region-end))))
        (setq mark-active nil)
        (goto-char beg)
        (isearch-forward nil t)
        (isearch-yank-string text))
    (call-interactively 'isearch-forward)))

(defun my-insert-abusolute-file-name (filename &optional args)
  "Insert name of file FILENAME into buffer after point.
  
  Prefixed with \\[universal-argument], expand the file name to
  its fully canocalized path.  See `expand-file-name'.
  
  Prefixed with \\[negative-argument], use relative path to file
  name from current directory, `default-directory'.  See
  `file-relative-name'.
  
  The default with no prefix is to insert the file name exactly as
  it appears in the minibuffer prompt."
  ;; Based on insert-file in Emacs -- ashawley 20080926
  (interactive "*fInsert file name: \nP")
  (cond ((eq '- args)
         (insert (file-relative-name filename)))
        ((not (null args))
         (insert (expand-file-name filename)))
        (t
         (insert filename))))

(defun my-insert-file-name (filename &optional args)
  "Insert name of file FILENAME into buffer after point.
  
  Prefixed with \\[universal-argument], expand the file name to
  its fully canocalized path.  See `expand-file-name'.
  
  Prefixed with \\[negative-argument], use relative path to file
  name from current directory, `default-directory'.  See
  `file-relative-name'.
  
  The default with no prefix is to insert the file name exactly as
  it appears in the minibuffer prompt."
  ;; Based on insert-file in Emacs -- ashawley 20080926
  (interactive "*fInsert file name: \nP")
  (insert (file-name-nondirectory filename)))

(defun peng-replace-current-symbol-with-kill-ring ()
  (interactive)
  (let* ((begin (progn
                  (beginning-of-thing 'symbol)
                  (point)))
         (end (progn
                (end-of-thing 'symbol)
                (point))))

    (progn
      (beginning-of-thing 'symbol)
      (delete-char (- end begin))
      (yank))
    ))

(defun xah-cut-line-or-region ()
  "Cut current line, or text selection.
When `universal-argument' is called first, cut whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2015-06-10"
  (interactive)
  (if current-prefix-arg
      (progn ; not using kill-region because we don't want to include previous kill
        (kill-new (buffer-string))
        (delete-region (point-min) (point-max)))
    (progn (if (use-region-p)
               (kill-region (region-beginning) (region-end) t)
             (kill-region (line-beginning-position) (line-beginning-position 2))))))

(defun xah-cut-all-or-region ()
  "Cut the whole buffer content to `kill-ring', or text selection if there's one.
Respects `narrow-to-region'.
URL `http://ergoemacs.org/emacs/emacs_copy_cut_all_or_region.html'
Version 2015-08-22"
  (interactive)
  (if (use-region-p)
      (progn
        (kill-new (buffer-substring (region-beginning) (region-end)))
        (delete-region (region-beginning) (region-end)))
    (progn
      (kill-new (buffer-string))
      (delete-region (point-min) (point-max)))))

(defun peng-shutdown ()
  (interactive)
  (async-shell-command (concat (getenv "HOME")
                               "/bin/p_shutdown.sh")))



(if (string= system-type "gnu/linux")
    (defun peng-open-electronic-wechat ()
      (interactive)
      (async-shell-command "/usr/local/electronic-wechat-linux-x64/electronic-wechat &"))
  )

(provide 'init-peng-prifun)
