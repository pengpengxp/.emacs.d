;;;the set for cuda .cu file
(setq auto-mode-alist
      (append
       ;;File name ends in '.cu'
       '(("\\.cu\\'". c-mode))
       auto-mode-alist))

(provide 'init-cuda)
