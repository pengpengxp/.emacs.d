(require 'irony)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(setq irony-cdb--compilation-database 'irony-cdb-json)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)  

(provide 'init-irony-mode)
