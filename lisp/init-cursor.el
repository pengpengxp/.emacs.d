; Using in Emacs 24.0 

;;; 光标闪动
(blink-cursor-mode t)

;; ;; ;;;设置evil各个模式cursor的形状
;; (setq evil-insert-state-cursor '("" (bar . 5)))
(setq evil-insert-state-cursor '("" box))
(setq evil-emacs-state-cursor '("" box))
;; (setq evil-insert-state-cursor '("black" (bar . 5)))
;; (setq evil-emacs-state-cursor '("black" box))

;; (defvar blink-cursor-colors (list  "#92c48f" "#6785c5" "#be369c" "#d9ca65")
;;   "On each blink the cursor will cycle to the next color in this list.")

(defvar blink-cursor-colors (list  "#ffffff")
  "On each blink the cursor will cycle to the next color in this list.")

(setq blink-cursor-count 1)
(defun blink-cursor-timer-function ()
  "Zarza wrote this cyberpunk variant of timer `blink-cursor-timer'. 
Warning: overwrites original version in `frame.el'.

This one changes the cursor color on each blink. Define colors in `blink-cursor-colors'."
  (when (not (internal-show-cursor-p))
    (when (>= blink-cursor-count (length blink-cursor-colors))
      (setq blink-cursor-count 0))
    (set-cursor-color (nth blink-cursor-count blink-cursor-colors))
    (setq blink-cursor-count (+ 1 blink-cursor-count))
    )
  (internal-show-cursor nil (not (internal-show-cursor-p)))
  )

(provide 'init-cursor)
