;;; ace-pinyin-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "ace-pinyin" "ace-pinyin.el" (21812 22655 0
;;;;;;  0))
;;; Generated autoloads from ace-pinyin.el

(autoload 'ace-pinyin-jump-word "ace-pinyin" "\
Jump to Chinese word.
If ARG is non-nil, read input from Minibuffer.

\(fn ARG)" t nil)

(autoload 'ace-pinyin-dwim "ace-pinyin" "\
With PREFIX, only search Chinese.
Without PREFIX, search both Chinese and English.

\(fn &optional PREFIX)" t nil)

(autoload 'ace-pinyin-mode "ace-pinyin" "\
Toggle `ace-pinyin-mode'

If turned on, `ace-jump-char-mode' will be replaced with
`ace-pinyin-jump-char', which is able to jump to Chinese and
English characters

\(fn &optional ARG)" t nil)

(defvar ace-pinyin-global-mode nil "\
Non-nil if Ace-Pinyin-Global mode is enabled.
See the command `ace-pinyin-global-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `ace-pinyin-global-mode'.")

(custom-autoload 'ace-pinyin-global-mode "ace-pinyin" nil)

(autoload 'ace-pinyin-global-mode "ace-pinyin" "\
Toggle Ace-Pinyin mode in all buffers.
With prefix ARG, enable Ace-Pinyin-Global mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Ace-Pinyin mode is enabled in all buffers where
`(lambda nil (ace-pinyin-mode 1))' would do it.
See `ace-pinyin-mode' for more information on Ace-Pinyin mode.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ace-pinyin-autoloads.el ends here
