;;; init-test.el --- 

;;;This is where I make some test

(defun peng-rtags-find-symbol-at-point ()
  (interactive)
  (let ((org-point (point)))

  (rtags-find-symbol-at-point)

  (if (equal org-point (point))
      (message "yes")
    (message "no"))
    ))

(defun peng-point ()
  (interactive) (message "%s" (point)))

(defun peng-test ()
  (interactive)
  (let* ((tags-list (list
                     '("rtags" . rtags-find-symbol-at-point)
                     '("gtags" . peng-counsel-gtags-dwim)
                     '("cscope" . (lambda () (cscope-find-this-symbol (thing-at-point 'symbol))))))
         (original-point (point-marker))
         )
    (defun peng-find-definition-success ()
      (if (not (equal (point-marker) original-point))
          t
        nil))

    (message "%s found the result!" (catch 'finish
                                      (mapc
                                       (lambda (x)

                                         (funcall (cdr x))

                                         (if (peng-find-definition-success)
                                             (throw 'finish "xiepeng"))
                                         )
                                       tags-list)
                                      ))
                                       ))

(provide 'init-test)



