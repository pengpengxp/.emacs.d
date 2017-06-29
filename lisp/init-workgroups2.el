(require 'workgroups2)
;; Your settings here

;;(setq wg-session-load-on-start t)    ; default: (not (daemonp))

;; Change prefix key (before activating WG)
(setq wg-prefix-key (kbd "C-c z"))

;; Change workgroups session file
(setq wg-session-file "~/.emacs.d/.emacs_workgroups")

;; Set your own keyboard shortcuts to reload/save/switch WGs:
;; "s" == "Super" or "Win"-key, "S" == Shift, "C" == Control

;; (global-set-key (kbd "<pause>")     'wg-reload-session)
;; (global-set-key (kbd "C-S-<pause>") 'wg-save-session)
;; (global-set-key (kbd "s-z")         'wg-switch-to-workgroup)
;; (global-set-key (kbd "s-/")         'wg-switch-to-previous-workgroup)

(workgroups-mode 1)   ; put this one at the bottom of .emacs

(defun peng-wg-delete-workgroup ()
  (interactive)
  (let* ((wgs (wg-workgroup-names))
        (name (ido-completing-read "Kill to new workgroups: " wgs)))
    (message "%s" name)

    (if (yes-or-no-p (format "Do you realy want to kill workgroup %s?" name))
        (progn
          (wg-delete-workgroup (wg-find-workgroup-by :name name))
          (message "killed workgroup %s" name))
      (message "Not kill it."))
    ))

(defun peng-clone-current-to-new-workgroup ()
  (interactive)
  (let* ((wgs (wg-workgroup-names))
        (new-name (ido-completing-read "Clone to new workgroups: " wgs)))
    (message "%s" new-name)
    (wg-clone-workgroup nil new-name)
    ))

(defun peng-switch-to-workgroup ()
  (interactive)
  (let* ((wgs (wg-workgroup-names))
        (new-name (ido-completing-read "Switch to new workgroups: " wgs)))
    (wg-switch-to-workgroup (aref (wg-find-workgroup-by :name new-name) 2))
    ))

(defun peng-switch-to-main-workgroup ()
  (interactive)
    (wg-switch-to-workgroup (aref (wg-find-workgroup-by :name "Main") 2)))

(define-key wg-prefixed-map (kbd "k") 'peng-wg-delete-workgroup)



;;; make each workgroup have different register begin
(setq my-global-register-alist (make-hash-table)) 
(defun peng-find-current-wg-name ()
  (intern (wg-workgroup-name (wg-current-workgroup))))
(defun peng-before-workgroups-switch-fun ()
  (interactive)
  (let* ((key (peng-find-current-wg-name)))
    (progn
      (setf (gethash key my-global-register-alist) register-alist)
      (setq register-alist nil))))

(defun peng-after-workgroups-switch-fun ()
  (interactive)
  (let* ((key (peng-find-current-wg-name)))
    (progn
      (setq register-alist (gethash key my-global-register-alist)))))
(add-hook 'wg-after-switch-to-workgroup-hook #'peng-after-workgroups-switch-fun)
(add-hook 'wg-before-switch-to-workgroup-hook #'peng-before-workgroups-switch-fun)
;;; make each workgroup have different register end


(provide 'init-workgroups2)
