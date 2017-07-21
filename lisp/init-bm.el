;;bm
(add-to-list 'load-path (concat SITE-LISP "bm"))
(require 'bm)
(require 'evil)
(global-set-key (kbd "<left-margin> <mouse-5>") 'bm-next-mouse)
(global-set-key (kbd "<left-margin> <mouse-4>") 'bm-previous-mouse)
(global-set-key (kbd "<left-margin> <mouse-1>") 'bm-toggle-mouse)
(global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
(global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

;; ;;evil for bm
;; (define-key evil-normal-state-map (kbd "N") 'bm-next)
;; (define-key evil-normal-state-map (kbd "P") 'bm-previous)

(defadvice bm-show (after peng-bm-show activate)
  (define-key evil-normal-state-local-map (kbd "RET") 'bm-show-goto-bookmark)
  (define-key evil-normal-state-local-map (kbd "return") 'bm-show-goto-bookmark)
  ;; (delete-other-windows)
  )

(defadvice bm-show-all (after peng-bm-show-all activate)
  (define-key evil-normal-state-local-map (kbd "RET") 'bm-show-goto-bookmark)
  (define-key evil-normal-state-local-map (kbd "return") 'bm-show-goto-bookmark)
  ;; (delete-other-windows)
  )

(defun peng-bm-remove-all-all-buffers ()
  (interactive)
  (if (y-or-n-p "Do you really want to remove all bm tags? ")
      (bm-remove-all-all-buffers)))

(defun peng-bm-remove-current-buffer ()
  (interactive)
  (if (y-or-n-p "Do you really want to remove all tag in current buffer? ")
      (bm-remove-all-current-buffer)))
(provide 'init-bm)
