(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(add-hook 'web-mode-hook #'(lambda ()
                             (hl-line-mode)
                             (company-mode -1)
                             ;; setup for tern
                             (eval-after-load 'tern
                               '(progn
                                  (require 'tern-auto-complete)
                                  (tern-ac-setup)))
                             (tern-mode 1)
                             (auto-complete-mode 1)
                             (define-key evil-insert-state-local-map (kbd "C-M-i") 'tern-ac-complete)
                             ))


(provide 'init-web-mode.el)
