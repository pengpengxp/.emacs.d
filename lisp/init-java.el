;;; init-java.el --- 
;; 
;; Filename: init-java.el
;; 
;; Description: This is the initial file of my java-mode. I use jdee
;; to write java in emacs.
;; 
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 日  1月  4 20:38:33 2015 (+0800)
;; Version: 
;; Last-Updated: 一  1月  5 15:08:10 2015 (+0800)
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

(load "jde")

(setq jde-jdk-registry (quote (("1.8.0_05" . "/usr/local/jdk1.8.0_05/") ("test" . "/tmp/"))))
(setq jde-jdk (quote ("1.8.0_05")))
(setq jde-compiler (quote ("javac")))
(setq jde-complete-function 'jde-complete-minibuf)
(setq jde-compile-enable-kill-buffer 0.1)


(add-hook 'jde-run-mode-hook '(lambda ()
				(interactive)
				(peng-local-set-key (kbd "<backspace>") '(lambda ()
									   (interactive)
									   (progn
									     (bury-buffer)
									     (delete-window)
									     )))
				(peng-local-set-key (kbd "DEL") '(lambda ()
									   (interactive)
									   (progn
									     (bury-buffer)
									     (delete-window)
									     )))
				))
(add-hook 'jde-mode-hook (lambda ()
			   (interactive)
			   (yas-minor-mode-on)
			   (autopair-mode 1)
			   ))

;;; useless temporarily, I just need a function to combine the
;;; jde-compile and jde-run
;; (defun peng-jde-easy-compile-and-run ()
;;   "run the easiest compile command"
;;   (interactive)
;;   (progn
;;     (compile (concat "javac "
;; 		     (format "%s" (buffer-file-name))
;; 		     " ;java "
;; 		     (format "%s" (file-name-base))))
;;     ))

;;; don't let jde-compile ask the stupid questions
(defadvice jde-compile (around sjfu activate)
  (flet ((yes-or-no-p (&rest args) t)
	 (y-or-n-p (&rest args) t))
    ad-do-it))

;;; It active ugly. Need to improve it
(defun peng-jde-compile-and-run (prefix)
"compile the file and run the class"
  (interactive "p")
  (jde-compile)
  (jde-run prefix)
)

(add-hook 'jde-mode-hook '(lambda ()
			    (interactive)
			    (peng-local-set-key (kbd "<f5> <f5>") 'compile)
			    (peng-local-set-key (kbd "<f5> r") 'recompile)
			    (peng-local-set-key (kbd "<f5> cr") 'jde-run)
			    (peng-local-set-key (kbd "<f5> cc") 'jde-compile)
			    (peng-local-set-key (kbd "<f5> v") 'peng-jde-compile-and-run)
			    (define-key evil-normal-state-local-map (kbd "SPC v") 'jde-compile)
			    (define-key evil-normal-state-local-map (kbd "SPC r") 'jde-run)
			    (define-key evil-normal-state-local-map (kbd "SPC m") '(lambda ()
										     "Interrupt old compilation, if any, and recompile."
										     (interactive)
										     (ignore-errors 
										       (process-kill-without-query 
											(get-buffer-process
											 (get-buffer "*compilation*"))))
										     (ignore-errors 
										       (kill-buffer "*compilation*"))
										     (compile "make clean;make")))

))

(provide 'init-java.el)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-java.el ends here
