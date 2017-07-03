;;; package --- pengpengxp-cc-mode 
;;; open gnome-terminal to make and run

(require 'xcscope)

(defun peng-c-gnome-terminal-make-and-run ()
  (interactive)
  (save-window-excursion
    (save-restriction
      (let ((result (shell-command "make clean;make")))
	(if (string= (message "%s" result) "0")
	    (if (y-or-n-p "run the program?y-or-not?")
		(shell-command "gnome-terminal -x bash -c \"./a.out;exec bash\" "))
	  (message "make occur some error"))))))


(defun peng-cscope-find-this-symbol-no-prompting ()
  (interactive)
  (let ((symbol (thing-at-point 'symbol)))
    (cscope-find-this-symbol symbol)))

(defun pengpengxp-c-common-mode ()
  (which-function-mode)
  ;; (company-mode 1)
  (ycmd-mode -1)
  (setq indent-tabs-mode nil)
  (peng-local-set-key (kbd "C-c C-v") 'compile)
  (yas-minor-mode 1)
  (linum-mode 0)			;show the line number
  (local-set-key (kbd "C-j") 'view-stardict-in-buffer)
  ;; for the #if #else #endif
  ;; (define-key evil-normal-state-map (kbd "M-.") 'peng-helm-etags-select) ; shoule be file local!!
  (local-set-key (kbd "C-c C-u") 'c-up-conditional-with-else)
  (local-set-key (kbd "C-c C-n") 'c-down-conditional-with-else)
  (local-set-key (kbd "<f5> c") '(lambda ()
				   (interactive)
				   (cond ((string= major-mode "c-mode")
					  (compile (concat "gcc -g "
							   (buffer-file-name)
							   ";./a.out")))
					 ((string= major-mode "c++-mode")
					  (compile (concat "g++ -g "
							   (buffer-file-name)
							   ";./a.out")))
					 )))
  (local-set-key (kbd "<f7>") 'peng-c-gnome-terminal-make-and-run)
  (define-key evil-normal-state-local-map (kbd "C-;") '(lambda ()
                                                         (interactive)
                                                         (goto-char (line-end-position))
                                                         (insert-string ";")))
  (define-key evil-normal-state-local-map (kbd "M-;") 'comment-dwim)
  (local-set-key (kbd "M-;") 'comment-dwim)
  (local-set-key (kbd "<f5> o") '(lambda ()
				   (interactive)
				   (cond ((string= major-mode "c-mode")
					  (compile (concat "gcc -g "
							   (buffer-file-name)
							   )))
					 ((string= major-mode "c++-mode")
					  (compile (concat "g++ -g "
							   (buffer-file-name)
							   )))
					 )))
  (local-set-key (kbd "<f5> m") '(lambda ()
				   (interactive)
				   (compile "make clean;make;./a.out")))
  (local-set-key (kbd "<f5> l") '(lambda ()
				   (interactive)
				   (list-tags (buffer-file-name))))
  (hs-minor-mode)
  (local-set-key (kbd "C-c t") 'hs-toggle-hiding)
  (c-set-style "k&r")
  (setq c-basic-offset 4)		;`c-set-style'中会设置这个值，所以一定要在其之后
  (hl-line-mode 1)
  (autopair-on)
  (smartparens-mode -1)
  ;; (evil-close-folds)			;每次打开文件都是折叠的
  (define-key evil-normal-state-local-map (kbd "zi") 'hide-ifdefs)
  (define-key evil-normal-state-local-map (kbd "SPC v") 'hydra-cscope/body)

  ;; (define-key evil-normal-state-local-map (kbd "SPC n") '(lambda ()
  ;; 							   (interactive)
  ;; 							   (cond ((string= major-mode "c-mode")
  ;; 								  (compile (concat "gcc -g "
  ;; 										   (buffer-file-name)
  ;; 										   " -lpthread -lpcap;./a.out")))
  ;; 								 ((string= major-mode "c++-mode")
  ;; 								  (compile (concat "g++ -g "
  ;; 										   (buffer-file-name)
  ;; 										   " -lpthread -lpcap;./a.out")))
  ;; 								 )))
  ;; (peng-local-set-key (kbd "C-c C-c") '(lambda ()
  ;;       				 (interactive)
  ;;       				 (cond ((string= major-mode "c-mode")
  ;;       					(compile (concat "gcc -g "
  ;;       							 (buffer-file-name)
  ;;       							 " -pthread;./a.out")))
  ;;       				       ((string= major-mode "c++-mode")
  ;;       					(compile (concat "g++ -g "
  ;;       							 (buffer-file-name)
  ;;       							 " -pthread ;./a.out")))
  ;;       				       )))
  ;; (define-key evil-normal-state-local-map (kbd "SPC m") '(lambda ()
  ;;       						   "Interrupt old compilation, if any, and recompile."
  ;;       						   (interactive)
  ;;       						   (ignore-errors 
  ;;       						     (process-kill-without-query 
  ;;       						      (get-buffer-process
  ;;       						       (get-buffer "*compilation*"))))
  ;;       						   (ignore-errors 
  ;;       						     (kill-buffer "*compilation*"))
  ;;       						   (compile "make clean;make")))
  ;; (define-key evil-normal-state-local-map (kbd "SPC RET") 'cscope-find-global-definition-no-prompting)
  ;; (define-key evil-normal-state-local-map (kbd "SPC <return>") 'cscope-find-global-definition-no-prompting)


  
  (define-key evil-normal-state-local-map (kbd "<M-return>") 'cscope-find-global-definition-no-prompting)
  (define-key evil-normal-state-local-map (kbd "<C-return>") 'peng-cscope-find-this-symbol-no-prompting)
  
  (define-key evil-normal-state-local-map (kbd "C-]") 'etags-select-find-tag-at-point)
  (define-key evil-normal-state-map (kbd "M-.") 'find-tag) ; shoule be file local!!

  ;; (peng-local-set-key (kbd "<tab>") 'company-complete)
  ;; (peng-local-set-key (kbd "<tab>") 'irony-completion-at-point-async)
  ;; (peng-local-set-key (kbd "TAB") 'irony-completion-at-point-async)
  (peng-local-set-key (kbd "M-DEL") 'cscope-pop-mark)
  (peng-local-set-key (kbd "<M-backspace>") 'cscope-pop-mark)
  (peng-local-set-key (kbd "<C-down-mouse-1>") 'etags-select-find-tag-at-point)
  (peng-local-set-key (kbd "<mouse-3>") 'pop-tag-mark)
  (dumb-jump-mode 1)

  )
(add-hook 'c-mode-hook 'pengpengxp-c-common-mode)
(add-hook 'c++-mode-hook 'pengpengxp-c-common-mode)

;;use <RET> to indent a new line 
(defun my-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-make-CR-do-indent)

;;; for use of irony
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(provide 'init-cc-mode)
