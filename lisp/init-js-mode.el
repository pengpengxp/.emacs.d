(defun peng-js-mode ()
  ;; (define-key evil-normal-state-local-map (kbd "SPC z") 'peng-run-current-script)
  (autopair-on)
  (smart-tab-mode-off)
  (peng-local-set-key (kbd "C-c C-v") 'peng-run-current-script)
  (company-mode -1)

  (peng-local-set-key (kbd "M-DEL") 'cscope-pop-mark)
  (peng-local-set-key (kbd "<M-backspace>") 'cscope-pop-mark)

  ;; (define-key evil-normal-state-local-map (kbd "SPC RET") 'cscope-find-global-definition-no-prompting)
  ;; (define-key evil-normal-state-local-map (kbd "SPC <return>") 'cscope-find-global-definition-no-prompting)

  (define-key evil-normal-state-local-map (kbd "C-]") 'etags-select-find-tag-at-point)
  (peng-local-set-key (kbd "<C-down-mouse-1>") 'etags-select-find-tag-at-point)
  (peng-local-set-key (kbd "<mouse-3>") 'pop-tag-mark)
  (hl-line-mode 1)

  (auto-complete-mode 1)
  ;; setup for tern
  (eval-after-load 'tern
    '(progn
       (require 'tern-auto-complete)
       (tern-ac-setup)))
  (tern-mode 1)
  )

(add-hook 'js-mode-hook 'peng-js-mode)
(add-hook 'js2-mode-hook 'peng-js-mode)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(provide 'init-js-mode)
