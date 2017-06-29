(require 'visual-basic-mode)
(add-to-list 'auto-mode-alist
	     '("\\.bas" . visual-basic-mode))

(require 'vbasense)
;; Keybinding
(setq vbasense-popup-help-key "C-:")
(setq vbasense-jump-to-definition-key "C->")

;; Make config suit for you. About the config item, eval the following sexp.
;; (customize-group "vbasense")

;; Do setting a recommemded configuration
(vbasense-config-default)

(provide 'init-vba)
