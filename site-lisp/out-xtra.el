;;; out-xtra.el --- Extra support for outline minor mode.

;; Copyright (C) 1993, 1994 Per Abrahamsen.
;; Copyright abandoned.  This file is donated to the public domain.

;; Author: Per Abrahamsen <abraham@iesd.auc.dk>
;; Version: $Id: out-xtra.el,v 5.6 1994/01/30 21:17:04 amanda Exp $
;; Bogus-Bureaucratic-Cruft: How 'bout ESR and the LCD people agreed
;; 	on a common format?

;; LCD Archive Entry:
;; out-xtra|Per Abrahamsen|abraham@iesd.auc.dk|
;; Extra support for outline minor mode|
;; 01-30-1994|5.6|~/misc/out-xtra.el.Z|

;;; Commentary:

;; This file provides some nice extra features for outline minor mode. 
;;
;; - Change default minor mode key prefix to `C-c C-o'.
;; - Complete keybindings and menu support.
;; - Add command to show top level headers.
;; - Add command to hide all other entries than the one containing point.
;; - Add support nroff (mm), emacs lisp, HTML, C, and C++ major modes.
;;
;; If you have hooks for support for other major modes, please send
;; them to me.

;; `out-xtra.el' works with:
;; - FSF Emacs 19.19
;; - Lucid Emacs 19.8 with outln-18.el
;; - Emacs 18 with outln-18.el

;; Get `powerkey.el' if you want keyboard shortcuts to appear in the
;; menu for FSF Emacs 19 (very nice).

;; Get AUC TeX if you want support for LaTeX and TeXinfo files (also
;; nice :-).

;; There are more outline extensions in the `foldout.el' package.

;; Insert 
;;   (require 'out-xtra)
;; in your .emacs file to install.  If you want a different prefix
;; key, insert first 
;;   (defvar outline-minor-mode-prefix "\C-c")
;; or whatever.  The prefix can only be changed before outline (minor)
;; mode is loaded.

;;; ChangeLog:

;; * 1994-01-30	Per Abrahamsen
;;	Lucid menu support.
;; * 1994-01-28		Per Abrahamsen
;;	Added hook for C and C++ mode first posted by Takashi Chikayama
;;	<chik@icot.or.jp> on gnu.emacs.sources.
;; * 1994-01-27         Per Abrahamsen
;;      Fixed bug in changing setting keys.  Reported by David Smith
;;      <maa507@comp.lancs.ac.uk>, who also wrote the original version
;;      of `outline-hide-sublevels'.
;; * 1994-01-27		Per Abrahamsen
;;	Added support for HTML mode.
;; * 1994-01-26		Per Abrahamsen
;;      Don't overwrite buffer local settings.  Suggested by Kevin
;;      Broadey <KevinB@bartley.demon.co.uk>.
;; * 1994-01-25		Per Abrahamsen
;;      New function `outline-hide-other'.  Suggested by Jason D. Lohn
;;      <jlohn@eng.umd.edu> on gnu.emacs.help.
;; * 1993-11-16		Per Abrahamsen
;;      `outline-hide-sublevels' now takes an argument.  Thanks to 
;;      Kevin Broadey <KevinB@bartley.demon.co.uk>.

;;; Code:

(defvar outline-minor-mode-prefix "\C-c\C-o")

;;; Commands
;;
;; Additional outline commands.

(defun outline-hide-sublevels (keep-levels)
  "Hide everything except the first KEEP-LEVEL headers."
  (interactive "p")
  (if (< keep-levels 1)
      (error "Must keep at least one level of headers"))
  (setq keep-levels (1- keep-levels))
  (save-excursion
    (goto-char (point-min))
    (hide-subtree)
    (show-children keep-levels)
    (condition-case err
      (while (outline-get-next-sibling)
	(hide-subtree)
	(show-children keep-levels))
      (error nil))))

(defun outline-hide-other ()
  "Hide everything except for the current body and the parent headings."
  (interactive)
  (outline-hide-sublevels 1)
  (let ((last (point))
	(pos (point)))
    (while (save-excursion
	     (and (re-search-backward "[\n\r]" nil t)
		  (eq (following-char) ?\r)))
      (save-excursion
	(beginning-of-line)
	(if (eq last (point))
	    (progn
	      (outline-next-heading)
	      (outline-flag-region last (point) ?\n))
	  (show-children)
	  (setq last (point)))))))

;;; Keybindings.
;;
;; We provide bindings for all keys.

(if (fboundp 'eval-after-load)
    ;; FSF Emacs 19.
    (eval-after-load "outline"
      '(let ((map (lookup-key outline-minor-mode-map
			      outline-minor-mode-prefix)))
	 (define-key map "\C-t" 'hide-body)
	 (define-key map "\C-a" 'show-all)
	 (define-key map "\C-c" 'hide-entry)
	 (define-key map "\C-e" 'show-entry)
	 (define-key map "\C-l" 'hide-leaves)
	 (define-key map "\C-k" 'show-branches)
	 (define-key map "\C-q" 'outline-hide-sublevels)
	 (define-key map "\C-o" 'outline-hide-other)
	 (define-key outline-minor-mode-map [menu-bar hide hide-sublevels]
	   '("Hide Sublevels" . outline-hide-sublevels))
	 (define-key outline-minor-mode-map [menu-bar hide hide-other]
	   '("Hide Other" . outline-hide-other))
	 (if (fboundp 'update-power-keys)
	     (update-power-keys outline-minor-mode-map))))

  (if (string-match "Lucid" emacs-version)
      (progn				;; Lucid Emacs 19
	(defconst outline-menu
	  '(["Up" outline-up-heading t]
	    ["Next" outline-next-visible-heading t]
	    ["Previous" outline-previous-visible-heading t]
	    ["Next Same Level" outline-forward-same-level t]
	    ["Previous Same Level" outline-backward-same-level t]
	    "---"
	    ["Show All" show-all t]
	    ["Show Entry" show-entry t]
	    ["Show Branches" show-branches t]
	    ["Show Children" show-children t]
	    ["Show Subtree" show-subtree t]
	    "---"
	    ["Hide Leaves" hide-leaves t]
	    ["Hide Body" hide-body t]
	    ["Hide Entry" hide-entry t]
	    ["Hide Subtree" hide-subtree t]
	    ["Hide Other" outline-hide-other t]
	    ["Hide Sublevels" outline-hide-sublevels t]))

	(defun outline-add-menu ()
	  (set-buffer-menubar (copy-sequence current-menubar))
	  (add-menu nil "Outline" outline-menu))

	(add-hook 'outline-minor-mode-hook 'outline-add-menu)
	(add-hook 'outline-mode-hook 'outline-add-menu)
	(add-hook 'outline-minor-mode-off-hook
		    (function (lambda () (delete-menu-item '("Outline")))))))

  ;; Lucid Emacs or Emacs 18.
  (require 'outln-18)
  (let ((map (lookup-key outline-minor-mode-map outline-minor-mode-prefix)))
    ;; Should add a menu here.
    (define-key map "\C-t" 'hide-body)
    (define-key map "\C-a" 'show-all)
    (define-key map "\C-c" 'hide-entry)
    (define-key map "\C-e" 'show-entry)
    (define-key map "\C-l" 'hide-leaves)
    (define-key map "\C-k" 'show-branches)
    (define-key map "\C-q" 'outline-hide-sublevels)
    (define-key map "\C-o" 'outline-hide-other)))

;;; Major Modes
;;
;; Support functions for writing major mode outline hooks.

(defun outline-minor-mode-on ()
  ;; Turn outline minor mode on.
  (outline-minor-mode 1))

(defun outline-local-set-regexp (regexp &optional fun)
  ;; Set `outline-regexp' locally to REGEXP and `outline-level' to FUN.
  ;; Will not set either of these if one of them already have a local value.
  (require 'outline)
  (or (assq 'outline-regexp (buffer-local-variables))
      (assq 'outline-level (buffer-local-variables))
      (progn
	(make-local-variable 'outline-regexp)
	(setq outline-regexp regexp)
	(if (null fun)
	    ()
	  (make-local-variable 'outline-level)
	  (setq outline-level fun)))))
  
;; Supported by AUC TeX.
(add-hook 'TeXinfo-mode-hook 'outline-minor-mode-on)
(add-hook 'LaTeX-mode-hook 'outline-minor-mode-on)

;;; Emacs Lisp
;;
;; The following hook does wonders on files following the commenting
;; conventions described in `lisp-mnt.el' in Emacs 19.
;; 
;; I strongly suggest emacs lisp authors to use the suggestions and
;; conventions from that file.

(add-hook 'emacs-lisp-mode-hook
	  (function (lambda ()
	    (outline-local-set-regexp ";;; \\|(....")
	    (outline-minor-mode 1))))

;;; Nroff
;;
;; Headers as defined by the `mm' macro package.

(defun nroff-outline-level ()
  (save-excursion
    (looking-at outline-regexp)
    (skip-chars-forward ".H ")
    (string-to-int (buffer-substring (point) (+ 1 (point))))))

(add-hook 'nroff-mode-hook
	  (function (lambda () 
	    (outline-local-set-regexp "\\.H[ ]+[1-7]+ " 'nroff-outline-level)
	    (outline-minor-mode 1))))

;;; HTML
;;
;; Assumes HTML authors uses the <Hx> tags for headers, rather than
;; just as requests for a larger font.

(defvar html-outline-regexp
  ;; Regexp used for locating HTML headings.
  "[^\n\m]*<\\([Hh][1-6]\\|[Hh][Tt][Mm][Ll][Pp][Ll][Uu][Ss]\
[Hh][Tt][Mm][Ll]\\|[Bb][Oo][Dd][Yy]\\|[Hh][Ee][Aa][Dd]\\)\\b")

(defun html-outline-level ()
  ;; Calculate the outline level of a HTML heading.
  ;; Assume point at beginning of header line.
  (save-excursion (re-search-forward html-outline-level))
  (let ((tag (buffer-substring (match-beginning 1) (match-end 1))))
    (if (eq (length tag) 2)
	(- (aref tag 1) ?0)
      0)))

(add-hook 'html-mode-hook
	  (function (lambda () 
	    (outline-local-set-regexp html-outline-regexp 'html-outline-level)
	    (outline-minor-mode 1))))

;;; C & C++
;;
;; Based on indention.  Gives somewhat unusual results, but is nice
;; for closing a block and similar operations.

(add-hook 'c-mode-hook
	  (function (lambda ()
	   (outline-local-set-regexp "[^#\n\^M]" 'c-outline-level)
	   (outline-minor-mode 1))))

(add-hook 'c++-mode-hook
	  (function (lambda ()
	   (outline-local-set-regexp "[^#\n\^M]" 'c-outline-level)
	   (outline-minor-mode 1))))

(defun c-outline-level ()
  (save-excursion
    (skip-chars-forward "\t ")
    (current-column)))

(provide 'out-xtra)

;;; out-xtra.el ends here
