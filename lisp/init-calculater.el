(defun peng-ipcalc ()
  (require 'ipcalc)
  "calculate ip address interactively"
  (interactive)
  (let ((argu (read-from-minibuffer "Please input ip addr:(192.168.56.2/24)")))
    (ipcalc argu)))

(add-hook 'calc-mode-hook 'peng-ipcalc)

(provide 'init-calculater)
