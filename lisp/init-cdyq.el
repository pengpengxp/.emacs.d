(defun peng-cdyq-compile-funciton (x)
  (interactive "P")

  (let* (
         (project-dir "/home/pengpengxp/src/fhos")
         (arm-env (concat "source " project-dir "/env/fsl_env"))
         (sai-dir (concat project-dir "/sai"))
         (rpc-dir (concat project-dir "/rpc"))
         (l2-dir (concat project-dir "/l2"))
         (core-dir (concat project-dir "/core"))
         (l2d-dir (concat project-dir "/l2/l2d"))
         (bcm-dir (concat project-dir "/hal/switch/bcm"))
         (igmpd-dir (concat project-dir "/l2/igmpd"))
         (fhos-common-dir (concat project-dir "/common"))
         (arm-build-dir (concat project-dir "/build/freescale/arm"))
         (x86-build-dir (concat project-dir "/build/freescale/x86"))
         
         (make-command "make clean && bear make -j8 BUILD=debug")

         (arch (if (not x)
                   "arm"
                 "x86"))
         
         (my-action (ivy-read "Action: " (list
                                          "igmpd"
                                          "l2d"
                                          "l2"
                                          "sai"
                                          "rpc"
                                          "fhos-common"
                                          "bcm"
                                          "core"
                                          )))

         (default-directory
          (cond 
           ((equal my-action "l2d") l2d-dir)
           ((equal my-action "igmpd") igmpd-dir)
           ((equal my-action "l2") l2-dir)
           ((equal my-action "sai") sai-dir)
           ((equal my-action "rpc") rpc-dir)
           ((equal my-action "fhos-common") fhos-common-dir)
           ((equal my-action "bcm") bcm-dir)
           ((equal my-action "core") core-dir)
           ))
         )
    (let ((my-command (if (equal "arm" arch)
                          (concat arm-env " && " make-command)
                        make-command)))
      (progn
        (compile my-command)
        (switch-to-buffer-other-window "*compilation*")))))

(defun peng-delete-trailing-space-and-untabify ()
  "delete all trailing space and untabify in current buffer."
  (interactive)
  (save-restriction
    (progn
      (delete-trailing-whitespace (point-min) (point-max))
      (untabify (point-min) (point-max))
      (save-buffer)
      )))

(provide 'init-cdyq)
