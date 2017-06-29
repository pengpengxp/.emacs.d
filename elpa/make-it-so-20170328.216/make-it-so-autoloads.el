;;; make-it-so-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "make-it-so" "make-it-so.el" (22831 51469 0
;;;;;;  0))
;;; Generated autoloads from make-it-so.el

(autoload 'mis-mode "make-it-so" "\
Add make-it-so key bindings to `dired-mode'.

\\{mis-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'mis-makefile-mode "make-it-so" "\
Add make-it-so key bindings to `makefile-mode'

\\{mis-makefile-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'mis-config-default "make-it-so" "\
Easy config.

\(fn)" nil nil)

(autoload 'mis-browse "make-it-so" "\
List all available recipes.
Jump to the Makefile of the selected recipe.

\(fn)" t nil)

(autoload 'make-it-so "make-it-so" "\
When called from `dired', offer a list of transformations.
Available trasformations are dispatched on currently selected
file(s)' extension.  Therefore it's an error when files with
multiple extensions are marked.  After an action is selected,
proceed to call `mis-action' for that action.

\(fn ARG)" t nil)

(autoload 'mis-abort "make-it-so" "\
Abort tranformation.
This function should revert to the state before `mis-action' was called.

\(fn)" t nil)

(autoload 'mis-finalize "make-it-so" "\
Finalize transformation.
In addition to `mis-abort' copy over the files listed in
\"provide\".  Each Makefile should append all essential files
that it creates to a \"provide\" file.  All generated files not in \"provide\",
i.e. intermediates and logs and such, will be deleted.

\(fn)" t nil)

(autoload 'mis-replace "make-it-so" "\
Finalize transformation.
In addition to `mis-finalize' move source files to trash.

\(fn)" t nil)

(autoload 'mis-dispatch "make-it-so" "\
Choose \"mis-\" via completion.

\(fn)" t nil)

(autoload 'mis-save-and-compile "make-it-so" "\
Save current buffer and call `compile' with `mis-make-command'.
Switch to other window afterwards.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("make-it-so-pkg.el") (22831 51469 339783
;;;;;;  0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; make-it-so-autoloads.el ends here
