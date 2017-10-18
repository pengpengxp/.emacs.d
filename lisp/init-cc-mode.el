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

(defun peng-setup-cc-mode-for-complete ()
  "use tab to indent and complete.
tab on left will act as indent while on the right of character as
`completion-at-point'
"
  (interactive)
  (setq c-tab-always-indent 'nil)
  ;; (setq c-insert-tab-function #'completion-at-point)
  (setq c-insert-tab-function #'company-complete)
  )

(defun peng-compile-current-c-or-cpp-file ()
  "compile current c or cpp file and run ./a.out"
  (interactive)
  (cond ((string= major-mode "c-mode")
         (compile (concat "gcc -g "
                          (buffer-file-name)
                          ";./a.out")))
        ((string= major-mode "c++-mode")
         (compile (concat "g++ -g "
                          (buffer-file-name)
                          ";./a.out")))
        ))

(defun peng-add-end-semicolon ()
  (interactive)
  (goto-char (line-end-position))
  (insert-string ";"))


(defun pengpengxp-c-common-mode ()
  (which-function-mode)
  (setq indent-tabs-mode nil)
  ;; (peng-local-set-key (kbd "C-c C-v") 'compile)
  (peng-local-set-key (kbd "C-c C-v") 'peng-compile-current-c-or-cpp-file)
  (yas-minor-mode 1)
  (linum-mode 1)			;show the line number
  (local-set-key (kbd "C-j") 'view-stardict-in-buffer)
  ;; for the #if #else #endif
  ;; (define-key evil-normal-state-map (kbd "M-.") 'peng-helm-etags-select) ; shoule be file local!!
  (local-set-key (kbd "C-c C-u") 'c-up-conditional-with-else)
  (local-set-key (kbd "C-c C-n") 'c-down-conditional-with-else)
  (local-set-key (kbd "<f5> c") #'peng-compile-current-c-or-cpp-file)
  (local-set-key (kbd "<f7>") 'peng-c-gnome-terminal-make-and-run)
  (define-key evil-normal-state-local-map (kbd "C-;") #'peng-add-end-semicolon)
  (define-key evil-normal-state-local-map (kbd "M-;") 'comment-dwim)
  (local-set-key (kbd "M-;") 'comment-dwim)
  (local-set-key (kbd "<f5> o") #'peng-compile-current-c-or-cpp-file)
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
  ;; (evil-close-folds)			;每次打开文件都是折叠的
  (define-key evil-normal-state-local-map (kbd "zi") 'hide-ifdefs)
  (define-key evil-normal-state-local-map (kbd "SPC v") 'hydra-cscope/body)
  (define-key evil-normal-state-local-map (kbd "SPC m") 'hydra-cc-mode/body)
  (define-key evil-normal-state-local-map (kbd "<M-return>") 'cscope-find-global-definition-no-prompting)
  (define-key evil-normal-state-local-map (kbd "<kp-enter>") 'cscope-find-global-definition-no-prompting)
  (define-key evil-normal-state-local-map (kbd "<C-return>") 'peng-cscope-find-this-symbol-no-prompting)
  (define-key evil-normal-state-local-map (kbd "<kp-delete>") 'peng-cscope-find-this-symbol-no-prompting)
  (define-key evil-normal-state-local-map (kbd "C-]") 'etags-select-find-tag-at-point)

  (peng-local-set-key (kbd "M-DEL") 'cscope-pop-mark)
  (peng-local-set-key (kbd "<kp-insert>") 'cscope-pop-mark)
  (peng-local-set-key (kbd "<M-backspace>") 'cscope-pop-mark)
  (peng-local-set-key (kbd "<C-down-mouse-1>") 'etags-select-find-tag-at-point)
  (peng-local-set-key (kbd "<mouse-3>") 'pop-tag-mark)
  (peng-local-set-key (kbd "<kp-subtract>") 'cscope-find-functions-calling-this-function)

  (dumb-jump-mode 1)
  (peng-setup-cc-mode-for-complete)

  (peng-setup-ycmd)
  (company-mode 1)

  )
(add-hook 'c-mode-hook 'pengpengxp-c-common-mode)
(add-hook 'c++-mode-hook 'pengpengxp-c-common-mode)

;;use <RET> to indent a new line 
(defun my-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-make-CR-do-indent)


;; (require 'semantic)
;; (global-semanticdb-minor-mode 1)
;; (global-semantic-idle-scheduler-mode 1)
;; (global-semantic-stickyfunc-mode 1)
;; (semantic-mode 1)
;; (defun alexott/cedet-hook ()
;;   (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
;;   (local-set-key "\C-c\C-s" 'semantic-ia-show-summary))
;; (add-hook 'c-mode-common-hook 'alexott/cedet-hook)
;; (add-hook 'c-mode-hook 'alexott/cedet-hook)
;; (add-hook 'c++-mode-hook 'alexott/cedet-hook)


;;; use `counsel-gtags'
(add-hook 'c-mode-hook 'counsel-gtags-mode)
(add-hook 'c++-mode-hook 'counsel-gtags-mode)
;; (with-eval-after-load 'counsel-gtags
;;   (define-key counsel-gtags-mode-map (kbd "M-t") 'counsel-gtags-find-definition)
;;   (define-key counsel-gtags-mode-map (kbd "M-r") 'counsel-gtags-find-reference)
;;   (define-key counsel-gtags-mode-map (kbd "M-s") 'counsel-gtags-find-symbol)
;;   (define-key counsel-gtags-mode-map (kbd "M-,") 'counsel-gtags-go-backward)
;;   )

(defun peng-cc-mode-counsel-gtags-mode ()
  (interactive)
  (peng-local-set-key (kbd "M-t") 'counsel-gtags-find-definition)
  (peng-local-set-key (kbd "M-r") 'counsel-gtags-find-reference)
  (peng-local-set-key (kbd "M-S") 'counsel-gtags-find-symbol)
  (peng-local-set-key (kbd "M-.") 'counsel-gtags-dwim)
  (peng-local-set-key (kbd "M-SPC") 'counsel-gtags-dwim)
  (peng-local-set-key (kbd "M-f") 'counsel-gtags-find-file)
  (peng-local-set-key (kbd "<XF86Back>") 'counsel-gtags-go-backward)
  (peng-local-set-key (kbd "<S-left>") 'counsel-gtags-go-backward)
  (peng-local-set-key (kbd "<S-right>") 'counsel-gtags-go-forward)
  (peng-local-set-key (kbd "<XF86Forward>") 'counsel-gtags-go-forward)

  (define-key evil-normal-state-local-map (kbd "M-u") #'(lambda ()
                                                          (interactive)
                                                          (let (current-prefix-arg)
                                                            (setq current-prefix-arg '(4))
                                                            (call-interactively 'counsel-gtags-update-tags)
                                                            )))
  (define-key evil-normal-state-local-map (kbd ".") 'counsel-gtags-dwim)
  (define-key evil-normal-state-local-map (kbd "<return>") 'counsel-gtags-dwim)
  (define-key evil-normal-state-local-map (kbd "RET") 'counsel-gtags-dwim)
  (define-key evil-normal-state-local-map (kbd "<C-backspace>") 'counsel-gtags-go-backward)
  (define-key evil-normal-state-local-map (kbd "<") 'counsel-gtags-go-backward)
  (define-key evil-normal-state-local-map  (kbd ">") 'counsel-gtags-go-forward)

  (define-key evil-normal-state-local-map (kbd "<f1>") 'counsel-gtags-go-backward)
  (define-key evil-normal-state-local-map  (kbd "<f2>") 'counsel-gtags-go-forward)
  )

;;; set to auto update gtags
(setq counsel-gtags-auto-update t)

(add-hook 'c-mode-hook 'peng-cc-mode-counsel-gtags-mode)
(add-hook 'c++-mode-hook 'peng-cc-mode-counsel-gtags-mode)


(provide 'init-cc-mode)
