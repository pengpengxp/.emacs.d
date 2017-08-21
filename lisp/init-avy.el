(require 'avy)
(load-file "/home/pengpengxp/.emacs.d/elpa/avy-20150512.346/avy.el")

(peng-global-set-key (kbd "C-j") #'avy-goto-char)
 
(provide 'init-avy)
