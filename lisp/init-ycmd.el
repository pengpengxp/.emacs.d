(require 'ycmd)
;;; 这个设置编译出来的ycmd目录。注意这里的ycmd不是一个可执行文件，而是一个目录
;; (set-variable 'ycmd-server-command '("/usr/bin/python" "/home/pengpengxp/github/ycmd/ycmd"))
(set-variable 'ycmd-server-command '("/usr/bin/python3" "/home/pengpengxp/github/ycmd/ycmd"))
(set-variable 'ycmd-global-config "/home/pengpengxp/.data/.frr_ycmd_extra_conf.py")

;;; 设置等待server的时间，默认是3s
(setq ycmd-startup-timeout 5)

;;; 当ycmd-mode开启后，把ycmd加入到默认emacs的补全中
(defun ycmd-setup-completion-at-point-function ()
  "Setup `completion-at-point-functions' for `ycmd-mode'."
  (interactive)
  (add-hook 'completion-at-point-functions
            #'ycmd-complete-at-point nil :local))

(add-hook 'ycmd-mode #'ycmd-setup-completion-at-point-function)

;;; show debug info to *Messages* buffer
(setq url-show-status t)

;;; tab setup
(setq tab-always-indent 'complete)

(defun peng-setup-ycmd ()
  " setup ycmd, add `ycmd-complete-at-point' to
  `completion-at-point-functions' so that `C-M-i' can toggle the
  complete.
"
  (interactive)
  (ycmd-mode 1)
  (add-hook 'completion-at-point-functions
            #'ycmd-complete-at-point nil :local))

(require 'company-ycmd)
(company-ycmd-setup)

(provide 'init-ycmd)
