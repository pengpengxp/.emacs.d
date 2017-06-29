;;; darkroom-mode.el - Distraction free editing mode

;; Author: Martin Svenson
;; Usage: M-x darkroom-mode
;; License: free for all usages/modifications/distributions/whatever.
;; Requirements: w32-fullscreen.el on Windows

(require 'cl)

(cond ((eq window-system 'w32) 
       (require 'w32-fullscreen)))
        
(require 'frame-local-vars)

;; ------ Customization -----
(defgroup darkroom nil
  "A full-screen mode for distraction-free editing."
  :group 'convenience)

(defcustom darkroom-mode-left-margin 30
  "Margin to add to the left side of the screen."
  :type 'integer
  :group 'darkroom)

(defcustom darkroom-mode-right-margin 30
  "Margin to add to the right side of the screen."
  :type 'integer
  :group 'darkroom)

(defcustom darkroom-mode-enable-multi-monitor-support t
  "Whether to enable multi-frame (i.e. multiple monitor) support.
Optional since this feature is experimental."
  :type 'boolean
  :group 'darkroom)

(defcustom darkroom-mode-enable-longline-wrap t
  "If `longlines-mode', should `longlines-wrap-follows-window-size'
also be enabled on entering `darkroom-mode'?"
  :type 'boolean
  :group 'darkroom)

(defcustom darkroom-mode-enable-hook nil
  "Hook called by darkroom-mode-enable."
  :type 'hook
  :group 'darkroom)

(defcustom darkroom-mode-enable-hook nil
  "Hook called by darkroom-mode-disable."
  :type 'hook
  :group 'darkroom)

;; -------- code start -------
(setq *darkroom-mode-memtable* (make-hash-table))

(defun* darkroom-recall (var &optional (frame (selected-frame)))
  (cdr (assoc var (gethash frame *darkroom-mode-memtable*))))

(defun* darkroom-remember (var val &optional (frame (selected-frame)))
  (let* ((varlist (gethash frame *darkroom-mode-memtable*))
	 (target (assoc var varlist)))
    (cond (target
	   (setf (cdr target) val))
	  (t
	   (puthash frame (cons (cons var val)
				varlist) *darkroom-mode-memtable*)))))

(defun darkroom-mode-set-enabled(var)
  (darkroom-remember 'darkroom-mode-enabled var))

(defun darkroom-mode-enabledp()
  (darkroom-recall 'darkroom-mode-enabled))

(defun darkroom-mode-update-window()
  (set-window-margins (selected-window)
		      left-margin-width
		      right-margin-width))

;;;###autoload
(defun darkroom-mode ()
  (interactive)
  (cond ((darkroom-mode-enabledp)
	 (darkroom-mode-disable))
	(t
	 (darkroom-mode-enable))))

(defun darkroom-mode-enable()
  (interactive)
  ; ----- margins
  ; note: margins are buffer local, so if multi-monitor support is
  ;       enabled, frame-locals are used. Otherwise, it's set
  ;       globally.
  ; - remember margins (only needed if multi-monitor support is disabled)
  (unless darkroom-mode-enable-multi-monitor-support
    (darkroom-remember 'left-margin-width
		       (default-value 'left-margin-width))
    (darkroom-remember 'right-margin-width
		       (default-value 'right-margin-width)))
  ; - set margins
  (cond (darkroom-mode-enable-multi-monitor-support
	 (setq-frame-default 'left-margin-width darkroom-mode-left-margin)
	 (setq-frame-default 'right-margin-width darkroom-mode-right-margin)
	 (frame-local-variables-check t))
	(t
	 (setq-default left-margin-width darkroom-mode-left-margin)
	 (setq-default right-margin-width darkroom-mode-right-margin)))
  (darkroom-mode-update-window)
  
  ; ----- other settings
  ; - remember
  (darkroom-remember 'line-spacing (frame-parameter nil 'line-spacing))
  (when (and  (boundp 'longlines-mode)
	      longlines-mode
	      darkroom-mode-enable-longline-wrap)
    (darkroom-remember 'longlines-wrap-follow
	  longlines-wrap-follows-window-size))
  ; - set
  (modify-frame-parameters (selected-frame)
			   '((line-spacing . 1)))
  (when (and 
	 (boundp 'longlines-mode)
	 longlines-mode
	 darkroom-mode-enable-longline-wrap)
    (longlines-mode 0)
    (setq longlines-wrap-follows-window-size t)
    (longlines-mode 1))
  
  ; ---- frame size
  ; - remember
  (darkroom-remember 'frame-width (frame-parameter nil 'width))
  (darkroom-remember 'frame-height (frame-parameter nil 'height))
  (darkroom-remember 'frame-left (frame-parameter nil 'left))
  (darkroom-remember 'frame-top (frame-parameter nil 'top))
  ; - set
  (if (eq window-system 'w32)
      (w32-fullscreen-on)
    (set-frame-parameter nil 'fullscreen 'fullboth))

  (run-hooks 'darkroom-mode-enable-hook)
  (darkroom-mode-set-enabled t)
  (message (format "darkroom mode enabled on %s" (selected-frame))))

(defun darkroom-mode-disable()
  (interactive)
  (run-hooks 'darkroom-mode-disable-hook)

  ; - restore settings
  (modify-frame-parameters
   (selected-frame)
   `((line-spacing . ,(darkroom-recall 'line-spacing))))
  (when (and
	 (boundp 'longlines-mode)
	 longlines-mode
	 (darkroom-recall 'longlines-wrap-follow)
	 darkroom-mode-enable-longline-wrap)
    (longlines-mode 0)
    (setq longlines-wrap-follows-window-size
	  (darkroom-recall 'longlines-wrap-follow))
    (longlines-mode 1))
  ; - restore margins
  (cond (darkroom-mode-enable-multi-monitor-support
	 (unset-frame-default 'left-margin-width)
	 (unset-frame-default 'right-margin-width)
	 (frame-local-variables-check t))
	(t
	 (setq-default left-margin-width
		       (darkroom-recall 'left-margin-width))
	 (setq-default right-margin-width
		       (darkroom-recall 'right-margin-width))))
  (darkroom-mode-update-window)
  ; - restore frame size	 
  (if (eq window-system 'w32) 
      (w32-fullscreen-off)
    (set-frame-parameter nil 'fullscreen nil))
  (darkroom-mode-recall-frame-size)
  (darkroom-mode-set-enabled nil)
  (message (format "darkroom-mode disabled on %s" (selected-frame)))
  ; for some reason frame size needs to be recalled again ...
  (sleep-for 0.05)
  (darkroom-mode-recall-frame-size))

(defun darkroom-mode-recall-frame-size()
  (modify-frame-parameters (selected-frame)
			   `((left . ,(darkroom-recall 'frame-left))
			     (top . ,(darkroom-recall 'frame-top))
			     (width . ,(darkroom-recall 'frame-width))
			     (height . ,(darkroom-recall 'frame-height)))))

;;;;;;;;;;;; small margins darkroom ;;;
;;;###autoload
(defun darkroom-mode-small()
  (interactive)
  (let ((darkroom-mode-left-margin 1)
	(darkroom-mode-right-margin 1))
    (darkroom-mode)))

;;;###autoload
(defun darkroom-mode-ecb()
  (interactive)
  (let ((darkroom-mode-left-margin 10)
	(darkroom-mode-right-margin 1))
    (darkroom-mode)))

;;;;;;;;;;;;;;;;; end ;;;;;;;;;;;;;;;;;
(provide 'darkroom-mode)