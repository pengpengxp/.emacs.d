(require 'chinese-pyim)

;; (defun peng-pyim-add-dict ()
;;   "为 `pyim-dicts' 添加词库信息，然后 `pyim-dicts' 将通过
;; `customize-save-variable' 函数保存到用户emacs配置中"
;;   (interactive)
;;   (let (dict name file coding first-used)
;;     (setq name (read-from-minibuffer "请输入词库名称： "))
;;     (setq file (read-file-name "请选择词库文件： " "~/"))
;;     (setq coding (completing-read "词库文件编码: " '("utf-8-unix" "cjk-dos")))
;;     (setq first-used  (yes-or-no-p "是否让 Chinese-pyim 优先使用词库？ "))
;;     (setq dict `(:name ,name :file ,file :coding ,(intern coding)))
;;     (if first-used
;;         (add-to-list 'pyim-dicts dict)
;;       (add-to-list 'pyim-dicts dict t))
;;     ;; 将`pyim-dict'的设置保存到emacs配置文件中。
;;     (customize-save-variable 'pyim-dicts pyim-dicts)
;;     (message "添加并保存 Chinese-pyim 输入法词库: (%s)，重启 emacs 后生效！" name)))

(defun pyim-use-dict:bigdict ()
  (interactive)
  (setq pyim-dicts
        '((:name "BigDict"
                 :file "/Users/pengpengxp/.emacs.d/site-lisp/chinese-pyim/pyim-bigdict.txt"
                 :coding utf-8-unix)))
  (pyim-restart-1 t))

(provide 'init-chinese-pyim)
