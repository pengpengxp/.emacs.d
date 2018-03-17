(defun peng-cdyq-compile-funciton (x)
  (interactive "P")

  (let* (
         (project-dir "/home/pengpengxp/src/fhos")
         (arm-env (concat "source " project-dir "/fsl_env"))
         (sai-dir (concat project-dir "/sai"))
         (rpc-dir (concat project-dir "/rpc"))
         (l2-dir (concat project-dir "/l2"))
         (l2d-dir (concat project-dir "/l2/l2d"))
         (igmpd-dir (concat project-dir "/l2/igmpd"))
         (fhos-common-dir (concat project-dir "/common"))
         (arm-build-dir (concat project-dir "/build/freescale/arm"))
         (x86-build-dir (concat project-dir "/build/freescale/x86"))
         
         (make-command "make clean && bear make -j8 BUILD=debug")

         (arch (if (not x)
                   "arm"
                 (ivy-read "Arch: " (list "arm" "x86"))))
         
         (my-action (ivy-read "Action: " (list
                                          "l2d"
                                          "igmpd"
                                          "l2"
                                          "sai"
                                          "rpc"
                                          "fhos-common"
                                          )))

         (default-directory
          (cond 
           ((equal my-action "l2d") l2d-dir)
           ((equal my-action "igmpd") igmpd-dir)
           ((equal my-action "l2") l2-dir)
           ((equal my-action "sai") l2d-dir)
           ((equal my-action "rpc") rpc-dir)
           ((equal my-action "fhos-common") fhos-common-dir)
           ))
         )
    (let ((my-command (if (equal "arm" arch)
                          (concat arm-env " && " make-command)
                        make-command)))
      (progn
        (compile my-command)
        (switch-to-buffer-other-window "*compilation*")))))



(provide 'init-cdyq)
