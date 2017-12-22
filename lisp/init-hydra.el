(defhydra my-hydra-zoom ()
  "zoom"
  ("+" cnfonts-increase-fontsize "scale increase")
  ("-" cnfonts-decrease-fontsize "scale decrease")
  ("c" nil "cancle")
  ;; ("C-+" 'text-scale-increase)
  ;; ("C--" 'text-scale-decrease)
  )

(defhydra hydra-narrow (:color pink
                               :hint nil
                               :columns 3
                               :exit t)
  "Narrow"
  ("s" org-narrow-to-subtree "org-narrow-to-subtree")
  ("n" narrow-to-region "narrow-to-region")
  ("w" widen "widen")
  ("d" narrow-to-defun "narrow-to-defun")
  ("e" org-narrow-to-element "org-narrow-to-element")
  ("b" org-narrow-to-block "org-narrow-to-block")
  ("p" narrow-to-page "narrow-to-page")
  ("c" nil "cancel")
  )

(defhydra hydra-bookmarks ()
  "zoom"
  ("f" peng-bookmarks-firefox "firefox")
  ("c" peng-bookmarks-chrome "chrome")
  ("w" peng-bookmarks-w3m "w3m")
  ("<return>" peng-bookmarks-w3m "default w3m")
  ("q" nil "cancle")
  )

(defhydra hydra-w3m (:color pink
                               :hint nil
                               :columns 3
                               :exit t)
  "w3m"
    ("u" w3m-bookmark-undo "w3m-bookmark-undo")
    ("v" (w3m-goto-url-new-session w3m-bookmark-file) "w3m-bookmark-view")
    ("h" helm-w3m-bookmarks "helm-w3m-bookmark")

    ("c" peng-grab-firefox-tab-to-w3m-todo-file "grab-firefox-link")

    ("a" w3m-bookmark-add-current-url "w3m-bookmark-add-current-url")
    ("t" w3m-bookmark-add-this-url "w3m-bookmark-add-this-url")

    ("e" w3m-bookmark-edit "w3m-bookmark-edit")
    ("g" w3m-goto-url-new-session "goto url")

    ("C" peng-w3m-view-current-url-new-session "peng-w3m-goto-chrome-current-tab-url")
    ("F" peng-firefox-view-current-url "firefox")
    ("G" peng-chrome-view-current-url "chrome")

    ("b" hydra-bookmarks/body "open bookmarks")
    ("SPC" w3m "w3m")
    ("<return>" #'(lambda (arg)
                    (interactive "P")
                    (if arg
                        (hydra-bookmarks/body)
                      (peng-bookmarks-w3m))) "open bookmarks default")
  )

(defhydra hydra-global (:color pink
                               :hint nil
                               :columns 3
                               :exit t)
  "Gnu global"
  ("t" counsel-gtags-find-definition "def")
  ("d" counsel-gtags-find-definition "def")
  ("RET" counsel-gtags-dwim "find ref or def")
  ("<return>" counsel-gtags-dwim "find ref or def")
  ("g" counsel-gtags-dwim "find ref or def")
  ("r" counsel-gtags-find-reference "find ref or def")
  ("s" counsel-gtags-find-symbol "symbole")
  ("<" counsel-gtags-go-backward "back" :exit nil)
  (">" counsel-gtags-go-forward "forward" :exit nil)
  ("f" ggtags-find-file "forward" :exit nil)
  ("c" nil "calcel")
  )

(defhydra hydra-cc-mode (:color pink
                                :hint nil
                                :columns 3
                                :exit t)
  "CC Mode"
  ("c" peng-compile-current-c-or-cpp-file "compile-current-c-file")
  ("g" dumb-jump-go "dumb-jump-go")
  )

(defhydra hydra-cscope (:color pink
                               :hint nil
                               :columns 2
                               :exit t)
  "Cscope"
  ("A" cscope-unset-initial-directory "cscope-unset-initial-directory")
  ("B" cscope-display-buffer-toggle "cscope-display-buffer-toggle")
  ("C" cscope-find-called-functions "cscope-find-called-functions")
  ("D" cscope-dired-directory "cscope-dired-directory")
  ("E" cscope-edit-list-of-files-to-index "cscope-edit-list-of-files-to-index")
  ("G" cscope-find-global-definition-no-prompting "cscope-find-global-definition-no-prompting")
  ("I" cscope-index-files "cscope-index-files")
  ("L" cscope-create-list-of-files-to-index "cscope-create-list-of-files-to-index")
  ("N" cscope-next-file "cscope-next-file")
  ("P" cscope-prev-file "cscope-prev-file")
  ("S" cscope-tell-user-about-directory "cscope-tell-user-about-directory")
  ("W" cscope-tell-user-about-directory "cscope-tell-user-about-directory")
  ("a" cscope-set-initial-directory "cscope-set-initial-directory")
  ("b" cscope-display-buffer "cscope-display-buffer")
  ("r" (lambda ()
         (interactive)
         (progn
           (cscope-display-buffer)
           (delete-other-windows))) "cscope-display-buffer-only")
  ("c" peng-cscope-find-functions-calling-this-function "cscope-find-functions-calling-this-function")
  ("d" cscope-find-global-definition "cscope-find-global-definition")
  ("e" cscope-find-egrep-pattern "cscope-find-egrep-pattern")
  ("f" cscope-find-this-file "cscope-find-this-file")
  ("F" peng-cscope-find-curren-files-including-file "peng-cscope-find-curren-files-including-file")
  ("g" cscope-find-global-definition "cscope-find-global-definition")
  ("i" cscope-find-files-including-file "cscope-find-files-including-file")
  ("n" cscope-next-symbol "cscope-next-symbol" :exit nil)
  ("p" cscope-prev-symbol "cscope-prev-symbol" :exit nil)
  ("s" cscope-find-this-symbol "cscope-find-this-symbol")
  ("t" cscope-find-this-text-string "cscope-find-this-text-string")
  ("u" cscope-pop-mark "cscope-pop-mark")
  ("h" peng-walk-through-cscope-ring "history")
  ("<backspace>" nil "calcel")
  ("DEL" nil "calcel")
  )

(defhydra hydra-etags (:color pink
                              :hint nil
                              :columns 3
                              :exit t)
  "Gnu global"
  ("l" peng-create-tags "peng-create-tags")
  ("L" peng-create-tags "peng-create-tags")
  ("c" peng-clear-tags-table "peng-clear-tags-table")
  ("A" peng-clear-tags-table "peng-clear-tags-table")
  ("a" visit-tags-table "visit-tags-table")
  ("j" peng-etags-select "peng-etags-select")
  ("u" pop-tag-mark "pop-tag-mark" :color blue)
  )

(defhydra hydra-evil-normal-state-f-menu (:color pink
                                                 :hint nil
                                                 :columns 3
                                                 :exit t)
  "F-menu"
  ("f" find-file "find-file")
  ("l" peng-ivy-ls-git "git-find-file")
  ;; ("R" peng-edit-current-file-as-root "peng-edit-current-file-as-root")
  ;; ("r" counsel-recentf "counsel-recentf")

  ("R" peng-custumize-rg-dwim "rg-dwim")
  ("r" peng-custumize-rg "peng-rg")

  ("g" counsel-git-grep "counsel-git-grep")
  ("G" grep "grep")
  ("o" counsel-grep-or-swiper "grep-or-swiper")
  ;; ("O" swiper-all "swiper-all")
  ("O" peng-swiper-current-symbol "peng-swiper-current-symbol")

  ("A" (counsel-ag (thing-at-point 'symbol)) "counsel-ag-at-point")
  ("a" counsel-ag "counsel-ag")

  ("j" bookmark-jump "bookmark-jump")
  ;; ("i" ivy-imenu-anywhere "ivy-imenu-anywhere")
  ("i" helm-semantic-or-imenu "imenu")
  ("S" evil-write-all "evil-write-all")
  ("s" ido-sudo-find-file "sudo-explorer")
  ("q" my-hydra-zoom/body "my-hydra-zoom/body")
  ("c" nil "cancle" :color blue)
  ("<tab>" ivy-switch-buffer "ivy-switch-buffer" :color blue)
  ("SPC" hydra-w-menu/body)
  ("M-f" hydra-evil-normal-state-f-menu/body)
  ("M-w" hydra-w-menu/body)
  ;; ("." hydra-repeat "repeat")
  ;; ("h" hydra-helm/body "helm")
  )

(defhydra hydra-x-menu (:color pink
                               :hint nil
                               :columns 4
                               :exit t)
  "X-menu"
  ("f" find-file "find-file" :color blue)
  ("b" ivy-switch-buffer "switch-buffer" :color blue)
  ("B" ibuffer "ibuffer" :color blue)
  ("g" peng-goto-scratch "goto scrath" :color blue)
  ("p" pwd "pwd" :exit t)
  ("s" shell-command "shell-command")
  ("n" hydra-narrow/body "narrow")
  ("c" nil "cancel")
  )

(defhydra hydra-evil-normal-state-g-menu (:color pink
                                                 :hint nil
                                                 :exit t
                                                 :columns 3)
  "Goto Mode"
  ("l" goto-line "goto-line")
  ("o" goto-line "goto-line")
  ("w" ace-jump-word-mode "ace-jump-word-mode")
  ("g" ace-jump-char-mode "ace-jump-char-mode")
  ("n" next-error "next-error")
  ("p" previous-error "previous-error")
  ("j" bookmark-jump "bookmark-jump")
  ("c" nil "cancle" :color blue)
  )

;;; for windowns control
(defhydra hydra-w-menu (:color pink
                               :hint nil
                               :columns 3
                               :exit t)
  "Windows Control"
  ("d" delete-other-windows "delete other")
  ("h" evil-window-left)
  ("j" evil-window-down)
  ("k" evil-window-up)
  ("l" evil-window-right)
  ("m" peng-window-configuration-to-register "mark windows configration")
  ("'" jump-to-register "jump-to-register")
  ("M" toggle-maximize-centered-buffer)
  ("o" other-frame)
  ("R" rotate-windows "rotate-windows")
  ("s" split-window-below)
  ("S" split-window-below-and-focus)
  ("-" split-window-below)
  ("U" winner-redo)
  ("u" winner-undo)
  ("v" split-window-right)
  ("V" split-window-right-and-focus)
  ("w" other-window)
  ("b" balance-windows)
  ("f" find-file)
  ("q" xah-close-current-buffer "hydra-w-menu")
  ("Q" kill-buffer-and-window)
  ("/" split-window-right)
  ("-" split-window-below)
  ("|" split-window-right "right")
  ("c" nil "hydra-cancle" :color blue)
  ("<tab>" ivy-switch-buffer "ivy-switch-buffer" :color blue)
  ("RET" nil "hydra-cancle")
  ("<return>" nil "hydra-cancle")
  ("<backspace>" nil "hydra-cancle")
  )

;;; ;;;;;;;;;;;;;;;; Hydra Occur begin ;;;;;;;;;;;;;;;;
(defun occur-dwim ()
  "Call `occur' with a sane default, chosen as the thing under point or selected region"
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))

;; Keeps focus on *Occur* window, even when when target is visited via RETURN key.
;; See hydra-occur-dwim for more options.
;; (defadvice occur-mode-goto-occurrence (after occur-mode-goto-occurrence-advice activate)
;;   (other-window 1)
;;   (hydra-occur-dwim/body))

;; Focus on *Occur* window right away.
(add-hook 'occur-hook (lambda () (other-window 1)))

(defun reattach-occur ()
  (if (get-buffer "*Occur*")
      (switch-to-buffer-other-window "*Occur*")
    (hydra-occur-dwim/body) ))

;; Used in conjunction with occur-mode-goto-occurrence-advice this helps keep
;; focus on the *Occur* window and hides upon request in case needed later.
(defhydra hydra-occur-dwim (:exit t)
  "Occur mode"
  ("o" occur-dwim "Start occur-dwim" :color red)
  ;; ("j" occur-next "Next" :color red)
  ;; ("k" occur-prev "Prev":color red)
  ;; ("h" delete-window "Hide" :color blue)
  ("r" (reattach-occur) "Re-attach" :color red)
  )
;;; ;;;;;;;;;;;;;;;; Hydra Occur end ;;;;;;;;;;;;;;;;

;;; ;;;;;;;;;;;;;;;; Hydra Ag Begin ;;;;;;;;;;;;;;;;

(defun reattach-ag ()
  (if (get-buffer "*ag search*")
      (switch-to-buffer-other-window "*ag search*")
    ;; (hydra-ag-dwim/body)
    ))

(defun peng-ag-current-directory ()
  (interactive)
  (let ((string (read-from-minibuffer "Ag in current directory: ")))
    (ag string default-directory)))
(defadvice peng-ag-current-directory (after peng-after-ag-current-buffer activate)
  (kill-buffer "*compilation*")
  (switch-to-buffer-other-window "*ag search*")
  ;; 使用`ag-mode-hook'设置不了，只能在这里设置`ag-mode'的按键绑定了
  (define-key evil-normal-state-local-map (kbd "k") 'evil-previous-line)
  (define-key evil-normal-state-local-map (kbd "j") 'evil-next-line)
  (define-key evil-normal-state-local-map (kbd "SPC") peng-spc-main-map)
  (define-key evil-normal-state-local-map (kbd "h") 'evil-backward-char)
  (define-key evil-normal-state-local-map (kbd "l") 'evil-forward-char)
  )

(defhydra hydra-ag-dwim (:exit t
                               :columns 4)
  "Ag mode"
  ("g" peng-ag-current-directory "Start Ag in current directory")
  ("o" counsel-ag "counsel-ag")
  ("a" ag "Start Ag")
  ("r" (reattach-ag) "Re-attach" :color red)
  ;; ("j" next-line "Next" :color red)
  ;; ("k" previous-line "Next" :color red)
  )

;;; ;;;;;;;;;;;;;;;; Peng Yank Begin ;;;;;;;;;;;;;;;;
(defhydra hydra-peng-yank (:exit t
                                 :columns 3)
  "Yank Mode"
  ("c" peng-copy-current-directory-or-name-for-git-log)
  ("d" (xah-copy-file-path t) "directory")
  ("F" xah-copy-file-path "abusolute file")
  ("f" peng-yank-file-name "file name")
  ("b" peng-yank-buffer-name "buffer name")
  ("g" peng-copy-current-line-position-to-clipboard "file and line num")
  ("l" xah-copy-line-or-region "line or region")
  ("L" xah-cut-line-or-region "line or region")
  ("n" peng-copy-current-fun-name "function")
  ("p" counsel-yank-pop "yank pop")
  ("s" peng-yank-symbol-name "symbol")
  ("w" peng-yank-word-name "word")
  ("y" peng-yank-or-copy-file-name-to-clipboard "absolut file name")
  ("a" xah-copy-all-or-region "xah-copy-all-or-region")
  ("A" xah-cut-all-or-region "xah-cut-all-or-region")
  ("k" kill-region "kill-region")
  ("u" (lambda ()
         (interactive)
         (let ((thing (xah-get-thing-at-point 'url)))
           (when thing
             (progn
               (kill-new thing)
               (message "copy %s to clipboard" thing))))) "copy-url")
  )
;;; ;;;;;;;;;;;;;;;; Peng Yank End ;;;;;;;;;;;;;;;;

(defhydra hydra-peng-d-menu (:exit t
                                   :columns 3)
  "Misc"
  ("C" peng-get-chrome-current-tab-url "peng-get-chrome-current-tab-url")
  ("G" peng-generate-org-buffer "peng-generate-org-buffer")
  ("T" peng-generate-temp-buffer "peng-generate-temp-buffer")
  ("b" peng-write-blog "peng-write-blog")
  ("c" peng-get-chrome-current-tab-url-to-org-capture "peng-get-chrome-current-tab-url-to-org-capture")
  ("e" eshell-command "eshell-command")
  ("f" toggle-fullscreen "toggle-fullscreen")
  ("g" peng-switch-to-org-buffer "peng-switch-to-org-buffer")
  ("i" iterm-goto-filedir-or-home "iterm-goto-filedir-or-home")
  ("j" calc "calc")
  ("k" peng-kill-all-file-relative-buffers "peng-kill-all-file-relative-buffers")
  ("l" linum-mode "linum-mode")
  ("m" peng-mark-real-line "peng-mark-real-line")
  ("o" hydra-open/body "hydra-open/body")
  ("t" peng-switch-to-temp-buffer "peng-switch-to-temp-buffer")
  ;; ("w" peng-w3m-goto-chrome-current-tab-url "peng-w3m-goto-chrome-current-tab-url")
  ("w" hydra-w3m/body "hydra-w3m/body")
  ("r" hydra-cdyq/body "hydra-river/body")
  ("q" my-hydra-zoom/body "my-hydra-zoom")
  ("s" view-stardict-in-buffer "view-stardict-in-buffer")
  )

(defhydra hydra-peng-p-menu (:exit t
                                   :columns 3)
  "Misc"
  ("p" ivy-push-view "ivy-push-view")
  ("P" ivy-pop-view "ivy-pop-view")
  )



(defhydra hydra-cdyq (:exit t :columns 3)
  "Cdyq Mode"
  ("r" (async-shell-command "/home/pengpengxp/bin/pctags default") "recreate cdyq-tags")
  ("R" (async-shell-command (concat "/home/pengpengxp/bin/pctags "
                                    (shell-command-to-string
                                     "git rev-parse --show-toplevel"))) "recreate current tags")
  )

(defhydra hydra-open (:exit t :columns 4)
  "Open Mode"
  ("o" xah-open-in-external-app "xah-open-in-external-app")
  ("d" xah-open-in-desktop "xah-open-in-desktop")
  ("j" calc "calc")
  ("J" peng-mac-open-gui-calc "peng-mac-open-gui-calc")
  ("c" calendar "calendar")
  ("C" peng-mac-open-gui-calendar "peng-mac-open-gui-calendar")
  ("s" peng-open-in-desktop-and-select "peng-open-in-desktop-and-select")
  ("S" peng-shutdown "SHUTDOWN!")
  ("w" peng-open-electronic-wechat "wechat")
  )
(defhydra hydra-help (:exit t :columns 4)
  "Help Mode"
  ("v" describe-variable "variable")
  ("f" describe-function "function")
  ("k" describe-key "key bindings")
  ("i" info "info")
  ("h" counsel-descbinds "counsel-descript keys bindings")
  )

(defhydra hydra-evil (:exit t :columns 4)
  "Evil Mode"
  ("f" evil-find-char "evil-find-char")
  ("f" evil-find-char-to "evil-find-char-to")
  ("y" evil-yank "evil-yank")
  ("d" evil-yank "evil-delete")
  (";" evil-repeat-find-char "evil-repeat-find-char")
  ("=" evil-indent "indent")
  )

(defhydra hydra-case-control (
                              :columns 4)
  "Case control"
  ("u" upcase-word "upcase-word")
  ("l" downcase-word "downcase-word")
  ("c" capitalize-word "capitalize-word")
  ("C-e" mwim-end-of-code-or-line "end-of-line")
  ("C-a" mwim-beginning-of-code-or-line "mwim-beginning-of-code-or-line")
  ("C-f" forward-char "forward-char")
  ("C-b" backward-char "backward-char")
  ("RET" nil "cancel")
  ("<return>" nil "cancel")
  )

(defhydra hydra-e-menu (:exit t
                              :columns 4)
  "Edit control"
  ("c" hydra-case-control/body "hydra-case-control/body")
  ("y" peng-replace-current-symbol-with-kill-ring "replace current symbol of kill ring")
  ("v" hydra-cscope/body "hydra-cscope/body")
  ("t" hydra-etags/body "hydra-etags/body")
  )

(defhydra hydra-k-map (:hint nil
                             :exit t
                             :columns 4)
  "Symbol Overlay"

  ("SPC" symbol-overlay-rename "rename")
  ("a" symbol-overlay-remove-all "remove all")
  ("d" symbol-overlay-jump-to-definition "jump to def")
  ("f" symbol-overlay-put "set")
  ("j" symbol-overlay-put "set not exit" :exit nil)
  ("n" symbol-overlay-jump-next "next" :exit nil)
  ("p" symbol-overlay-jump-prev "previours" :exit nil)
  ("u" symbol-overlay-remove "remove")
  ("r" peng-reload-hydra-keymap "reload key")
  ("c" nil "cancel")
  ("RET" nil "cancel")
  ("<return>" nil "cancel")
  )

(defhydra hydra-org (:hint nil
                           :exit t
                           :columns 4)
  "For Org Mode"

  ("a" org-agenda "org-agenda")
  ("c" org-capture "org-capture")
  ("l" org-store-link "org-store-link")
  ("h" org-hide-block-all "org-hide-block-all")
  ("s" org-show-block-all "org-show-block-all")
  )

(defhydra hydra-insert (:hint nil
                              :exit t
                              :columns 3)
  "Insert"
  ("f" my-insert-file-name "my-insert-file-name")
  ("b" xah-insert-black-lenticular-bracket【】 "【】")
  ("c" xah-insert-ascii-single-quote "single-quote ''")
  ("\'" xah-insert-ascii-single-quote "single-quote ''")
  ("d" xah-insert-double-curly-quote“” "curly-quot“”")
  ("e" xah-insert-emacs-quote "emcs-quote `'")
  ("g" xah-insert-ascii-double-quote "\"\"")
  ("\"" xah-insert-ascii-double-quote "\"\"")
  ("h" xah-insert-brace "brace {}") ; {}
  ;; ("i" xah-insert-curly-single-quote‘’"curly-single-quote ‘’")
  ("i" ido-insert-file "insert-file")
  ("l" xah-insert-form-feed)
  ("m" xah-insert-corner-bracket「」 "「」")
  ("n" xah-insert-square-bracket) ; []
  ("p" xah-insert-single-angle-quote‹›)
  ("r" xah-insert-tortoise-shell-bracket〔〕 )
  ("s" xah-insert-string-assignment "=\"\"")
  ("t" xah-insert-paren "paren ()")
  ("u" xah-insert-date "date")
  ("w" xah-insert-angle-bracket〈〉 "〈〉")
  ("W" xah-insert-double-angle-bracket《》 "《》")
  ("y" xah-insert-double-angle-quote«» "«»")
  ("=" xah-insert-equals "=")
  )

(defhydra hydra-select (:hint nil
                              :exit t
                              :columns 3)
  "Select"
  ("l" xah-select-current-line "current line")
  ("L" xah-select-line "line")
  ("b" xah-select-current-block "current block")
  ("B" xah-select-block "block")
  ("e" xah-extend-selection "xah-extend-selection")
  ("\"" xah-select-text-in-quote "xah-select-text-in-quote")
  ("s" er/mark-symbol "symbol")
  ("w" er/mark-word "word")
  ("d" mark-defun)
  )

(defhydra hydra-ibuffer-filters (:hint nil
                                       :exit t
                                       :columns 4)
  "Buffers"
  ("q" nil "cancle")
  ("o" peng-ibuffer-filter-org-mode "org")
  ("c" peng-ibuffer-filter-c-mode "c")
  ("e" peng-ibuffer-filter-emacs-lisp-mode "elisp")
  ("s" peng-ibuffer-filter-sql-mode "sql")
  ("d" peng-ibuffer-filter-dired-mode "dired")
  ("p" peng-ibuffer-filter-c++-mode "c++")
  )

(defhydra hydra-buffer-and-bookmark (:hint nil
                                           :exit t
                                           :columns 4)
  "Buffers"
  ("n" xah-next-user-buffer "xah-next-user-buffer" :exit nil)
  ("p" xah-next-user-buffer  "xah-next-user-buffer" :exit nil)
  ("s" save-buffer "save-buffer")
  ("l" bookmark-bmenu-list "bookmark list")
  ("m" bookmark-set "bookmark-set")
  ("b" ibuffer "ibuffer")
  ("g" hydra-ibuffer-filters/body "buffer filter")
  )



;;; for projectile
(defhydra hydra-projectile-other-window (:color teal)
  "projectile-other-window"
  ("f"  projectile-find-file-other-window        "file")
  ("g"  projectile-find-file-dwim-other-window   "file dwim")
  ("d"  projectile-find-dir-other-window         "dir")
  ("b"  projectile-switch-to-buffer-other-window "buffer")
  ("q"  nil                                      "cancel" :color blue))

(defhydra hydra-projectile (:color red
                                   :hint nil
                                   :columns 3
                                   :exit t)
  "
     PROJECTILE: %(projectile-project-root)

     Find File            Search/Tags          Buffers                Cache
------------------------------------------------------------------------------------------
"
  ("a"   projectile-ag "projectile-ag")
  ("b"   my-projectile-switch-to-buffer "my-projectile-switch-to-buffer")
  ("c"   projectile-invalidate-cache "projectile-invalidate-cache")
  ;; ("d"   projectile-find-dir "projectile-find-dir")
  ("d"   projectile-find-dir "projectile-find-dir")
  ("s-f" projectile-find-file-dwim "projectile-find-file-dwim")
  ("F" projectile-find-file-dwim "projectile-find-file-dwim")
  ("ff"  projectile-find-file "projectile-find-file")
  ("fd"  projectile-find-file-in-directory "projectile-find-file-in-directory")
  ("g"   ggtags-update-tags "ggtags-update-tags")
  ("s-g" ggtags-update-tags "ggtags-update-tags")
  ("i"   projectile-ibuffer "projectile-ibuffer")
  ("K"   projectile-kill-buffers "projectile-kill-buffers")
  ("s-k" projectile-kill-buffers "projectile-kill-buffers")
  ("m"   projectile-multi-occur "projectile-multi-occur")
  ("o"   projectile-multi-occur "projectile-multi-occur")
  ("s-p" projectile-switch-project "switch project")
  ("p"   projectile-switch-project "projectile-switch-project")
  ("s"   projectile-switch-project "projectile-switch-project")
  ("r"   projectile-ripgrep "rg")
  ("R"   projectile-recentf "projectile-recentf")
  ("x"   projectile-remove-known-project "projectile-remove-known-project")
  ("X"   projectile-cleanup-known-projects "projectile-cleanup-known-projects")
  ("z"   projectile-cache-current-file "projectile-cache-current-file")
  ("`"   hydra-projectile-other-window/body "other window")
  ("q"   nil "cancel" :color blue))
(peng-global-set-key (kbd "C-c p") 'hydra-projectile/body)

;;; for yasnippet
(defhydra hydra-yasnippet (:color blue :hint nil)
  "
              ^YASnippets^
--------------------------------------------
  Modes:    Load/Visit:    Actions:

 _g_lobal  _d_irectory    _i_nsert
 _m_inor   _f_ile         _t_ryout
 _e_xtra   _l_ist         _n_ew
         _a_ll
"
  ("d" yas-load-directory)
  ("e" yas-activate-extra-mode)
  ("i" yas-ivy-expand)
  ("f" yas-visit-snippet-file :color blue)
  ("n" yas-new-snippet)
  ("t" yas-tryout-snippet)
  ("l" yas-describe-tables)
  ("g" yas/global-mode)
  ("m" yas/minor-mode)
  ("a" yas-reload-all))
(peng-global-set-key (kbd "C-c y") 'hydra-yasnippet/body)

(defhydra hydra-breadcrumb
  (:exit t)
  "
Breadcrumb bookmarks:
  _<up>_:   prev   _S-<up>_:   local prev
  _<down>_: next   _S-<down>_: local next
  _s_: set  _c_: clear  _l_: list  _q_: quit _t_: set
"
  ("<down>" bc-next nil :exit nil)
  ("<up>" bc-previous nil :exit nil)
  ("S-<down>" bc-local-next nil :exit nil)
  ("S-<up>" bc-local-previous nil :exit nil)
  ("j" bc-local-next "local down" :exit nil)
  ("k" bc-local-previous "local up" :exit nil)
  ("l" bc-list nil)
  ("s" bc-set nil)
  ("t" bc-set nil)
  ("c" bc-clear nil)
  ("q" nil nil)
  ("SPC" hydra-local-bookmark-menu/body "origin bookmarks")
  )

(defhydra hydra-local-bookmark-menu (:exit t
                                           :columns 3)
  "Local bookmark"
  ("t" bm-toggle "toggle")
  ("P" bm-toggle-buffer-persistence "toggle buffer persistence")
  ("n" bm-next "next" :exit nil)
  ("p" bm-previous "previours" :exit nil)
  ("s" bm-show-all "show all")
  ("S" bm-save "save all bookmark to disk")
  ("L" bm-load-and-restore "load bookmark from disk")
  ("l" bm-show "show current file")
  ("d" peng-bm-remove-all-all-buffers "remove all")
  ("c" peng-bm-remove-current-buffer "remove current file")
  ("h" helm-bm "helm bm")
  ("r" bm-bookmark-regexp "set bookmark match regexp")
  ("SPC" hydra-breadcrumb/body "hydra-breadcrumb")
  ("RET" nil "cancel")
  ("<return>" nil "cancel")
  )

;;; ;;;;;;;;;;;;;;;;;;;;;;;for hydra redo ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar last-hydra-command nil)
(defun hydra-redo--set-last-command (cmd)
  (setq last-hydra-command cmd))
;; 在论坛提问，找到这个函数`hydra--call-interactively-remap-maybe'，在
;; 之前设置一下 `last-command' 就可以了
(advice-add #'hydra--call-interactively-remap-maybe :before #'hydra-redo--set-last-command)
(defun hydra-redo ()
  (interactive)
  (when last-hydra-command
    (funcall last-hydra-command)))
;;; ;;;;;;;;;;;;;;;;;;;;;;;for hydra redo ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define-key peng-evil-normal-map (kbd "t") 'hydra-local-bookmark-menu/body)

;;; global keys
(peng-global-set-key (kbd "C-c b") 'hydra-breadcrumb/body)
(peng-global-set-key (kbd "C-e") 'mwim-end-of-code-or-line)
(peng-global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
(peng-global-set-key (kbd "C-S-t") 'xah-open-last-closed)
(peng-global-set-key (kbd "C-w") 'xah-close-current-buffer)
(peng-global-set-key (kbd "C-S-w") #'(lambda ()
                                       (interactive)
                                       (progn
                                         (xah-close-current-buffer)
                                         (delete-window))))

;; (peng-global-set-key (kbd "C-o") 'peng-asp-engine-project-and-ivy-ls)
;; (peng-global-set-key (kbd "C-S-O") 'peng-asp-engine-project-and-ivy-grep)
(peng-global-set-key (kbd "C-o") 'counsel-find-file)
(peng-global-set-key (kbd "C-S-O") 'peng-ivy-ls-git)
(peng-global-set-key (kbd "M-e") 'forward-sentence)
(peng-global-set-key (kbd "C-j") 'ivy-switch-buffer)
(peng-global-set-key (kbd "C-S-j") 'peng-ivy-switch-buffer-to-views)


;;; main spc entry
(setq peng-spc-main-map (make-sparse-keymap))
(define-key peng-spc-main-map (kbd "f") 'hydra-evil-normal-state-f-menu/body)
(define-key peng-spc-main-map (kbd "g") 'hydra-evil-normal-state-g-menu/body)
(define-key peng-spc-main-map (kbd "w") 'hydra-w-menu/body)
(define-key peng-spc-main-map (kbd "o") 'hydra-occur-dwim/body)
(define-key peng-spc-main-map (kbd "y") 'hydra-peng-yank/body)
(define-key peng-spc-main-map (kbd "d") 'hydra-peng-d-menu/body)
(define-key peng-spc-main-map (kbd "t") 'hydra-local-bookmark-menu/body)
(define-key peng-spc-main-map (kbd "k") 'hydra-k-map/body)
(define-key peng-spc-main-map (kbd "a") 'hydra-ag-dwim/body)
(define-key peng-spc-main-map (kbd "e") 'hydra-e-menu/body)
(define-key peng-spc-main-map (kbd "h") 'hydra-help/body)
(define-key peng-spc-main-map (kbd "x") 'hydra-x-menu/body)
(define-key peng-spc-main-map (kbd "c") 'hydra-org/body)
(define-key peng-spc-main-map (kbd "q") 'xah-close-current-buffer)
(define-key peng-spc-main-map (kbd "Q") 'kill-buffer-and-window)
(define-key peng-spc-main-map (kbd "i") 'hydra-insert/body)
(define-key peng-spc-main-map (kbd "b") 'hydra-buffer-and-bookmark/body)
(define-key peng-spc-main-map (kbd "u") 'universal-argument)
(define-key peng-spc-main-map (kbd "s") 'save-buffer)
;; (define-key peng-spc-main-map (kbd "l") 'hydra-select/body)
(define-key peng-spc-main-map (kbd "l") 'hydra-global/body)
(define-key peng-spc-main-map (kbd "p") 'hydra-peng-p-menu/body)
(define-key peng-spc-main-map (kbd ";") 'counsel-M-x)
(define-key peng-spc-main-map (kbd ".") 'hydra-redo)
(define-key peng-spc-main-map (kbd "v") 'hydra-cscope/body)
(define-key peng-spc-main-map (kbd "<backspace>") 'delete-other-windows)
(define-key peng-spc-main-map (kbd "RET") 'counsel-M-x)
(define-key peng-spc-main-map (kbd "<return>") 'counsel-M-x)

(peng-global-set-evil-non-edit-mode-key (kbd "SPC") peng-spc-main-map)
(peng-global-set-key (kbd "M-k") peng-spc-main-map)
(peng-global-set-key (kbd "<f9>") peng-spc-main-map)

(peng-global-set-key (kbd "C-M-k") 'sp-kill-hybrid-sexp)
(peng-global-set-key (kbd "C-M-S-k") 'sp-kill-sexp)
(peng-global-set-key (kbd "C-M-a") 'sp-beginning-of-sexp)
(peng-global-set-key (kbd "C-M-e") 'sp-end-of-sexp)

(peng-global-set-key (kbd "<f8>") 'w3m-bookmark-view)
;; (peng-global-set-key (kbd "<f5>") #'(lambda (x)
;;                                       (interactive "P")
;;                                       (progn
;;                                         (ibuffer)
;;                                         (if x
;;                                             (ibuffer-update t)
;;                                           (ibuffer-update nil)))))
(peng-global-set-key (kbd "<f5>") 'mu4e)
(peng-global-set-key (kbd "<f11>") 'peng-bookmarks-w3m)
(peng-global-set-key (kbd "<f10>") #'(lambda ()
                                       (interactive)
                                       (progn
                                         (magit-status)
                                         (delete-other-windows))))
(peng-global-set-key (kbd "<delete>") 'peng-custumize-rg)
(peng-global-set-key (kbd "M-i") 'counsel-grep-or-swiper)
(peng-global-set-key (kbd "M-I") 'peng-swiper-current-symbol)
(peng-global-set-key (kbd "<f6>") #'(lambda ()
                                      (interactive)
                                      (progn
                                        (recompile)
                                        (switch-to-buffer-other-window "*compilation*"))))

(peng-global-set-key (kbd "<S-f6>") 'compile)
(peng-global-set-key (kbd "<pause>") 'symbol-overlay-put)
(peng-global-set-key (kbd "<Scroll_Lock>") 'symbol-overlay-remove-all)


;;; for windows configure
;; ;;; origin
;; (define-key evil-normal-state-map "m" 'peng-window-configuration-to-register)
;; (define-key evil-motion-state-map "m" 'peng-window-configuration-to-register)
;; (define-key evil-normal-state-map "'" 'jump-to-register)
;; (define-key evil-motion-state-map "'" 'jump-to-register)
;;; now
(define-key evil-normal-state-map "m" 'ivy-push-view)
(define-key evil-motion-state-map "m" 'ivy-push-view)
(define-key evil-normal-state-map "M" 'ivy-pop-view)
(define-key evil-motion-state-map "M" 'ivy-pop-view)
(define-key evil-normal-state-map "'" 'peng-ivy-switch-buffer-to-views)
(define-key evil-motion-state-map "'" 'peng-ivy-switch-buffer-to-views)

(define-key evil-normal-state-map "1" 'peng-custumize-rg)
(define-key evil-motion-state-map "1" 'peng-custumize-rg)

(define-key evil-normal-state-map "!" 'peng-custumize-rg-dwim)
(define-key evil-motion-state-map "!" 'peng-custumize-rg-dwim)

(define-key evil-normal-state-map "2" 'counsel-ag)
(define-key evil-motion-state-map "2" 'counsel-ag)
(define-key evil-normal-state-map "@" #'(lambda ()
                                          (interactive)
                                          (progn
                                            (counsel-ag (thing-at-point 'symbol)))))
(define-key evil-motion-state-map "@" #'(lambda ()
                                          (interactive)
                                          (progn
                                            (counsel-ag (thing-at-point 'symbol)))))

(define-key evil-normal-state-map "3" 'counsel-grep-or-swiper)
(define-key evil-motion-state-map "3" 'counsel-grep-or-swiper)
(define-key evil-normal-state-map "#" 'peng-swiper-current-symbol)
(define-key evil-motion-state-map "#" 'peng-swiper-current-symbol)

(define-key evil-normal-state-map "4" 'helm-semantic-or-imenu)
(define-key evil-motion-state-map "4" 'helm-semantic-or-imenu)

(define-key evil-normal-state-map "0" 'dumb-jump-go)
(define-key evil-motion-state-map "0" 'dumb-jump-go)

(define-key evil-normal-state-map "5" 'peng-custumize-ag-regexp)
(define-key evil-motion-state-map "5" 'peng-custumize-ag-regexp)

(define-key evil-normal-state-map "6" 'helm-semantic-or-imenu)
(define-key evil-motion-state-map "6" 'helm-semantic-or-imenu)

;;; on my thinkpad T420s, I don't want to use these keys.
(global-unset-key (kbd "<XF86Back>"))
(global-unset-key (kbd "<XF86Forward>"))

(defun peng-reload-hydra-keymap ()
  (interactive)
  (load-file (concat
              LISP
              "/init-hydra.el")))


(defhydra hydra-counsel-gtags (:color pink
                                      :hint nil
                                      :columns 3
                                      :exit t)
  "Counsel Gnu global"
  ("L" counsel-gtags-create-tags "create")
  ("l" counsel-gtags-create-tags "create")
  ("u" counsel-gtags-update-tags "update")
  ("d" counsel-gtags-find-definition "define")
  ("r" counsel-gtags-find-reference "reference")
  ("b" counsel-gtags-go-backward "backward" :exit nil)
  ("f" counsel-gtags-go-forward "forward" :exit nil)
  )

(provide 'init-hydra)
