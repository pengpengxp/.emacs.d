;; (setq pengpengxp-comma-map (make-sparse-keymap))

;;; 等待我写一出自己的`keymap'

;; (define-prefix-command 'pengpengxp-comma-map)
;; (global-set-key (kbd ",") 'pengpengxp-comma-map)
;; (defun peng-real-insert-comma ()
;;   (interactive)
;;   (insert ","))

;; (define-key pengpengxp-comma-map (kbd ",") 'peng-real-insert-comma)
;; (define-key pengpengxp-comma-map (kbd "x") ctl-x-map)
;; (define-key pengpengxp-comma-map (kbd "x f") 'find-file)



;; (defvar special-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (suppress-keymap map)
;;     (define-key map "q" 'quit-window)
;;     map))

;;;-------------------------------------------------------------------
;;; 
;;; M-c-key
;;; 
;;;-------------------------------------------------------------------
(setq peng-M-c-map (make-sparse-keymap))

(define-key peng-M-c-map (kbd "x") 'kill-region)
(define-key peng-M-c-map (kbd "c") 'capitalize-word)
(define-key peng-M-c-map (kbd "l") 'downcase-word)
(define-key peng-M-c-map (kbd "u") 'upcase-word)
(define-key peng-M-c-map (kbd "b") 'wg-switch-to-workgroup)
(define-key peng-M-c-map (kbd "k") 'ido-kill-buffer)
;; (define-key peng-M-c-map (kbd "f") 'helm-ls-git-ls)
;; (define-key peng-M-c-map (kbd "M-i") 'idomenu)
(define-key peng-M-c-map (kbd "M-i") 'idomenu)
(define-key peng-M-c-map (kbd "M-o") 'swiper) ;swiper is faster than 'helm-occur
;; (define-key peng-M-c-map (kbd "M-o") 'helm-occur)

;; (define-key peng-M-c-map (kbd "M-a") 'helm-ag-this-file)
;; (define-key peng-M-c-map (kbd "M-m") 'shell-command)
;; (define-key peng-M-c-map (kbd "M-A") 'helm-ag-this-file)

(define-key peng-M-c-map (kbd "M-a") 'peng-mark-to-beginning-of-line)
(define-key peng-M-c-map (kbd "M-e") 'peng-mark-to-end-of-line)
(define-key peng-M-c-map (kbd "M-l") 'peng-mark-line)
(define-key peng-M-c-map (kbd "M-m") 'peng-mark-back-to-indentation)
(define-key peng-M-c-map (kbd "M-w") 'peng-mark-current-word)

(define-key peng-M-c-map (kbd "M-f") 'find-file)
(define-key peng-M-c-map (kbd "M-s") 'swiper)
(define-key peng-M-c-map (kbd "M-j") 'ido-bookmark-jump)
(define-key peng-M-c-map (kbd "M-b") 'wg-switch-to-workgroup)
(define-key peng-M-c-map (kbd "M-r") 'ido-recentf-find-file)
(define-key peng-M-c-map (kbd "M-z") 'ace-jump-zap-to-char)
(define-key peng-M-c-map (kbd "M-d") 'darkroom-mode)
(define-key peng-M-c-map (kbd "M-y") 'yas-ido-expand)
;; (define-key peng-M-c-map (kbd "C-x C-f") 'ido-find-file)
(define-key peng-M-c-map (kbd "C-x C-f") 'find-file)

(define-key peng-M-c-map (kbd "go") 'peng-ibuffer-filter-org-mode)
(define-key peng-M-c-map (kbd "gc") 'peng-ibuffer-filter-c-mode)
(define-key peng-M-c-map (kbd "ge") 'peng-ibuffer-filter-emacs-lisp-mode)
(define-key peng-M-c-map (kbd "gs") 'peng-ibuffer-filter-sql-mode)
(define-key peng-M-c-map (kbd "gd") 'peng-ibuffer-filter-dired-mode)
(define-key peng-M-c-map (kbd "gp") 'peng-ibuffer-filter-c++-mode)

(define-key global-map (kbd "M-c") peng-M-c-map)
(define-key global-map (kbd "M-z") 'ace-jump-zap-to-char)

;; (peng-global-set-key (kbd "M-x") 'smex)
(peng-global-set-key (kbd "M-x") 'counsel-M-x)


;;; peng goto key binding, use avy
(peng-global-set-key (kbd "M-g M-c") 'avy-goto-char-2)
;; (peng-global-set-key (kbd "M-g M-g") 'avy-goto-char)
(peng-global-set-key (kbd "M-g M-g") 'evil-ace-jump-char-mode)
(peng-global-set-key (kbd "M-g M-l") 'avy-goto-line)
(peng-global-set-key (kbd "M-g M-w") 'avy-goto-word-1)

(peng-global-set-key (kbd "C-x C-f") 'find-file)


;;;-------------------------------------------------------------------
;;; 
;;; evil-key
;;; 
;;;-------------------------------------------------------------------
;; (define-prefix-command 'peng-evil-normal-map)
;;; 定义一个自己的evil-normal-map，这个map是在normal模式下绑定到SPC中
;;; 的。
(setq peng-evil-normal-map (make-sparse-keymap))

;;; `universal-argument'
(define-key peng-evil-normal-map (kbd "u") 'universal-argument)

;;; define two special key for personal use
;; (require 'init-evil-spc-map)

;;; 自己`hack'evil的各状态的快捷键

;;; 定义从`SPC'和`comma'触发的快捷键
;;; normal map

;;; ----------------------------------------------------------------------
;;; 
;;; `:'使用`SPC :'或`;'来调用命令
;;; 
;;; ----------------------------------------------------------------------
;; (define-key peng-evil-normal-map (kbd ":") 'smex)
;; (define-key peng-evil-normal-map (kbd ";") 'smex)
(define-key peng-evil-normal-map (kbd ":") 'counsel-M-x)
(define-key peng-evil-normal-map (kbd ";") 'counsel-M-x)
;;; ----------------------------------------------------------------------
;;; 
;;; x-map
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-ctl-x-map (copy-keymap ctl-x-map))

;; (define-key peng-space-ctl-x-map (kbd "f") 'find-file)
(define-key peng-space-ctl-x-map (kbd "f") 'find-file)
(define-key peng-space-ctl-x-map (kbd "s") 'shell-command)
(define-key peng-space-ctl-x-map (kbd "p") 'pwd)
;;; x-c-map
(setq peng-space-x-c-map (make-sparse-keymap))
(define-key peng-space-x-c-map (kbd "c") 'calendar)
(define-key peng-space-x-c-map (kbd "l") 'calc)
(define-key peng-space-x-c-map (kbd "q") 'quick-calc)
(define-key peng-space-ctl-x-map (kbd "c") peng-space-x-c-map)

(define-key peng-evil-normal-map (kbd "x") peng-space-ctl-x-map)

;;; ----------------------------------------------------------------------
;;; 
;;; h-map 帮助文档
;;; 
;;; ----------------------------------------------------------------------
(define-key peng-evil-normal-map (kbd "h") help-map) ;这个默认进入帮助

;;; ----------------------------------------------------------------------
;;; 
;;; a-map
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-a-map (make-sparse-keymap))
(define-key peng-space-a-map (kbd  "c")  'calc-dispatch)
(define-key peng-space-a-map (kbd  "d")  'dired)
(define-key peng-space-a-map (kbd  "p")  'proced)
(define-key peng-space-a-map (kbd  "u")  'undo-tree-visualize)
;; (define-key peng-space-a-map (kbd  "si") 'shell)
;; (define-key peng-space-a-map (kbd  "sm") 'multi-term)
(define-key peng-space-a-map (kbd  "b") 'ace-jump-buffer)
(define-key peng-space-a-map (kbd  "B") 'ace-jump-buffer-with-configuration)
(define-key peng-space-a-map (kbd  "s") 'ace-jump-same-mode-buffers)
(define-key peng-space-a-map (kbd  "w") 'ace-jump-word-mode)
(define-key peng-evil-normal-map (kbd "a") peng-space-a-map)

;;; ----------------------------------------------------------------------
;;; 
;;; s-map
;;; 
;;; ----------------------------------------------------------------------
;; (setq peng-space-s-map (make-sparse-keymap))
;; (define-key peng-space-s-map (kbd  "d") 'save-buffer)
;; (define-key peng-space-s-map (kbd  "m") 'peng-mark-real-line)
(define-key peng-evil-normal-map (kbd "s") 'save-buffer)

;;; ----------------------------------------------------------------------
;;; 
;;; k-map
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-k-map (make-sparse-keymap))

;;; use highlight
;; (define-key peng-space-k-map (kbd  "f") 'highlight-symbol-at-point)
;; (define-key peng-space-k-map (kbd  "j") 'highlight-symbol-at-point)
;; (define-key peng-space-k-map (kbd  "a") 'peng-unhighlight-all)
;; (define-key peng-space-k-map (kbd  "r") 'highlight-regexp)
;; (define-key peng-space-k-map (kbd  "u") 'unhighlight-regexp)
;; (define-key peng-space-k-map (kbd  "d") 'peng-unhighlight-all)


;;; use symbol-overlay
(setq peng-symbol-overlay-map (make-sparse-keymap))
(define-key peng-symbol-overlay-map (kbd  "SPC") 'symbol-overlay-rename)
(define-key peng-symbol-overlay-map (kbd  "r") 'symbol-overlay-query-replace)
(define-key peng-symbol-overlay-map (kbd  "d") 'symbol-overlay-jump-to-definition)
(define-key peng-symbol-overlay-map (kbd  "s") 'symbol-overlay-save-symbol)
(define-key peng-symbol-overlay-map (kbd  "a") 'symbol-overlay-remove-all)
(define-key peng-symbol-overlay-map (kbd  "n") 'symbol-overlay-jump-next)
(define-key peng-symbol-overlay-map (kbd  "p") 'symbol-overlay-jump-prev)

(define-key peng-space-k-map (kbd  "f") 'symbol-overlay-put)
(define-key peng-space-k-map (kbd  "j") 'symbol-overlay-put)
(define-key peng-space-k-map (kbd  "a") 'symbol-overlay-remove-all)
(define-key peng-space-k-map (kbd  "u") 'symbol-overlay-remove)
(define-key peng-space-k-map (kbd  "d") 'symbol-overlay-jump-to-definition)
(define-key peng-space-k-map (kbd  "n") 'symbol-overlay-jump-next)
(define-key peng-space-k-map (kbd  "p") 'symbol-overlay-jump-prev)
(define-key peng-space-k-map (kbd  "SPC") 'symbol-overlay-rename)
(define-key peng-space-k-map (kbd  "k") peng-symbol-overlay-map)

;; (define-key peng-evil-normal-map (kbd "k") peng-space-k-map)
(define-key peng-evil-normal-map (kbd "k") 'hydra-symbol-overlay/body)

;;; ----------------------------------------------------------------------
;;; 
;;; d-map
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-d-map (make-sparse-keymap))
(define-key peng-space-d-map (kbd  "m") 'peng-mark-real-line)
(define-key peng-space-d-map (kbd  "c") 'peng-get-chrome-current-tab-url-to-org-capture)
(define-key peng-space-d-map (kbd  "C") 'peng-get-chrome-current-tab-url)
(define-key peng-space-d-map (kbd  "j") 'calc)
(define-key peng-space-d-map (kbd  "l") 'linum-mode)
(define-key peng-space-d-map (kbd  "k") 'peng-kill-all-file-relative-buffers)
(define-key peng-space-d-map (kbd  "i") 'iterm-goto-filedir-or-home)
(define-key peng-space-d-map (kbd  "o") 'peng-openstack-find-file)
(define-key peng-space-d-map (kbd  "w") 'peng-w3m-goto-chrome-current-tab-url)
(define-key peng-space-d-map (kbd  "f") 'toggle-fullscreen)
(define-key peng-space-d-map (kbd  "b") 'peng-write-blog)
(define-key peng-space-d-map (kbd  "e") 'eshell-command)
(define-key peng-space-d-map (kbd  "g") 'peng-switch-to-org-buffer)
(define-key peng-space-d-map (kbd  "G") 'peng-generate-org-buffer)
(define-key peng-space-d-map (kbd  "t") 'peng-switch-to-temp-buffer)
(define-key peng-space-d-map (kbd  "T") 'peng-generate-temp-buffer)
(define-key peng-evil-normal-map (kbd "d") peng-space-d-map)

;;; ----------------------------------------------------------------------
;;; 
;;; o-map for launch gui app
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-o-map (make-sparse-keymap))
(define-key peng-space-o-map (kbd  "o") 'xah-open-in-external-app)
(define-key peng-space-o-map (kbd  "d") 'xah-open-in-desktop)
(define-key peng-space-o-map (kbd  "j") 'peng-mac-open-gui-calc)
(define-key peng-space-o-map (kbd  "c") 'peng-mac-open-gui-calendar)
(define-key peng-space-o-map (kbd  "s") 'peng-open-in-desktop-and-select)
(define-key peng-space-o-map (kbd  "g") '(lambda ()
                                           (interactive)
                                           (save-window-excursion
                                             (async-shell-command  "open /Applications/Google\\ Chrome.app")
                                             )))
(define-key peng-space-o-map (kbd  "i") '(lambda ()
                                           (interactive)
                                           (save-window-excursion
                                             (async-shell-command  "open /Users/pengpengxp/Application/iTerm.app")
                                             )))

(define-key peng-evil-normal-map (kbd "o") peng-space-o-map)
;;; ----------------------------------------------------------------------
;;; 
;;; p-map
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-p-map (make-sparse-keymap))
(define-key peng-space-p-map (kbd  "a")  'peng-asp-engine-project-not-open)
(define-key peng-space-p-map (kbd  "A")  'peng-asp-engine-project)
(define-key peng-space-p-map (kbd  "N")  'peng-nginx-project)
(define-key peng-space-p-map (kbd  "n")  'peng-nginx-project-not-open)
(define-key peng-space-p-map (kbd  "e")  'peng-log-parser-project)
(define-key peng-space-p-map (kbd  "j")  'peng-js-project-not-open)
(define-key peng-space-p-map (kbd  "J")  'peng-js-project)
;; (define-key peng-space-p-map (kbd  "s")  'peng-set-river-root-project)

(define-key peng-space-p-map (kbd  "g")  'peng-asp-engine-project-and-ivy-grep)
(define-key peng-space-p-map (kbd  "f")  'peng-asp-engine-project-and-ivy-ls)
(define-key peng-evil-normal-map (kbd "p") peng-space-p-map)

;;; ----------------------------------------------------------------------
;;; 
;;; b-map
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-b-map (make-sparse-keymap))
(define-key peng-space-b-map (kbd "0")  'beginning-of-buffer)
(define-key peng-space-b-map (kbd "$")  'end-of-buffer)
(define-key peng-space-b-map (kbd "K")  'kill-other-buffers)
(define-key peng-space-b-map (kbd "k")  'ido-kill-buffer)
(define-key peng-space-b-map (kbd "n")  'switch-to-next-buffer)
(define-key peng-space-b-map (kbd "p")  'switch-to-prev-buffer)
(define-key peng-space-b-map (kbd "r")  'rename-current-buffer-file)
(define-key peng-space-b-map (kbd "w")  'read-only-mode)
(define-key peng-space-b-map (kbd "b")  'ibuffer)
(define-key peng-space-b-map (kbd "l")  'lusty-buffer-explorer)
(define-key peng-space-b-map (kbd "s")  'save-buffer)
(define-key peng-space-b-map (kbd "S")  'save-some-buffers)
;;; buffer-filter
(define-key peng-space-b-map (kbd "go") 'peng-ibuffer-filter-org-mode)
(define-key peng-space-b-map (kbd "gc") 'peng-ibuffer-filter-c-mode)
(define-key peng-space-b-map (kbd "ge") 'peng-ibuffer-filter-emacs-lisp-mode)
(define-key peng-space-b-map (kbd "gs") 'peng-ibuffer-filter-sql-mode)
(define-key peng-space-b-map (kbd "gd") 'peng-ibuffer-filter-dired-mode)
(define-key peng-space-b-map (kbd "gp") 'peng-ibuffer-filter-c++-mode)

(define-key peng-evil-normal-map (kbd "b") peng-space-b-map)
;; "bR"  'spacemacs/safe-revert-buffer
;; "b C-k" 'kill-matching-buffers-rudely
;; "bb"  'spacemacs/alternate-buffer ;; switch back and forth between two last buffers
;; "TAB" 'spacemacs/alternate-buffer
;; "be"  'spacemacs/safe-erase-buffer


;;; ----------------------------------------------------------------------
;;; 
;;; e-map for tags
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-e-map (make-sparse-keymap))
(define-key peng-space-e-map (kbd  "l") 'peng-create-tags)
(define-key peng-space-e-map (kbd  "L") 'peng-create-tags)
(define-key peng-space-e-map (kbd  "c") 'peng-clear-tags-table)
(define-key peng-space-e-map (kbd  "A") 'peng-clear-tags-table)
(define-key peng-space-e-map (kbd  "a") 'visit-tags-table)
(define-key peng-space-e-map (kbd  "j") 'peng-etags-select)
(define-key peng-space-e-map (kbd  "u") 'pop-tag-mark)
(define-key peng-evil-normal-map (kbd "e") peng-space-e-map)

;;; ----------------------------------------------------------------------
;;; 
;;; l-map for gtags
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-l-map (make-sparse-keymap))
(define-key peng-space-l-map (kbd  "s") 'peng-select-symbol)
(define-key peng-space-l-map (kbd  "l") 'peng-select-line)
(define-key peng-space-l-map (kbd  "w") 'peng-select-word)

(define-key peng-evil-normal-map (kbd "l") peng-space-l-map)

;;; ----------------------------------------------------------------------
;;; 
;;; f-map
;;; 
;;; ----------------------------------------------------------------------

;; (setq peng-space-f-map (make-sparse-keymap))
;; ;; (define-key peng-space-f-map (kbd  "F") 'helm-find-files)
;; (define-key peng-space-f-map (kbd  "h") nil)
;; ;; (define-key peng-space-f-map (kbd  "f") 'helm-ls-git-ls)
;; (define-key peng-space-f-map (kbd  "f") 'peng-ivy-ls-git)
;; (define-key peng-space-f-map (kbd  "F") 'peng-ido-fasd-find-file)
;; ;; (define-key peng-space-f-map (kbd  "r") 'rgrep)
;; (define-key peng-space-f-map (kbd  "r") 'peng-edit-current-file-as-root)
;; (define-key peng-space-f-map (kbd  "g") 'grep)
;; ;; (define-key peng-space-f-map (kbd  "o") 'swiper)
;; (define-key peng-space-f-map (kbd  "o") 'swiper)
;; (define-key peng-space-f-map (kbd  "O") 'swiper-all)
;; ;; (define-key peng-space-f-map (kbd  "j") 'helm-grep-do-git-grep)
;; (define-key peng-space-f-map (kbd  "j") 'counsel-git-grep)
;; ;; (define-key peng-space-f-map (kbd  "i") 'idomenu)
;; (define-key peng-space-f-map (kbd  "i") 'ivy-imenu-anywhere)
;; (define-key peng-space-f-map (kbd  "S") 'evil-write-all)
;; (define-key peng-space-f-map (kbd  "s") 'lusty-sudo-explorer)
;; ;; (define-key peng-space-f-map (kbd  "l") peng-helm-f-ag-map)
;; (define-key peng-space-f-map (kbd  "e") 'elpy-find-file)
;; (define-key peng-space-f-map (kbd  "a") 'counsel-ag)
;; (define-key peng-space-f-map (kbd  "y") 'peng-swiper-current-symbol)
;; (define-key peng-evil-normal-map (kbd "f") peng-space-f-map)

;; ;;; ----------------------------------------------------------------------
;; ;;; 
;; ;;; w-map
;; ;;; 
;; ;;; ----------------------------------------------------------------------
;; (setq peng-space-w-map (make-sparse-keymap))
;; (define-key peng-space-w-map (kbd "c") 'delete-window)
;; (define-key peng-space-w-map (kbd "d") 'toggle-current-window-dedication)
;; (define-key peng-space-w-map (kbd "H") 'evil-window-move-far-left)
;; (define-key peng-space-w-map (kbd "h") 'evil-window-left)
;; (define-key peng-space-w-map (kbd "J") 'evil-window-move-very-bottom)
;; (define-key peng-space-w-map (kbd "j") 'evil-window-down)
;; (define-key peng-space-w-map (kbd "K") 'evil-window-move-very-top)
;; (define-key peng-space-w-map (kbd "k") 'evil-window-up)
;; (define-key peng-space-w-map (kbd "L") 'evil-window-move-far-right)
;; (define-key peng-space-w-map (kbd "l") 'evil-window-right)
;; (define-key peng-space-w-map (kbd "m") 'toggle-maximize-buffer)
;; (define-key peng-space-w-map (kbd "M") 'toggle-maximize-centered-buffer)
;; (define-key peng-space-w-map (kbd "o") 'other-frame)
;; (define-key peng-space-w-map (kbd "R") 'rotate-windows)
;; (define-key peng-space-w-map (kbd "s") 'split-window-below)
;; (define-key peng-space-w-map (kbd "S") 'split-window-below-and-focus)
;; (define-key peng-space-w-map (kbd "-") 'split-window-below)
;; (define-key peng-space-w-map (kbd "U") 'winner-redo)
;; (define-key peng-space-w-map (kbd "u") 'winner-undo)
;; (define-key peng-space-w-map (kbd "v") 'split-window-right)
;; (define-key peng-space-w-map (kbd "V") 'split-window-right-and-focus)
;; (define-key peng-space-w-map (kbd "w") 'other-window)
;; (define-key peng-space-w-map (kbd "b") 'balance-windows)
;; (define-key peng-space-w-map (kbd "/") 'split-window-right)
;; (define-key peng-evil-normal-map (kbd "w") peng-space-w-map)

;; (define-key peng-space-w-map (kbd "b") 'switch-to-minibuffer-window)
;; (define-key peng-space-w-map (kbd "2") 'layout-double-columns)
;; (define-key peng-space-w-map (kbd "3") 'layout-triple-columns)

;; ;;; ----------------------------------------------------------------------
;; ;;; 
;; ;;; g-map
;; ;;; 
;; ;;; ----------------------------------------------------------------------
;; (setq peng-space-g-map (make-sparse-keymap))
;; ;;; buffer filter
;; (define-key peng-space-g-map (kbd "l") 'ace-jump-line-mode)
;; (define-key peng-space-g-map (kbd "w") 'ace-jump-word-mode)
;; (define-key peng-space-g-map (kbd "g") 'goto-line)
;; (define-key peng-space-g-map (kbd "c") 'goto-char)
;; (define-key peng-space-g-map (kbd "n") 'next-error)
;; (define-key peng-space-g-map (kbd "p") 'previous-error)
;; (define-key peng-evil-normal-map (kbd "g") peng-space-g-map)

;;; ----------------------------------------------------------------------
;;; 
;;; t-map
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-t-map (make-sparse-keymap))
(define-key peng-space-t-map (kbd "t") 'bm-toggle)
(define-key peng-space-t-map (kbd "n") 'bm-next)
(define-key peng-space-t-map (kbd "p") 'bm-previous)
(define-key peng-space-t-map (kbd "s") 'bm-show-all)
(define-key peng-space-t-map (kbd "l") 'bm-show)
(define-key peng-space-t-map (kbd "d") 'bm-remove-all-all-buffers)
(define-key peng-space-t-map (kbd "c") 'bm-remove-all-current-buffer)
(define-key peng-evil-normal-map (kbd "t") peng-space-t-map)

;;; ----------------------------------------------------------------------
;;; 
;;; y-map
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-y-map (make-sparse-keymap))
(define-key peng-space-y-map (kbd  "y")  'peng-yank-or-copy-file-name-to-clipboard)
(define-key peng-space-y-map (kbd  "f")  'peng-yank-file-name)
(define-key peng-space-y-map (kbd  "d")  'peng-yank-directory-name)
(define-key peng-space-y-map (kbd  "c")  'peng-copy-current-directory-or-name-for-git-log)
(define-key peng-space-y-map (kbd  "l")  'peng-copy-current-line-position-to-clipboard)
(define-key peng-space-y-map (kbd  "n")  'peng-copy-current-fun-name)
(define-key peng-space-y-map (kbd  "w")  'peng-yank-word-name)
(define-key peng-space-y-map (kbd  "s")  'peng-yank-symbol-name)
(define-key peng-space-y-map (kbd  "p")  'counsel-yank-pop)

(define-key peng-evil-normal-map (kbd "y") peng-space-y-map)


;;; ----------------------------------------------------------------------
;;; 
;;; f1-map
;;; 
;;; ----------------------------------------------------------------------
(setq peng-f1-map (make-sparse-keymap))
(define-key peng-f1-map (kbd  "<left>") 'evil-window-left)
(define-key peng-f1-map (kbd  "<right>") 'evil-window-right)
(define-key peng-f1-map (kbd  "<down>") 'evil-window-down)
(define-key peng-f1-map (kbd  "<up>") 'evil-window-up)
(define-key peng-f1-map (kbd  "SPC") 'evil-ace-jump-char-mode)
(define-key peng-f1-map (kbd  "<f1>") 'peng-ide)

(define-key peng-f1-map (kbd  "u") 'winner-undo)
(define-key peng-f1-map (kbd  "r") 'winner-undo)

(define-key peng-f1-map (kbd  "1") 'select-window-1)
(define-key peng-f1-map (kbd  "2") 'select-window-2)
(define-key peng-f1-map (kbd  "3") 'select-window-3)
(define-key peng-f1-map (kbd  "4") 'select-window-4)
(define-key peng-f1-map (kbd  "5") 'select-window-5)
(define-key peng-f1-map (kbd  "6") 'select-window-6)
(define-key peng-f1-map (kbd  "7") 'select-window-7)

(define-key peng-f1-map (kbd "h") 'evil-window-left)
(define-key peng-f1-map (kbd "J") 'evil-window-move-very-bottom)
(define-key peng-f1-map (kbd "j") 'evil-window-down)
(define-key peng-f1-map (kbd "K") 'evil-window-move-very-top)
(define-key peng-f1-map (kbd "k") 'evil-window-up)
(define-key peng-f1-map (kbd "L") 'evil-window-move-far-right)
(define-key peng-f1-map (kbd "l") 'evil-window-right)

(peng-global-set-key (kbd "<f1>") peng-f1-map)

(peng-global-set-key (kbd "C-M-<left>") 'evil-window-left)
(peng-global-set-key (kbd "C-M-<right>") 'evil-window-right)
(peng-global-set-key (kbd "C-M-<down>") 'evil-window-down)
(peng-global-set-key (kbd "C-M-<up>") 'evil-window-up)

(peng-global-set-key (kbd "C-M-h") 'evil-window-left)
(peng-global-set-key (kbd "C-M-l") 'evil-window-right)
(peng-global-set-key (kbd "C-M-j") 'evil-window-down)
(peng-global-set-key (kbd "C-M-k") 'evil-window-up)

(peng-global-set-key (kbd "s-h") 'evil-window-left)
(peng-global-set-key (kbd "s-l") 'evil-window-right)
(peng-global-set-key (kbd "s-j") 'evil-window-down)
(peng-global-set-key (kbd "s-k") 'evil-window-up)


;;; ----------------------------------------------------------------------
;;; f12-map
;;; 
;;; ----------------------------------------------------------------------
;; (setq peng-f12-map (make-sparse-keymap))
;; (define-key peng-f12-map (kbd  "<f12>") 'highlight-symbol-at-point)
;; (define-key peng-f12-map (kbd  "<f11>") 'unhighlight-regexp)
;; (define-key peng-f12-map (kbd  "u") 'unhighlight-regexp)
;; (define-key peng-f12-map (kbd  "<f10>") 'peng-unhighlight-all)
;; (define-key peng-f12-map (kbd  "<f9>") 'highlight-regexp)
;; (peng-global-set-key (kbd "<f12>") peng-f12-map)

;;; ----------------------------------------------------------------------
;;; 
;;; c-map
;;; 
;;; ----------------------------------------------------------------------
(setq peng-space-c-map (copy-keymap mode-specific-map))
;;; c-c-map 按`SPC c SPC'后的所有搪键绑定
(setq peng-space-c-c-map (make-sparse-keymap))
(define-key peng-space-c-c-map (kbd "b") 'ace-jump-buffer-with-configuration)
(define-key peng-space-c-map (kbd "SPC") peng-space-c-c-map)

;;; ----------------------------------------------------------------------
;;; c-x-map 按`SPC c x'后的绑定，for org-mode
(setq peng-space-c-x-map (make-sparse-keymap))
(define-key peng-space-c-x-map (kbd "s") 'org-schedule)
(define-key peng-space-c-x-map (kbd "d") 'org-deadline)
(define-key peng-space-c-x-map (kbd "p") 'org-set-property)
(define-key peng-space-c-x-map (kbd "i") 'org-clock-in)
(define-key peng-space-c-x-map (kbd "o") 'org-clock-out)
(define-key peng-space-c-x-map (kbd "w") 'org-cut-special)
(define-key peng-space-c-x-map (kbd "y") 'org-paste-special)
(define-key peng-space-c-x-map (kbd "c") 'org-copy-special)
(define-key peng-space-c-map (kbd "x") peng-space-c-x-map)
;;; ----------------------------------------------------------------------
(define-key peng-space-c-map (kbd "b") 'wg-switch-to-workgroup)
(define-key peng-space-c-map (kbd "c") 'org-capture)
(define-key peng-space-c-map (kbd "m") 'magit-status)

(define-key peng-evil-normal-map (kbd "c") peng-space-c-map)

;;; ----------------------------------------------------------------------
;;; 
;;; others
;;; 
;;; ----------------------------------------------------------------------
(define-key evil-normal-state-map (kbd "M-n") 'scroll-up-command)
(define-key evil-normal-state-map (kbd "\\") 'evil-search-forward)
;; (define-key evil-normal-state-map (kbd "/") 'swiper)
;; (define-key evil-normal-state-map "m" 'point-to-register
;; (define-key evil-normal-state-map "m" 'peng-clone-current-to-new-workgroup)
;; (define-key evil-normal-state-map "'" 'peng-switch-to-workgroup)

(define-key evil-normal-state-map "-" 'split-window-below)
(define-key evil-normal-state-map "|" 'split-window-right)
(define-key evil-normal-state-map "q" 'View-quit)
(define-key evil-normal-state-map (kbd "C-n") 'evil-next-line)
(define-key evil-normal-state-map (kbd "C-r") 'isearch-backward)
(define-key evil-normal-state-map (kbd "C-p") 'evil-previous-line)
(define-key evil-normal-state-map (kbd "M-.") 'find-tag)
(define-key evil-normal-state-map (kbd "C-b") 'backward-char)
(define-key evil-normal-state-map (kbd "C-f") 'forward-char)
(define-key evil-normal-state-map (kbd "K") 'man)

(define-key evil-motion-state-map "-" 'split-window-below)
(define-key evil-motion-state-map "|" 'split-window-right)
;; (define-key evil-motion-state-map "m" 'point-to-register)
;; (define-key evil-motion-state-map "m" 'peng-clone-current-to-new-workgroup)
;; (define-key evil-motion-state-map "'" 'peng-switch-to-workgroup)
(define-key evil-motion-state-map (kbd "C-n") 'evil-next-line)
(define-key evil-motion-state-map (kbd "C-r") 'isearch-backward)
(define-key evil-motion-state-map (kbd "C-p") 'evil-previous-line)

;; (define-key evil-insert-state-map (kbd "C-e") 'mwim-end-of-code-or-line)
;; (define-key evil-normal-state-map (kbd "C-e") 'mwim-end-of-code-or-line)
;; (define-key evil-motion-state-map (kbd "C-e") 'mwim-end-of-code-or-line)
;; (define-key evil-visual-state-map (kbd "C-e") 'mwim-end-of-code-or-line)
;; (define-key evil-emacs-state-map (kbd "C-e") 'mwim-end-of-code-or-line)

;; (define-key evil-normal-state-map (kbd "C-a") 'mwim-beginning-of-code-or-line)
;; (define-key evil-motion-state-map (kbd "C-a") 'mwim-beginning-of-code-or-line)
;; (define-key evil-visual-state-map (kbd "C-a") 'mwim-beginning-of-code-or-line)
;; (define-key evil-insert-state-map (kbd "C-a") 'mwim-beginning-of-code-or-line)
;; (define-key evil-emacs-state-map (kbd "C-a") 'mwim-beginning-of-code-or-line)

(define-key evil-motion-state-map (kbd "M-.") 'find-tag)

 ;;; visual-map
(define-key evil-visual-state-map (kbd "C-b") 'backward-char)
(define-key evil-visual-state-map (kbd "C-f") 'forward-char)

;; evil quit
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)

(define-key minibuffer-local-map [escape] 'keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'keyboard-quit)

(define-key evil-normal-state-map (kbd "DEL") 'delete-other-windows)
(define-key evil-motion-state-map (kbd "DEL") 'delete-other-windows)
(define-key evil-normal-state-map (kbd "<backspace>") 'delete-other-windows)
(define-key evil-motion-state-map (kbd "<backspace>") 'delete-other-windows)
;; (define-key evil-normal-state-map "ei " 'find-file)
;; (define-key evil-motion-state-map "ei " 'find-file)

(define-key evil-normal-state-map "ei " 'find-file)
(define-key evil-motion-state-map "ei " 'find-file)

;; (define-key peng-evil-normal-map (kbd "d") 'xah-open-in-desktop)
;; (define-key peng-evil-normal-map (kbd "o") 'xah-open-in-external-app)
;; (define-key peng-evil-normal-map (kbd "xx") 'smex)
;; (define-key peng-evil-normal-map (kbd "z") 'smex)

(define-key peng-evil-normal-map (kbd "xx") 'counsel-M-x)
(define-key peng-evil-normal-map (kbd "z") 'counsel-M-x)

(define-key peng-evil-normal-map (kbd ",") 'evilnc-comment-operator)
(define-key peng-evil-normal-map (kbd "q") 'kill-buffer-and-window)
(define-key peng-evil-normal-map (kbd "Q") 'kill-this-buffer)
;; (define-key peng-evil-normal-map (kbd "j") 'ido-bookmark-jump)
(define-key peng-evil-normal-map (kbd "j") 'bookmark-jump)
;; (define-key peng-evil-normal-map (kbd "j") 'helm-bookmarks)
(define-key peng-evil-normal-map (kbd "SPC") 'ace-jump-char-mode)
;; (define-key peng-evil-normal-map (kbd "e") 'shell-switcher-switch-buffer)
(define-key peng-evil-normal-map (kbd "B") 'bookmark-bmenu-list)
;; (define-key peng-evil-normal-map (kbd "r") 'ido-recentf-find-file)
(define-key peng-evil-normal-map (kbd "r") 'counsel-recentf)
(define-key peng-evil-normal-map (kbd "TAB") 'my-projectile-switch-to-buffer)
(define-key peng-evil-normal-map (kbd "<backtab>") 'switch-to-buffer)
(define-key peng-evil-normal-map (kbd "1") 'delete-other-windows)
(define-key peng-evil-normal-map (kbd "0") 'delete-window)
(define-key peng-evil-normal-map (kbd "2") 'split-window-below)
(define-key peng-evil-normal-map (kbd "3") 'split-window-right)
(define-key peng-evil-normal-map (kbd "DEL") 'delete-other-windows)
(define-key peng-evil-normal-map (kbd "xg") 'peng-goto-scratch)
(define-key peng-evil-normal-map (kbd "`") 'iterm-goto-filedir-or-home)
(define-key peng-evil-normal-map (kbd "?") 'iterm-focus)


;;; ----------------------------------------------------------------------
;;; 
;;; 把SPC和`,'绑定到我自己的`peng-evil-normal-map'上
;;; 
;;; ----------------------------------------------------------------------
;; (define-key evil-normal-state-map (kbd "SPC") peng-evil-normal-map)
;; (define-key evil-normal-state-map (kbd ",") peng-evil-normal-map)
;; (define-key evil-motion-state-map (kbd "SPC") peng-evil-normal-map)
;; (define-key evil-motion-state-map (kbd ",") peng-evil-normal-map)

;;; ----------------------------------------------------------------------
;;; 
;;; `,'在insert的时候还是比较奇怪，所以关闭了它
;;; 
;;; ----------------------------------------------------------------------
;; ;;; insert map

;; (define-prefix-command 'peng-evil-insert-map)
(setq peng-evil-insert-map (make-sparse-keymap))
;; (setq peng-evil-insert-map (copy-keymap peng-evil-normal-map))
;; ;;; insert中的需要可以输入`,'
;; (define-key peng-evil-insert-map (kbd ",") (lambda ()
;; 					     (interactive)
;; 					     (insert ",")))

;; ;; 使用`,.'来返回到normal
;; (define-key peng-evil-insert-map (kbd ".") #'evil-normal-state)
;; (define-key peng-evil-insert-map (kbd "s") #'peng-save-buffer-inter-evil-normal)

;; ;;; `,'使用相同的map
;; (define-key evil-insert-state-map (kbd ",") peng-evil-insert-map)

;; ;; 在minibuffer中这样也可以退出
;; (define-key minibuffer-local-map (kbd ",g") 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-map (kbd ",,") 'minibuffer-keyboard-quit)


;;;-------------------------------------------------------------------
;;; 
;; f8-map, make emacs like other apps
;;; 
;;;-------------------------------------------------------------------
;; (setq peng-f8-map (make-sparse-keymap))
;; (define-key peng-f8-map (kbd "c") 'xah-copy-line-or-region)
;; (define-key peng-f8-map (kbd "x") 'xah-cut-line-or-region)
;; (define-key peng-f8-map (kbd "v") 'yank)
;; (peng-global-set-key (kbd "<f8>") 'jump-to-register)
;; (peng-global-set-key (kbd "<f8>") 'peng-window-configuration-to-register)
(peng-global-set-key (kbd "<f7>") 'peng-auto-revert)


;;; f9-map
;; (setq peng-f9-map (make-sparse-keymap))
;; (define-key peng-f9-map (kbd "<f9>") 'view-stardict-in-buffer) ;test
;; (peng-global-set-key (kbd "<f9>") 'view-stardict-in-buffer)

;; ;;;-------------------------------------------------------------------
;; ;;; 
;; ;;; f5-map use for compiling and eye protection
;; ;;; 
;; ;;;-------------------------------------------------------------------
;; (setq peng-f5-map (make-sparse-keymap))

;; ;;; switch back to main
;; (define-key peng-f5-map (kbd "<f5>") '(lambda ()
;;                                         (interactive)
;;                                         (unwind-protect
;;                                             (peng-switch-to-main-workgroup)
;;                                           (find-file (concat (getenv "HOME")
;;                                                              "/org/home.org")))))

;; ;;; switch back and kill all file relative buffer
;; (define-key peng-f5-map (kbd "S-<f5>") '(lambda ()
;;                                         (interactive)
;;                                         (unwind-protect
;;                                             (peng-switch-to-main-workgroup)
;;                                           (progn
;;                                             (peng-kill-all-file-relative-buffers)
;;                                             (find-file (concat (getenv "HOME")
;;                                                              "/org/home.org"))))))

;; (define-key peng-f5-map (kbd "h") '(lambda ()
;;                                         (interactive)
;;                                          (find-file (concat (getenv "HOME")
;;                                                             "/org/home.org"))))
;; (define-key peng-f5-map (kbd "w") '(lambda ()
;;                                         (interactive)
;;                                          (find-file (concat (getenv "HOME")
;;                                                             "/Downloads"))))
;; (define-key peng-f5-map (kbd "d") '(lambda ()
;;                                         (interactive)
;;                                          (find-file (concat (getenv "HOME")
;;                                                             "/Documents"))))
;; (define-key peng-f5-map (kbd "o") '(lambda ()
;;                                         (interactive)
;;                                          (find-file "/Users/pengpengxp/work/openstack/openstack_config.org")))

;; (define-key peng-f5-map (kbd "t") '(lambda ()
;;                                         (interactive)
;;                                          (find-file "/tmp")))

;; (define-key peng-f5-map (kbd "a") 'peng-asp-engine-project)
;; (define-key peng-f5-map (kbd "n") 'peng-nginx-project)
;; (peng-global-set-key (kbd "<f5>") peng-f5-map)

;;;-------------------------------------------------------------------
;;; 
;;; f6-map
;;; 
;;;-------------------------------------------------------------------
;; (setq peng-f6-map (make-sparse-keymap))

;; ;;; 在当前文件夹快速打开文件管理器
;; (define-key peng-f6-map (kbd "e") '(lambda ()
;; 				       (interactive)
;; 				       (peng-async-shell-command (concat "nautilus " 
;; 									 default-directory
;; 									 "&"))))
;; (define-key peng-f6-map (kbd "n") '(lambda ()
;; 				       (interactive)
;; 				       (peng-async-shell-command (concat "dolphin " 
;; 									 default-directory
;; 									 "&"))))
;; ;;; 在当前文件夹快速打开终端
;; (define-key peng-f6-map (kbd "t") '(lambda ()
;; 				       (interactive)
;; 				       (peng-async-shell-command (concat "gnome-terminal && ls "
;; 									 " "
;; 									 default-directory
;; 									 " &"))))
(peng-global-set-key (kbd "<f6>") 'recompile)

;;;-------------------------------------------------------------------
;;; 
;; global-key settings
;;; 
;;;-------------------------------------------------------------------
(peng-global-set-key (kbd "<delete>") 'view-stardict-in-buffer)
(peng-global-set-key (kbd "C-c m") #'(lambda ()
                                       (interactive)
                                      (progn
                                        (magit-status)
                                        (delete-other-windows))))

;;; MISC
(peng-global-set-key (kbd "C-M-0") 'delete-window)
(peng-global-set-key (kbd "C-M-1") 'delete-other-windows)
(peng-global-set-key (kbd "C-M-2") 'split-window-below)
(peng-global-set-key (kbd "C-M-3") 'split-window-right)
(peng-global-set-key (kbd "<C-tab>") '(lambda ()
					(interactive)
					(switch-to-buffer (other-buffer))))

;; (peng-global-set-key (kbd "<C-tab>") 'other-window)
(peng-global-set-key (kbd "<M-tab>") 'switch-to-buffer)
(peng-global-set-key (kbd "s-v") 'view-mode)
(peng-global-set-key (kbd "\C-cn") 'autopair-mode)
(peng-global-set-key (kbd "C-x C-b") 'wg-switch-to-workgroup)
;; (peng-global-set-key (kbd "<C-up>") 'enlarge-window)
;; (peng-global-set-key (kbd "<C-down>") 'shrink-window)
(peng-global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(peng-global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

;;; M-c-x-map for ido
(setq peng-M-c-x-map (make-sparse-keymap))
(define-key peng-M-c-x-map (kbd "i") 'peng-ido-insert-ls-and-grep)
(define-key peng-M-c-x-map (kbd "j") 'peng-ido-jump)
(peng-global-set-key (kbd "M-c M-x") peng-M-c-x-map)

;;; global map for cscope

(setq peng-cscope-map (make-sparse-keymap))
(define-key peng-cscope-map (kbd "A") 'cscope-unset-initial-directory)
(define-key peng-cscope-map (kbd "B") 'cscope-display-buffer-toggle)
(define-key peng-cscope-map (kbd "C") 'cscope-find-called-functions)
(define-key peng-cscope-map (kbd "D") 'cscope-dired-directory)
(define-key peng-cscope-map (kbd "E") 'cscope-edit-list-of-files-to-index)
(define-key peng-cscope-map (kbd "G") 'cscope-find-global-definition-no-prompting)
(define-key peng-cscope-map (kbd "I") 'cscope-index-files)
(define-key peng-cscope-map (kbd "L") 'cscope-create-list-of-files-to-index)
(define-key peng-cscope-map (kbd "N") 'cscope-next-file)
(define-key peng-cscope-map (kbd "P") 'cscope-prev-file)
(define-key peng-cscope-map (kbd "S") 'cscope-tell-user-about-directory)
(define-key peng-cscope-map (kbd "W") 'cscope-tell-user-about-directory)
(define-key peng-cscope-map (kbd "a") 'cscope-set-initial-directory)
(define-key peng-cscope-map (kbd "b") 'cscope-display-buffer)
(define-key peng-cscope-map (kbd "c") 'cscope-find-functions-calling-this-function)
(define-key peng-cscope-map (kbd "d") 'cscope-find-global-definition)
(define-key peng-cscope-map (kbd "e") 'cscope-find-egrep-pattern)
(define-key peng-cscope-map (kbd "f") 'cscope-find-this-file)
(define-key peng-cscope-map (kbd "g") 'cscope-find-global-definition)
(define-key peng-cscope-map (kbd "i") 'cscope-find-files-including-file)
(define-key peng-cscope-map (kbd "n") 'cscope-next-symbol)
(define-key peng-cscope-map (kbd "p") 'cscope-prev-symbol)
(define-key peng-cscope-map (kbd "s") 'cscope-find-this-symbol)
(define-key peng-cscope-map (kbd "t") 'cscope-find-this-text-string)
(define-key peng-cscope-map (kbd "u") 'cscope-pop-mark)

(define-key evil-normal-state-map (kbd "SPC v") peng-cscope-map)

;;; ----------------------------------------------------------------------
;;; 
;;; M-e map for workgroups
;;; 
;;; ---------------------------------------------------------------------
(setq peng-M-e-map (make-sparse-keymap))

(define-key peng-M-e-map (kbd "M-e") 'peng-switch-to-main-workgroup)
(define-key peng-M-e-map (kbd "e") 'peng-switch-to-main-workgroup)

(define-key peng-M-e-map (kbd "M-l") 'peng-switch-to-workgroup)
(define-key peng-M-e-map (kbd "l") 'peng-switch-to-workgroup)

(define-key peng-M-e-map (kbd "M-m") 'peng-clone-current-to-new-workgroup)
(define-key peng-M-e-map (kbd "m") 'peng-clone-current-to-new-workgroup)

(define-key peng-M-e-map (kbd "M-c") 'peng-clone-current-to-new-workgroup)
(define-key peng-M-e-map (kbd "c") 'peng-clone-current-to-new-workgroup)

(define-key peng-M-e-map (kbd "M-j") 'wg-switch-to-previous-workgroup)
(define-key peng-M-e-map (kbd "j") 'wg-switch-to-previous-workgroup)

(define-key peng-M-e-map (kbd "M-p") 'wg-switch-to-previous-workgroup)
(define-key peng-M-e-map (kbd "p") 'wg-switch-to-previous-workgroup)

(define-key peng-M-e-map (kbd "M-k") 'peng-wg-delete-workgroup)
(define-key peng-M-e-map (kbd "k") 'peng-wg-delete-workgroup)

;; (define-key evil-normal-state-map (kbd "M-e") peng-M-e-map)
;; (define-key evil-emacs-state-map (kbd "M-e") peng-M-e-map)
;; (define-key evil-insert-state-map (kbd "M-e") peng-M-e-map)
;; (define-key evil-motion-state-map (kbd "M-e") peng-M-e-map)
;; (define-key evil-visual-state-map (kbd "M-e") peng-M-e-map)

;;;-------------------------------------------------------------------
;;; 
;;; global keys
;;; 
;;;-------------------------------------------------------------------
(peng-global-set-key (kbd "M-s") 'ace-window)
;; (peng-global-set-key (kbd "C-c <C-tab>") 'helm-multi-files)
(peng-global-set-key (kbd "C-c <C-tab>") 'ivy-switch-buffer)
(peng-global-set-key (kbd "<kp-decimal>") 'peng-etags-select)
(peng-global-set-key (kbd "<kp-0>") 'pop-tag-mark)

;;; for eshell
(peng-global-set-key (kbd "C-M-'") 'shell-switcher-new-shell)
(peng-global-set-key (kbd "C-'") 'shell-switcher-switch-buffer)

(provide 'init-keys)
