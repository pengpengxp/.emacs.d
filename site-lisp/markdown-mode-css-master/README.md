# markdown-mode-css

[markdown-mode.el](http://jblevins.org/projects/markdown-mode/) is pretty cool, but I wanted CSS-themed output like you get with [Mou.app](http://mouapp.com/). Themes built from [markdown-css](https://github.com/rhiokim/markdown-css).

### Installation

* Drop `markdown-mode.el` into your `site-lisp` dir
* Place the files in `css` dir somewhere
* Add something similar to the following to your `~/.emacs` file:

		;; Markdown mode
		(autoload 'markdown-mode "markdown-mode"
		"Major mode for editing Markdown files" t)
		(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
		(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
		(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
		(setq markdown-command "/usr/local/bin/markdown")
		(setq markdown-css-dir "~/.emacs.d/markdown-css/")
		(setq markdown-css-theme "clearness")

#### Themes

* Clearness
* Clearness Dark
* Github
* Github Rhio
* Haroopad
* Node-Dark
* Solarized Light
* Solarized Dark
