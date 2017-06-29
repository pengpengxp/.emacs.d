;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;write scheme in emacs
(require 'cmuscheme)
(require 'smart-tab)

(setq scheme-program-name "mit-scheme")	;scheme is the default interpreter,here I change it to racket

(defun kh/get-scheme-proc-create ()
  "Create one scheme process if no one is created."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name))))

(defun peng-scheme-send-last-sexp ()
  "A replacement of original `scheme-send-last-sexp':
1. check if scheme process exists, otherwise create one
2. make sure the frame is splitted into two windows, current one is the scheme
   source code window, the other one is the scheme process window
3. run `scheme-send-last-sexp'

PS: this function is inspired by Wang Yin."
  (interactive)
  (kh/get-scheme-proc-create)
  (cond ((= 2 (count-windows))
         (other-window 1)
         (unless (string= (buffer-name)
                          scheme-buffer)
           (switch-to-buffer scheme-buffer))
         (other-window 1))
        (t
         (delete-other-windows)
         (split-window-right)
         (other-window 1)
         (switch-to-buffer scheme-buffer)
         (other-window 1)))
  (scheme-send-last-sexp))

(defun peng-scheme-load-current-file ()
  (interactive)
  (scheme-load-file (buffer-file-name))
  (cond ((= 2 (count-windows))
         (other-window 1)
         (unless (string= (buffer-name)
                          scheme-buffer)
           (switch-to-buffer scheme-buffer))
         (other-window 1))
        (t
         (delete-other-windows)
         (split-window-right)
         (other-window 1)
         (switch-to-buffer scheme-buffer)
         (other-window 1)))
  )

(defun peng-scheme-send-current-line ()
  (interactive)
  (goto-char (line-end-position))
  (peng-scheme-send-last-sexp)
  (cond ((= 2 (count-windows))
         (other-window 1)
         (unless (string= (buffer-name)
                          scheme-buffer)
           (switch-to-buffer scheme-buffer))
         (other-window 1))
        (t
         (delete-other-windows)
         (split-window-right)
         (other-window 1)
         (switch-to-buffer scheme-buffer)
         (other-window 1)))
)

(defun peng-scheme-send-region ()
  (interactive)
  (scheme-send-region (region-beginning)
		      (region-end))
  (cond ((= 2 (count-windows))
         (other-window 1)
         (unless (string= (buffer-name)
                          scheme-buffer)
           (switch-to-buffer scheme-buffer))
         (other-window 1))
        (t
         (delete-other-windows)
         (split-window-right)
         (other-window 1)
         (switch-to-buffer scheme-buffer)
         (other-window 1)))
  )

(add-hook 'scheme-mode-hook '(lambda ()
			       (interactive)
			       (smart-tab-mode-on)
			       ;; (peng-local-set-key (kbd "<tab>") 'indent-for-tab-command)
			       ;; (peng-local-set-key (kbd "<tab>") 'smart-tab)
			       ;; (peng-local-set-key (kbd "<backtab>") 'ac-trigger-key-command)
			       (peng-local-set-key (kbd "<f5> r") 'peng-scheme-send-region)
			       (peng-local-set-key (kbd "<f5> l") 'peng-scheme-send-current-line)
			       (peng-local-set-key (kbd "<f5> f") 'peng-scheme-load-current-file)
			       (peng-local-set-key (kbd "C-x C-e") 'peng-scheme-send-last-sexp)
			       (peng-local-set-key (kbd "C-c C-r") 'peng-scheme-send-region)
			       (peng-local-set-key (kbd "C-c C-f") 'peng-scheme-load-current-file)
			       (paredit-mode 1)
			       (auto-complete-mode 1)
			       ))

(add-hook 'inferior-scheme-mode-hook '(lambda ()
					(company-mode-on)
					))

;;;;;;inter scheme-mode while the suffix of file is scheme
(setq auto-mode-alist
      (append
       ;;File name ends in '.scheme'
       '(("\\.scheme\\'". scheme-mode))
       auto-mode-alist))

(provide 'init-scheme)
