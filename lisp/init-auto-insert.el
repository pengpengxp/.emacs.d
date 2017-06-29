;;; init-auto-insert.el --- 
;; 
;; Filename: init-auto-insert.el
;; Description: 
;; Author: pengpengxp
;; Email: pengpengxppri@gmail.com
;; Created: 六 12月 20 11:37:54 2014 (+0800)
;; Version: 
;; Last-Updated: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:


(define-auto-insert 'sh-mode '(nil "#!/bin/bash
"))

(define-auto-insert 'ruby-mode '(nil "#!/usr/local/bin/ruby
"))

(define-auto-insert 'python-mode '(nil "#!/usr/local/bin/python
"))



(define-auto-insert 'enh-ruby-mode '(nil "#!/usr/local/bin/ruby
"))

(define-auto-insert 'emacs-lisp-mode '(nil ""))	;默认的设置有问题，我不让它输入任何东西了


(define-auto-insert 'org-mode '(nil "# -*- word-wrap: nil; -*-
#+OPTIONS: ^:{}
#+STARTUP: align
#+STARTUP: showall
#+OPTIONS: toc:nil 
"))

(define-auto-insert 'c-mode '(nil "#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int args,char *argv[])
{

}"))

;; (add-hook 'find-file-hook 'auto-insert)
(auto-insert-mode 1)

;; 不要每次都问我是否需要添加
(setq auto-insert-query nil)

(provide 'init-auto-insert)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-auto-insert.el ends here
