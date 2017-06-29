(require 'mustache)
(require 'ht) ;; hash table library

(let ((context (ht ("name" "J. Random user"))))
  ;; evaluates to: "Hello J. Random user!"
  (mustache-render "Hello {{name}}!" context))

(provide 'init-mustache)
