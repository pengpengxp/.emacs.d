
(require 'benchmark-init)
(require 'benchmark-init-loaddefs)

(let ((benchmark-init.el "/home/pengpengxp/.emacs.d/site-lisp/benchmark-init-el-master/benchmark-init.el"))
  (when (file-exists-p benchmark-init.el)
    (load benchmark-init.el)))

(provide 'init-benchmark-init)
