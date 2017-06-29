(require 'org-tree-slide)

;;; 暂时还没有在退出时设置方向键为原来的绑定
(add-hook 'org-tree-slide-mode-hook (lambda ()
				      (interactive)
				      (peng-local-set-key (kbd "<up>") 'org-tree-slide-move-previous-tree)
				      (peng-local-set-key (kbd "<left>") 'org-tree-slide-move-previous-tree)
				      (peng-local-set-key (kbd "<down>") 'org-tree-slide-move-next-tree)
				      (peng-local-set-key (kbd "<right>") 'org-tree-slide-move-next-tree)
				      ))
(provide 'init-org-tree-slide-mode)
