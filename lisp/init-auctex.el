;;; init-auctex.el --- 
;; 
;; Filename: init-auctex.el
;; Description: 
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 六 12月 27 17:11:45 2014 (+0800)
;; Version: 
;; Last-Updated: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:


;;;; use the auctex
;;;; WATCH OUT:you must have installed the texlive
;;; when you install,you need to make and make install
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)

;;;;use xelatex to compile latex file

(require 'tex)
(require 'out-xtra)
(require 'outline-magic)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; peng-bib是默认的
;;;
;;; peng-bib-inter可以修改
;;; 
;;; 为了这个东西，我重新编译了auctex。之前都是默认安装到
;;; /usr/local/share/emacs/site-lisp，但是我在emacs中找不到一些函数，最
;;; 后，重新编译到~/.emacs.d/site-lisp/auctex/下面，就什么都能找到了。
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'TeX-expand-list '("%b" (lambda nil
				       (file-name-base))))
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (add-to-list 'TeX-command-list '("peng-bib-inter"
					     "rm -f %b.aux %b.toc %b.log %b.pdf %b.bbl %b.blg %b.toc;\
xelatex %t;bibtex %b.aux;xelatex %t;open %b.pdf" 
					     TeX-run-compile t t))
	    (add-to-list 'TeX-command-list '("peng-bib" "rm -f %b.aux %b.toc %b.log %b.pdf %b.bbl %b.blg %b.toc;\
xelatex %t;bibtex %b.aux;xelatex %t;open %b.pdf" 
					     TeX-run-compile nil t))
	    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-compile nil t))
	    (setq TeX-command-default "XeLaTeX")
	    (company-mode-on)
	    ;; (autopair-on)
	    (local-set-key (kbd "M-q") 'fill-paragraph)
	    (reftex-mode)
	    (auto-fill-mode -1)
	    (TeX-PDF-mode 1)
	    (outline-minor-mode)
	    (setq TeX-engine 'xetex)
	    (visual-line-mode 1)

	    (define-key evil-visual-state-local-map (kbd "j") 'next-line)
	    (define-key evil-visual-state-local-map (kbd "<down>") 'next-line)
	    (define-key evil-visual-state-local-map (kbd "k") 'previous-line)
	    (define-key evil-visual-state-local-map (kbd "<up>") 'previous-line)

	    (define-key evil-normal-state-local-map (kbd "j") 'next-line)
	    (define-key evil-normal-state-local-map (kbd "<down>") 'next-line)
	    (define-key evil-normal-state-local-map (kbd "C-n") 'next-line)
	    (define-key evil-normal-state-local-map (kbd "l") 'forward-char)
	    (define-key evil-normal-state-local-map (kbd "h") 'backward-char)
	    (define-key evil-normal-state-local-map (kbd "k") 'previous-line)
	    (define-key evil-normal-state-local-map (kbd "<up>") 'previous-line)
	    (define-key evil-normal-state-local-map (kbd "C-p") 'previous-line)

	    ;; for use of outline mode
	    (peng-local-set-key (kbd "C-c C-n") 'outline-next-heading)
	    (peng-local-set-key (kbd "C-c C-p") 'outline-previous-heading)
	    (peng-local-set-key (kbd "<backtab>") 'outline-hide-other)
	    (peng-local-set-key (kbd "C-c C-u") 'outline-backward-same-level)
	    (peng-local-set-key (kbd "C-c C-d") 'outline-forward-same-level)
	    (peng-local-set-key (kbd "C-c C-a") 'show-all)
	    (peng-local-set-key (kbd "<M-down>") 'outline-move-subtree-down)
	    (peng-local-set-key (kbd "<M-up>") 'outline-move-subtree-up)
	    
	    (hl-line-mode -1)
            (auto-insert-mode -1)
	    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; the keybinding
(add-hook 'LaTeX-mode-hook
	  '(lambda ()
	     ;; compile the plain tex file
	    (define-key evil-normal-state-local-map (kbd "SPC v") '(lambda ()
								     (interactive)
								     (let* ((basefile (file-name-base)))
								       (compile (concat "tex "
											(concat basefile ".tex")
											" '\\end'"
											";xdvi "
											(concat basefile ".dvi")
											))
								       )))
	    ;; only use xelatex once
	    (define-key evil-normal-state-local-map (kbd "SPC o")
	      '(lambda ()
		 (interactive)
		 (let* ((tempfile (file-name-base)))
		   (progn
		     (shell-command (concat  "rm -rf " tempfile ".bbl " tempfile ".blg " 
					     tempfile ".out " tempfile ".log " tempfile ".aux " 
					     tempfile ".toc" tempfile ".pdf"))
		     (compile (concat "xelatex "
				      (concat tempfile ".tex")
				      (concat  ";rm -rf " tempfile ".bbl " tempfile ".blg " 
					       tempfile ".out " tempfile ".log " tempfile ".aux " 
					       tempfile ".toc" ";open " tempfile ".pdf")))
		     ))))
	    ;; use xelatex,bibtex,xelatex for some bibliography
	    (define-key evil-normal-state-local-map (kbd "SPC b")
	      '(lambda ()
		 (interactive)
		 (let* ((tempfile (file-name-base)))
		   (progn
		     (shell-command (concat  "rm -rf " tempfile ".bbl " tempfile ".blg " 
					     tempfile ".out " tempfile ".log " tempfile ".aux " 
					     tempfile ".toc" tempfile ".pdf"))
		     (compile (concat "xelatex "
				      (concat tempfile ".tex")
				      (concat ";bibtex " tempfile ".aux")
				      (concat ";xelatex " tempfile ".tex")
				      (concat ";xelatex " tempfile ".tex")
				      (concat  ";rm -rf " tempfile ".bbl " tempfile ".blg " 
					       tempfile ".out " tempfile ".log " tempfile ".aux " 
					       tempfile ".toc" ";open " tempfile ".pdf")))
		     ))))
	    ))
(add-hook 'LaTeX-mode-hook '(lambda ()
			      (interactive)
			      (peng-local-set-key (kbd "<f8> v") 'peng-compile-current-file-as-plain-tex)
			      (define-key evil-normal-state-local-map (kbd "SPC v") 'peng-compile-current-file-as-plain-tex)
			      (peng-local-set-key (kbd "<f8> l") 'peng-compile-current-latex-file-to-pdf)
			      ;; compile three times using xelatex
			      (define-key evil-normal-state-local-map (kbd "SPC l") 'peng-compile-current-latex-file-to-pdf)
			      ;; command master for multi-choise
			      (define-key evil-normal-state-local-map (kbd "SPC m") 'TeX-command-master)
			      ;; the viewer
			      (define-key evil-normal-state-local-map (kbd "SPC cv") 'TeX-view)
			      (peng-local-set-key (kbd "C-x ns") 'peng-latex-narrow-section)
			      (peng-local-set-key (kbd "C-x ne") 'peng-latex-narrow-environment)

			      ;; for use of the outline-minor-mode
			      (define-key evil-normal-state-local-map (kbd "<tab>") 'outline-cycle)
			      (define-key evil-normal-state-local-map (kbd "TAB") 'outline-cycle)

			      ;; (define-key evil-insert-state-local-map (kbd "<tab>") 'LaTeX-indent-line)
			      ;; (define-key evil-insert-state-local-map (kbd "TAB") 'LaTeX-indent-line)

			      (peng-local-set-key (kbd "C-c C-v") 'compile)
			      ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; anther settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist
      (append
       ;; the original tex-mode can't be use
       '(("\\.tex\\'". latex-mode))
       auto-mode-alist))

(setq TeX-electric-escape t)		; bind TeX-insert-macro to
					; `\', it is very convenient

;;; 不这样设置，使用TeX-insert-macro选\usepacke之后不能自动补全。查看
;;; exec-path文挡说这是什么for subprocess。注：不设置这个，emacs从命令
;;; 行启动是可以使用的。应该就是一些变量的问题。
(setq exec-path (append exec-path '("/usr/local/texlive/2013/bin/i386-linux")))

(setq TeX-auto-save t) ; Enable parse on save.

;; Automatically remove all tabs from a file before saving it. And use
;; space to instead it.
(setq TeX-auto-untabify t)



;;    The following example add `\item' and `\bibliography' headers, with
;; `\bibliography' at the same outline level as `\section', and `\item'
;; being below `\subparagraph'.
;; (setq TeX-outline-extra
;;       '(("[ \t]*\\\\\\(bib\\)?item\\b" 7)
;;      	("\\\\bibliography\\b" 2)))


(setq-default TeX-master nil) ; Query for master file.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; my personal function in latex-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun peng-latex-narrow-section ()
  "narrow to current section

inspired from the org-narrow-to-subtree"
  (interactive)
  (LaTeX-mark-section)
  (narrow-to-region (region-beginning)
		    (region-end))
  (keyboard-quit))

(defun peng-latex-narrow-environment ()
  "narrow to current environment

inspired from the org-narrow-to-subtree"
  (interactive)
  (LaTeX-mark-environment)
  (narrow-to-region (region-beginning)
		    (region-end))
  (keyboard-quit))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; personal function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun peng-compile-current-latex-file-to-pdf ()
  "把当前的buffer当做latax源文件来编译了

默认的是调用三次xelatex，然后删除中间文件如果有其它需要，请直接使
用命令行来完成"
  (interactive)
  (let ((tempfile (file-name-base))
	(temppro "xelatex"))
    (shell-command (concat  "rm -rf " tempfile ".bbl " tempfile ".blg " 
			    tempfile ".out " tempfile ".log " tempfile ".aux " 
			    tempfile ".toc" tempfile ".pdf"))
    (compile (concat "xelatex "
		     (concat tempfile ".tex")
		     ";xelatex "
		     (concat tempfile ".tex")
		     ";xelatex "
		     (concat tempfile ".tex")
		     (concat  ";rm -rf " tempfile ".bbl " tempfile ".blg " 
			      tempfile ".out " tempfile ".log " tempfile ".aux " 
			      tempfile ".toc" ";open " tempfile ".pdf")))))



;;; use cdlatedx
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode

;; (setq auto-mode-alist
;;       (append
;;        ;;File name ends in '.cu'
;;        '(
;; 	 ("\\.tex\\'". LaTeX-mode)
;; 	 ("\\.drv\\'". LaTeX-mode)
;; 	 ("\\.ltx\\'". LaTeX-mode)
;; 	 ("\\.sty\\'" . LaTeX-mode)
;; 	 ("\\.cl[so]\\'" . LaTeX-mode)
;; 	 ("\\.bbl\\'" . LaTeX-mode)
;; 	 )
;;        auto-mode-alist))

(provide 'init-auctex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-auctex.el ends here
