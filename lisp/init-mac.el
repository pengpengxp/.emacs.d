
(defun peng-use-mac-original-keyboard ()
  "这样使用苹果原生的键盘比较符和我的习惯"
  (interactive)
  (setq mac-command-modifier 'control)
  (setq mac-right-command-modifier 'meta)
  (setq mac-right-option-modifier 'control)
  (setq mac-control-modifier 'control)
  (setq mac-right-control-modifier 'control)
  )

(defun peng-use-filco-keyboard ()
  "这样使用`filco'键盘时符合我的按键习惯。"
  (interactive)
  (setq mac-command-modifier 'control)
  (setq mac-right-command-modifier 'control)
  (setq mac-right-option-modifier 'meta)
  (setq mac-control-modifier 'control)
  )

(peng-use-mac-original-keyboard)

(provide 'init-mac.el)

