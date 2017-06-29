(require 'ipcalc)

(defun peng-ipcalc ()
  "calculate ip address interactively"
  (interactive)
  (let ((argu (read-from-minibuffer "Please input ip addr:(192.168.56.2/24)")))
    (ipcalc argu)))

(provide 'init-calculater)
