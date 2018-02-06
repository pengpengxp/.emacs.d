(let* ((current-desktop (replace-regexp-in-string "\n$" ""
                                                    (shell-command-to-string
                                                     "wmctrl -d | grep '*' | cut -d ' ' -f1")))
         (my-server-socket-dir (concat "/tmp/emacs-desktop-"
                                    current-desktop)))
    (setq server-socket-dir my-server-socket-dir))

(defun peng-server-start ()
  ;; Only start server mode if I'm not root
  (unless (string-equal "root" (getenv "USER"))
    (require 'server)
    (unless
        (server-running-p)
      (server-start))))

;; (defun peng-start-server ()
;;   (interactive)
;;   (let* ((current-desktop (replace-regexp-in-string "\n$" ""
;;                                                     (shell-command-to-string
;;                                                      "wmctrl -d | grep '*' | cut -d ' ' -f1")))
;;          (server-socket-dir (concat "/tmp/emacs-desktop-"
;;                                     current-desktop)))
;;     (peng-server-start)
;;     ))

(peng-server-start)

(provide 'init-server)

(provide 'init-server)
