#!/bin/bash

if [ -x /Users/pengpengxp/Applications/Emacs24.5.app/Contents/MacOS/Emacs  ]; 
then
    EMACS= /Users/pengpengxp/Applications/Emacs24.5.app/Contents/MacOS/Emacs 
else
    EMACS=emacs
fi

$EMACS -batch -no-site-file -Q --eval '(setq standard-indent 2)' --eval '(setq-default indent-tabs-mode nil)' --eval '(load-file "web-mode.el")' --eval '(web-mode)' -f web-mode-test

