(require 'ycmd)
;; (set-variable 'ycmd-server-command '("python3" "/Users/pengpengxp/github/ycmd/ycmd"))
(set-variable 'ycmd-server-command '("python" "/Users/pengpengxp/github/ycmd/ycmd"))
(set-variable 'ycmd-global-config "/Users/pengpengxp/src/ASP-Engine/nginx/.ycm_extra_conf.py")

;; (global-ycmd-mode 1)

(require 'company-ycmd)
(company-ycmd-setup)

(provide 'init-ycmd)
