(defun peng-python-mode ()
  (require 'init-ycmd)
  (elpy-enable)
  (defun peng-elpy-shell-send-current-statement ()
    "Send current statement but not goto next line"
    (interactive)
    (save-excursion
      (elpy-shell-send-current-statement)))

  (defun peng-resend-current-buffer (&optional args)
    "Not support for selected regions"
    (interactive "P")

    (let ((buffer-name "*Python*"))
      (save-excursion
        (if (get-buffer buffer-name)
            (progn
              (kill-buffer buffer-name)
              (elpy-shell-send-region-or-buffer args))
          (elpy-shell-send-region-or-buffer args)))))
  (defun peng-python-projectile-ag-find-def ()
    (interactive)
    (projectile-ag (concat "^ *\(def\|class\) *"
                           (thing-at-point 'symbol)) t))

  (defhydra hydra-local-python (:exit t
                                      :columns 3)
    "Python Mode"
    ("s" elpy-rgrep-symbol "elpy-rgrep-symbol")
    ("d" elpy-goto-definition "elpy-goto-definition")
    ("D" peng-python-projectile-ag-find-def "peng-python-projectile-ag-find-def")
    ("l" elpy-set-project-root "elpy-set-project-root")
    ("f" elpy-find-file "elpy-find-file")
    ("t" pop-tag-mark "pop-tag-mark")
    ("c" elpy-doc "elpy-doc")
    ("o" elpy-occur-definitions "elpy-occur-definitions")
    ("z" peng-run-current-script "peng-run-current-script")
    ("p" hydra-projectile/body "hydra-projectile/body")
    ("g" hydra-global/body "hydra-global/body")
    ("e" hydra-etags/body "hydra-etags/body")
    ("a" projectile-ag "projectile-ag")
    ("RET" nil "cancel")
    )
  (define-key evil-normal-state-local-map (kbd "<return>") 'peng-elpy-shell-send-current-statement)
  (define-key evil-normal-state-local-map (kbd "RET") 'peng-elpy-shell-send-current-statement)
  (autopair-on)
  (peng-local-set-key (kbd "C-c C-v") 'peng-run-current-script)
  (peng-local-set-key (kbd "C-c C-l") 'peng-elpy-shell-send-current-statement)
  (company-mode 1)
  (peng-local-set-key (kbd "<C-right>") 'elpy-nav-forward-indent)
  (peng-local-set-key (kbd "<C-left>") 'elpy-nav-backward-indent)
  (peng-local-set-key (kbd "<C-S-left>") 'elpy-nav-indent-shift-left)
  (peng-local-set-key (kbd "<C-S-right>") 'elpy-nav-indent-shift-right)
  
  
  (peng-local-set-key (kbd "<C-down>") 'elpy-nav-forward-block)
  (peng-local-set-key (kbd "<C-up>") 'elpy-nav-backward-block)
  (peng-local-set-key (kbd "<C-S-return>") 'peng-resend-current-buffer)
  (peng-local-set-key (kbd "<C-down-mouse-1>") 'elpy-goto-definition)
  (peng-local-set-key (kbd "M-c") 'hydra-local-python/body)
  (peng-local-set-key (kbd "M-.") 'etags-select-find-tag-at-point)
  (peng-local-set-key (kbd "C-t") 'pop-tag-mark)

  (define-key evil-normal-state-local-map (kbd "g ]") 'peng-etags-select)
  (define-key evil-normal-state-local-map (kbd "SPC m") 'hydra-local-python/body)
  (define-key evil-normal-state-local-map (kbd "SPC v") 'hydra-cscope/body)

  (define-key evil-normal-state-local-map (kbd "<M-return>") 'cscope-find-global-definition-no-prompting)
  (define-key evil-normal-state-local-map (kbd "<C-return>") 'peng-cscope-find-this-symbol-no-prompting)
  (define-key evil-normal-state-local-map (kbd "<M-backspace>") 'cscope-pop-mark)
  (define-key evil-normal-state-local-map (kbd "<M-DEL>") 'cscope-pop-mark)

  (hl-line-mode 1)
  (peng-setup-ycmd)
  (which-function-mode 1)
  (ggtags-mode 1)
  (dumb-jump-mode 1)
  (highlight-indent-guides-mode 1)
  )

;; (setq elpy-project-ignored-directories '(".bzr" "CVS" ".git" ".hg" ".svn" ".tox" "build" "dist" ".cask"))

(use-package python-mode
  :defer t
  :init
  (add-hook 'python-mode-hook 'peng-python-mode))

(provide 'init-python)
