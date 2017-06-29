
(require 'dired-sort)

(setq dired-listing-switches "-alh")
(global-dired-hide-details-mode -1)
(setq dired-details-hidden-string "[ ... ] ") ;设置隐藏dired里面详细信息的字符串

(add-hook 'dired-mode-hook #'(lambda ()
                               (hl-line-mode 1)
			       (dired-hide-details-mode -1) ;进入时显示详细信息

			       (define-key evil-normal-state-local-map (kbd "SPC") peng-spc-main-map)

			       (define-key evil-normal-state-local-map (kbd "<tab>") #'dired-hide-details-mode)
			       (define-key evil-normal-state-local-map (kbd "TAB") #'dired-hide-details-mode)
			       (define-key evil-normal-state-local-map (kbd "r") #'revert-buffer)
			       (define-key evil-normal-state-local-map (kbd "f") #'dired-goto-file)
			       (define-key evil-normal-state-local-map (kbd "v") #'dired-view-file)
			       (define-key evil-normal-state-local-map (kbd "q") #'quit-window)
			       (define-key evil-normal-state-local-map (kbd "C") #'dired-do-copy)
			       (define-key evil-normal-state-local-map (kbd "R") #'dired-do-rename)
			       (define-key evil-normal-state-local-map (kbd "m") #'dired-mark)
			       (define-key evil-normal-state-local-map (kbd "u") #'dired-unmark)
			       (define-key evil-normal-state-local-map (kbd "U") #'dired-unmark-all-marks)
			       (define-key evil-normal-state-local-map (kbd "DEL") #'dired-unmark-backward)
			       (define-key evil-normal-state-local-map (kbd "<backspace>") #'dired-unmark-backward)
			       (define-key evil-normal-state-local-map (kbd "e i SPC") #'find-file)
			       (define-key evil-normal-state-local-map (kbd "G") #'evil-goto-line)
			       (define-key evil-normal-state-local-map (kbd "gg") #'evil-goto-first-line)
			       (define-key evil-normal-state-local-map (kbd "<M-up>") #'dired-up-directory)

			       ;; 方便地进行排序
			       (define-key evil-normal-state-local-map (kbd "s t") #'dired-sort-time)
			       (define-key evil-normal-state-local-map (kbd "s x") #'dired-sort-extension)
			       (define-key evil-normal-state-local-map (kbd "s s") #'dired-sort-size)
			       (define-key evil-normal-state-local-map (kbd "s n") #'dired-sort-name)

			       (define-key evil-normal-state-local-map (kbd ",") peng-evil-insert-map)

			       (define-key evil-normal-state-local-map (kbd "M-c") peng-M-c-map)
			       (define-key evil-normal-state-local-map (kbd "<C-up>") 'dired-up-directory)
                               (peng-local-set-key (kbd "M-s") 'other-window)
                               (peng-local-set-key (kbd "C-o") 'find-file)
                               (peng-local-set-key (kbd "E") 'ora-ediff-files)
                               (peng-local-set-key (kbd "_") 'xah-dired-rename-space-to-underscore)
                               (peng-local-set-key (kbd "-") 'xah-dired-rename-space-to-hyphen)
			       ))

(setq dired-guess-shell-alist-user                     ;设置文件默认打开的模式
      (list
        ;; 图书
        (list "\\.chm$" '(concat
                          "google-chrome chm:"            ;执行特定的命令
                          (replace-regexp-in-string ;替换空格为%20
                           " " "%20" (w3m-expand-file-name-as-url (dired-get-filename))) ;用URL的模式解析文件名
                          " -q"))
        ;; (list "\\.pdf$" "wine /data/Backup/WindowsTools/FoxitReader/FoxitReader.exe")
        (list "\\.pdf$" "open")
        (list "\\.pdg$" "wine /data/Backup/WindowsTools/MiniPDG/pdgreader.exe")
        ;; 多媒体
        ;; (list (format "\\(%s\\)$" (emms-player-get emms-player-mplayer 'regex)) "mplayer")
        (list "\\.\\(jpe?g\\|png\\)$" "open" )
        ;; 网页
        (list "\\.html?$" "open")
        ;; 压缩包
        (list "\\.rar$" "unrar e -ad")
        (list "\\.tar.bz2$" "tar jxvf")
        (list "\\.gz$" "gzip -d")
        (list "\\.mkv$" "open")
        (list "\\.rmvb$" "open")
        (list "\\.mp4$" "open")
        (list "\\.avi$" "open")
        (list "\\.doc$" "open")
        (list "\\.tex$" "xelatex")
        ;; 其他
        (list "\\.exe$" "wine")))

(provide 'init-dired)

;;; init-dired.el ends here


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; 之前的定制
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; dired-mode
;;; 自己的去掉标记的dired-do-copy版本。
;; (defun peng-dired-do-copy ()
;;   (interactive)
;;   (progn
;;     (dired-do-copy)
;;     (dired-unmark-all-marks)
;;     ))

;; (defun peng-dired-mode ()
;;   (hl-line-mode 1)
;;   (dired-details-install)
;;   (local-set-key (kbd "<tab>") 'dired-details-toggle)
;;   (local-set-key (kbd "C") 'dired-do-copy)
;;   (define-key evil-emacs-state-map (kbd "M-<up>") 'dired-up-directory)
;;   (auto-revert-mode 1)
;;   )
;; (add-hook 'dired-mode-hook 'peng-dired-mode)

;; ;;; Require
;; (require 'dired)
;; (require 'dired+)                       ;增强dired
;; (require 'dired-details)                ;Dired详细信息
;; (require 'dired-details+)               ;Dired详细消息切换

;; ;;; pengpengxp's evil-dired-mode 特殊定制了evil开启后的按键绑定
;; (require 'evil)
;; (evil-set-initial-state 'dired-mode 'normal)
;; (add-hook 'dired-mode-hook '(lambda ()
;; 			     (interactive)
;; 			     (define-key evil-normal-state-local-map (kbd "<tab>") 'dired-details-toggle)
;; 			     (define-key evil-normal-state-local-map (kbd "TAB") 'dired-details-toggle)
;; 			     (define-key evil-normal-state-local-map (kbd "r") 'revert-buffer)
;; 			     (define-key evil-normal-state-local-map (kbd "f") 'dired-goto-file)
;; 			     (define-key evil-normal-state-local-map (kbd "v") 'dired-view-file)
;; 			     (define-key evil-normal-state-local-map (kbd "q") 'quit-window)
;; 			     (define-key evil-normal-state-local-map (kbd "C") 'peng-dired-do-copy)
;; 			     (define-key evil-normal-state-local-map (kbd "R") 'dired-do-rename)
;; 			     (define-key evil-normal-state-local-map (kbd "m") 'dired-mark)
;; 			     (define-key evil-normal-state-local-map (kbd "u") 'dired-unmark)
;; 			     (define-key evil-normal-state-local-map (kbd "U") 'dired-unmark-all-marks)
;; 			     (define-key evil-normal-state-local-map (kbd "DEL") 'dired-unmark-backward)
;; 			     (define-key evil-normal-state-local-map (kbd "<backspace>") 'dired-unmark-backward)
;; 			     (define-key evil-normal-state-local-map (kbd "e i SPC") 'find-file)
;; 			     (define-key evil-normal-state-local-map (kbd "G") 'evil-goto-line)
;; 			     (define-key evil-normal-state-local-map (kbd "gg") 'evil-goto-first-line)
;; 			     (define-key evil-normal-state-local-map (kbd "<M-up>") 'dired-up-directory)

;; 			     (define-key evil-normal-state-local-map (kbd "SPC") 'peng-evil-spc-map) ;use spc in dire mode
;; ))

;; ;;; Code:

;; (setq dired-recursive-copies t)               ;可以递归的进行拷贝
;; (setq dired-recursive-deletes t)              ;可以递归的删除目录
;; (setq dired-recursive-deletes 'always)        ;删除东西时不提示
;; (setq dired-recursive-copies 'always)         ;拷贝东西时不提示
;; ;; (toggle-dired-find-file-reuse-dir 1)          ;使用单一模式浏览Dired
;; (setq dired-details-hidden-string "[ ... ] ") ;设置隐藏dired里面详细信息的字符串
;; (setq dired-listing-switches "-aluh")         ;传给 ls 的参数，这里就可以设置显示大小的方式
;; (setq directory-free-space-args "-Pkh")       ;目录空间选项
;; (setq dired-omit-size-limit nil)              ;dired忽略的上限
;; (setq dired-dwim-target t)                    ;Dired试着猜处默认的目标目录
;; (setq my-dired-omit-status t)                 ;设置默认忽略文件
;; (setq my-dired-omit-regexp "^\\.?#\\|^\\..*") ;设置忽略文件的匹配正则表达式
;; (setq my-dired-omit-extensions '(".cache" ".o" ".elc"))   ;设置忽略文件的扩展名列表
;; (add-hook 'dired-after-readin-hook '(lambda ()
;;                                       (progn
;;                                         (require 'dired-extension)
;;                                         (dired-sort-method)))) ;先显示目录, 然后显示文件
;; (add-hook 'dired-mode-hook '(lambda ()
;;                               (progn
;;                                 (require 'dired-extension)
;;                                 (dired-omit-method)))) ;隐藏文件的方法



;; (lazy-set-mode-autoload-key
;;  '(
;;    ("K" . dired-open-file)              ;用W3M打开各种文件
;;    )
;;  dired-mode-map nil "dired-open")
;; (lazy-set-mode-autoload-key
;;  '(
;;    (";" . dired-view-minor-mode-toggle) ;字母输入导航模式
;;    )
;;  dired-mode-map nil "dired-view")
;; (lazy-set-mode-autoload-key
;;  '(
;;    ("T" . dired-tar-pack-unpack)
;;    )
;;  dired-mode-map nil "dired-tar")
;; (lazy-set-mode-autoload-key
;;  '(
;;    ("M-o" . dired-toggle-omit)          ;切换忽略状态
;;    ("?" . dired-get-size)               ;得到文件的大小
;;    ("[" . dired-rename-with-copy)       ;重命名函数
;;    ("'" . dired-up-directory-single)    ;返回上一级目录
;;    ("4" . dired-serial-rename)          ;批量重命名
;;    ("7" . dired-move-to-last-file)      ;移动到最后一个文件
;;    ("8" . dired-move-to-first-file)     ;移动到第一个文件
;;    ("k" . dired-previous-file-line)     ;上一行
;;    ("j" . dired-next-file-line)         ;下一行
;;    ("{" . dired-gnome-open-file)        ;用GNOME方式打开文件
;;    ("E" . dired-touch-now)              ;Touch命令
;;    ("]" . dired-nautilus)               ;用 Nautils 加载当前目录
;;    ("f" . dired-find-file+)             ;打开当前文件或目录
;;    ("\"" . find-lisp-find-dired-pwd)    ;查找特定的lisp文件
;;    ("C-m" . dired-find-file+)           ;打开当前文件或目录
;;    )
;;  dired-mode-map nil "dired-extension")

;; ;;; ### Wdired ###
;; ;;; --- Dired 的编辑模式
;; (eval-after-load 'wdired
;;   '(lambda ()
;;      (progn
;;        (require 'wdired-extension)
;;        (lazy-set-key
;;         '(
;;           ("C-c C-e" . wdired-format-filename) ;格式化文件名
;;           )
;;         wdired-mode-map
;;         ))))

;; (defvar one-key-menu-dired-sort-alist nil
;;   "The `one-key' menu alist for DIRED-SORT.")

;; (setq one-key-menu-dired-sort-alist
;;       '(
;;         (("s" . "Size") . dired-sort-size)
;;         (("x" . "Extension") . dired-sort-extension)
;;         (("n" . "Name") . dired-sort-name)
;;         (("t" . "Modified Time") . dired-sort-time)
;;         (("u" . "Access Time") . dired-sort-utime)
;;         (("c" . "Create Time") . dired-sort-ctime)))

;; (defun one-key-menu-dired-sort ()
;;   "The `one-key' menu for DIRED-SORT."
;;   (interactive)
;;   (require 'one-key)
;;   (require 'dired-sort)                 ;排序 dired 文件
;;   (one-key-menu "DIRED-SORT" one-key-menu-dired-sort-alist t))


