(defun peng-makefile-mode-make ()
  (interactive)
  (compile "make"))

(add-hook 'makefile-bsdmake-mode-hook '(lambda ()
					 (interactive)
					 (peng-local-set-key (kbd "C-c C-v") 'compile)
					 ))

(add-hook 'makefile-mode-hook '(lambda ()
					 (interactive)
					 (peng-local-set-key (kbd "C-c C-v") 'compile)
                                         (hl-line-mode 1)
					 ))
;; (add-hook 'makefile-mode-hook '(lambda ()
;; 					 (interactive)
;; 					 (define-key evil-normal-state-local-map (kbd "SPC m") 'peng-makefile-mode-make)
;; 					 ))
;; (add-hook 'makefile-bsdmake-mode-hook '(lambda ()
;; 					 (interactive)
;; 					 (define-key evil-normal-state-local-map (kbd "SPC m") 'peng-makefile-mode-make)
;; 					 ))

(add-to-list 'auto-mode-alist
	     '("make.rule" . makefile-bsdmake-mode))

(add-to-list 'auto-mode-alist
	     '("make.subdirs" . makefile-bsdmake-mode))

(add-to-list 'auto-mode-alist
	     '("make.param" . makefile-bsdmake-mode))


(provide 'init-BSDmakefile-mode)
