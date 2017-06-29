
(if (string-equal system-type "darwin")
    (progn

      (defun iterm-goto-filedir-or-home ()
        "Go to present working dir and focus iterm"
        (interactive)
        (do-applescript
         (concat
          " tell application \"iTerm2\"\n"
          "   tell the current session of current window\n"
          (format "     write text \"cd %s\" \n"
                  ;; string escaping madness for applescript
                  (replace-regexp-in-string "\\\\" "\\\\\\\\"
                                            (shell-quote-argument (or default-directory "~"))))
          "   end tell\n"
          " end tell\n"
          " do shell script \"open -a iTerm\"\n"
          )))



      (defun iterm-focus ()
        (interactive)
        (do-applescript
         " do shell script \"open -a iTerm\"\n"
         ))

      (defun peng-iterm-here ()
        (interactive)
        (dired-smart-shell-command "open -a iTerm $PWD" nil nil))

      (defun peng-mac-open-terminal ()
        (interactive)
        (let ((dir ""))
          (cond
           ((and (local-variable-p 'dired-directory) dired-directory)
            (setq dir dired-directory))
           ((stringp (buffer-file-name))
            (setq dir (file-name-directory (buffer-file-name))))
           ((stringp default-directory)
            (setq dir default-directory))
           )
          (do-applescript
           (format "
 tell application \"Terminal\"
   activate
   try
     do script with command \"cd %s\"
   on error
     beep
   end try
 end tell" dir))
          ))

      ))



(provide 'init-iterm2)
