;; (setq tramp-default-method "ssh")
;; (require 'tramp)

(use-package tramp
  :init

;;; 使tramp可以使用`/sudo:root@host:/etc'这样的形式来在远程使用`sudo'
;;; 编辑文件，甚至可以使用`cd'直接进去。场景是不能通过root用户远程登陆，
;;; 但是又需要使用root的权限来编辑文件。
  (add-to-list 'tramp-default-proxies-alist
               '(nil "\\`root\\'" "/ssh:%h:"))
  (add-to-list 'tramp-default-proxies-alist
               '((regexp-quote (system-name)) nil nil))

;;; 本机中使用`localhost'这个HOST来使用sudo，设置在本机时的user和proxy
;;; 都是默认值nil
  (add-to-list 'tramp-default-proxies-alist
               '((regexp-quote "localhost") nil nil))

;;; passwd not expired
  (setq password-cache-expiry nil)

;;; not `Waiting for remote prompt shell...'
  (setq tramp-shell-prompt-pattern "\\(?:^\\|\\)[^]#$%>\n]*#?[]#$%>].* *\\(\\[[0-9;]*[a-zA-Z] *\\)*")

  (add-to-list 'eshell-modules-list 'eshell-tramp)
  )

(provide 'init-tramp)
