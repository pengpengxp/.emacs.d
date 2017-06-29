(require 'shell-pop)

(setq shell-pop-term-shell "/bin/bash")
(setq shell-pop-shell-type '("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell))))
(setq shell-pop-window-position "bottom")
(setq shell-pop-full-span t)

(provide 'init-shell-pop)
