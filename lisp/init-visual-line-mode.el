;;; init-visual-line-mode.el --- 
;; 
;; Filename: init-visual-line-mode.el
;; 
;; Description: config my visual-line-mode
;; 
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 日  1月 11 17:24:54 2015 (+0800)
;; Version: 
;; Last-Updated: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

;;; I copy from James Wright to set the visual-line-mode warp at the
;;; fill-column
(defvar visual-wrap-column nil)

(defun set-visual-wrap-column (new-wrap-column &optional buffer)
  "Force visual line wrap at NEW-WRAP-COLUMN in BUFFER (defaults
to current buffer) by setting the right-hand margin on every
window that displays BUFFER.  A value of NIL or 0 for
NEW-WRAP-COLUMN disables this behavior."
  (interactive (list (read-number "New visual wrap column, 0 to disable: "
                                  (or visual-wrap-column fill-column 0))))
  (if (and (numberp new-wrap-column)
           (zerop new-wrap-column))
    (setq new-wrap-column nil))
  (with-current-buffer (or buffer (current-buffer))
    (visual-line-mode t)
    (set (make-local-variable 'visual-wrap-column) new-wrap-column)
    (add-hook 'window-configuration-change-hook
              'update-visual-wrap-column nil t)
    (let ((windows (get-buffer-window-list)))
      (while windows
        (when (window-live-p (car windows))
          (with-selected-window (car windows)
            (update-visual-wrap-column)))
        (setq windows (cdr windows))))
    (setq word-wrap nil)))

(defun update-visual-wrap-column ()
  (if (not visual-wrap-column)
    (set-window-margins nil nil)
    (let* ((current-margins (window-margins))
           (right-margin (or (cdr current-margins) 0))
           (current-width (window-width))
           (current-available (+ current-width right-margin)))
      (if (<= current-available visual-wrap-column)
        (set-window-margins nil (car current-margins))
        (set-window-margins nil (car current-margins)
                            (- current-available
  visual-wrap-column))))))

;; (set-visual-wrap-column fill-column)
(setq visual-line-fringe-indicators '(left-arrow nil))
(setq word-wrap nil)

(provide 'init-visual-line-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-visual-line-mode.el ends here
