;测试的macro，在eim-py开启的情况下，在org文件中可以直接开始输入
;emacs-lisp源码
(fset 'peng-macro-insert-emacs-lisp-src-in-eim
   [?\; ?< ?s return tab ?\; ?e ?m ?a ?c ?s ?- ?l ?i ?s ?p return ?\C-n]) 

(provide 'init-macro)
