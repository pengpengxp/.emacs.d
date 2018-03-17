(require 'rtags)
(require 'hydra)
(defhydra hydra-rtags (:color pink
                               :hint nil
                               :columns 3
                               :exit t)
  "Narrow"
  ("D" rtags-find-symbol "symbo")
  ("s" rtags-find-symbol-at-point "symbol at point" :exit nil)
  ("RET" rtags-find-symbol "find symbol")
  ("<return>" rtags-find-symbol "find symbol")
  ("R" rtags-find-references "Reference")
  ("r" rtags-find-references-at-point "Reference at point" :exit nil)
  ("C" rtags-find-references-current-dir "Reference current dirctory")
  ("f" rtags-find-functions-called-by-this-function "all fun called this fun")
  ("<" rtags-location-stack-back "back" :exit nil)
  (">" rtags-location-stack-forward "forward" :exit nil)
  ("v" rtags-location-stack-visualize "localtion visualize")
  ("n" rtags-next-match "next match" :exit nil)
  ("p" rtags-previous-match "previous match" :exit nil)
  ("c" nil "cancel")
  )

(add-hook 'rtags-mode-hook #'(lambda ()
                               (interactive)
                               (peng-local-set-key (kbd "RET") 'rtags-select-other-window)
                               (peng-local-set-key (kbd "<return>") 'rtags-select-other-window)
                               (peng-local-set-key (kbd "q") 'quit-window)
                               ))

(add-hook 'rtags-location-stack-visualize-mode-hook #'(lambda ()
                                                        (interactive)
                                                        (peng-local-set-key (kbd "RET") 'rtags-select-other-window)
                                                        (peng-local-set-key (kbd "<return>") 'rtags-select-other-window)
                                                        (peng-local-set-key (kbd "q") 'quit-window)
                                                        ))
(defun abo-abo-ciao-goto-symbol ()
  "abo-abo's wrap for `rtags-find-symbol-at-point'"
  (interactive)
  (deactivate-mark)
  (ring-insert find-tag-marker-ring (point-marker))
  (or (and (require 'rtags nil t)
           (rtags-find-symbol-at-point))
      (and (require 'semantic/ia)
           (condition-case nil
               (semantic-ia-fast-jump (point))
             (error nil)))))

(defun peng-use-specified-rtags-socket ()
  (interactive)
  (setq rtags-socket-file "~/.rtags/rdm_socket"))

(setq rtags-display-result-backend 'ivy)

(provide 'init-rtags)
