(require 'expand-region)
(peng-global-set-key (kbd "C-=") 'er/expand-region)
(peng-global-set-key (kbd "C--") 'er/contract-region)

(provide 'init-expand-region)
