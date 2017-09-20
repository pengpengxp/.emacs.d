;;; rg-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "rg" "rg.el" (22977 55688 778495 466000))
;;; Generated autoloads from rg.el

(autoload 'rg-define-toggle "rg" "\
Define a command line flag that can be toggled from the rg result
buffer.

This will create a function with prefix 'rg-custom-toggle-flag-'
concatenated with the FLAG name, stripped of any leading dashes.  Flag
must be a form that will be evaluated to a string at macro expansion
time.  For instance, if FLAG is '--invert-match' the function name
will be 'rg-custom-toggle-flag-invert-match.  If the flag contains a
value that will be excluded from the function name.

Optional KEY is a key binding that is added to `rg-mode-map'.  If the
optional DEFAULT parameter is non nil the flag will be enabled by default.

\(fn FLAG &optional KEY DEFAULT)" nil t)

(autoload 'rg-project "rg" "\
Run ripgrep in current project.  The project root will will be
determined by either common project packages like projectile and
find-file-in-project or the source version control system.

\(fn)" t nil)

(autoload 'rg-dwim "rg" "\
Run rg without user interaction figuring out the user's intention by
magic(!).  The default magic searches for thing at point in files matching
current file under project root directory.

With \\[universal-argument] prefix, search is done in current dir
instead of project root.

\(fn)" t nil)

(autoload 'rg "rg" "\
Run ripgrep, searching for REGEXP in FILES in directory DIR.
The search is limited to file names matching shell pattern FILES.
FILES may use abbreviations defined in `rg-custom-type-aliases' or
ripgrep builtin type aliases, e.g.  entering `elisp' is equivalent to `*.el'.

With \\[universal-argument] prefix, you can edit the constructed shell command line
before it is executed.
With two \\[universal-argument] prefixes, directly edit and run `rg-command'.

Collect output in a buffer.  While ripgrep runs asynchronously, you
can use \\[next-error] (M-x next-error), or \\<grep-mode-map>\\[compile-goto-error] in the grep output buffer,
to go to the lines where grep found matches.

This command use the setting of `case-fold-search' variable to decide
whether to do a case sensitive search or not.  If the search regexp
contains uppercase characters the setting is overridden and case
sensitive search is performed.

This command shares argument histories with \\[rgrep] and \\[grep].

\(fn REGEXP &optional FILES DIR CONFIRM)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; rg-autoloads.el ends here
