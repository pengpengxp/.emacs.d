;;; rg-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "rg" "rg.el" (23036 16509 52345 552000))
;;; Generated autoloads from rg.el

(autoload 'rg-define-toggle "rg" "\
Define a command line flag that can be toggled from the rg result buffer.

This will create a function with prefix 'rg-custom-toggle-flag-'
concatenated with the FLAG name, stripped of any leading dashes.  Flag
must be a form that will be evaluated to a string at macro expansion
time.  For instance, if FLAG is '--invert-match' the function name
will be 'rg-custom-toggle-flag-invert-match.  If the flag contains a
value that will be excluded from the function name.

Optional KEY is a key binding that is added to `rg-mode-map'.  If the
optional DEFAULT parameter is non nil the flag will be enabled by default.

\(fn FLAG &optional KEY DEFAULT)" nil t)

(autoload 'rg-list-searches "rg" "\
List all `rg-mode' buffers in `ibuffer'.

\(fn)" t nil)

(autoload 'rg-enable-default-bindings "rg" "\
Enable the global `rg' default key bindings under PREFIX key. If
prefix is not supplied `rg-keymap-prefix' is used.

\(fn &optional PREFIX)" t nil)

(autoload 'rg-project "rg" "\
Run ripgrep in current project searching for REGEXP in FILES.
The project root will will be determined by either common project
packages like projectile and `find-file-in-project' or the source
version control system.

\(fn REGEXP FILES)" t nil)

(autoload 'rg-dwim "rg" "\
Run ripgrep without user interaction figuring out the intention by magic(!).
The default magic searches for thing at point in files matching
current file under project root directory.

With \\[universal-argument] prefix (CURDIR), search is done in current dir
instead of project root.

\(fn &optional CURDIR)" t nil)

(autoload 'rg "rg" "\
Run ripgrep, searching for REGEXP in FILES in directory DIR.
The search is limited to file names matching shell pattern FILES.
FILES may use abbreviations defined in `rg-custom-type-aliases' or
ripgrep builtin type aliases, e.g.  entering `elisp' is equivalent to `*.el'.

REGEXP is a regexp as defined by the ripgrep executable.

With \\[universal-argument] prefix (CONFIRM), you can edit the
constructed shell command line before it is executed.

Collect output in a buffer.  While ripgrep runs asynchronously, you
can use \\[next-error] (M-x `next-error'), or \\<grep-mode-map>\\[compile-goto-error] in the rg output buffer, to go to the lines where rg found matches.

\(fn REGEXP FILES DIR &optional CONFIRM)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; rg-autoloads.el ends here
