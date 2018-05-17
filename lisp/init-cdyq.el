(defvar cdyq-arch nil)
(defvar cdyq-build nil)

(defun peng-cdyq-compile-funciton (x)
  (interactive "P")

  (let* (
         (project-dir "/home/pengpengxp/src/fhos")
         (freescale-string "freescale")
         (broadcom-string "broadcom")
         (x86-string "x86")
         (freescale-env (concat "source " project-dir "/env/fsl_env"))
         (broadcom-env (concat "source " project-dir "/env/bcm_env"))
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

         (release-build "release")
         (debug-build "debug")

         (build (if (not x)
                    (if cdyq-build
                        cdyq-build
                      release-build)
                  (ivy-read "Which build :"
                            (list release-build
                                  debug-build))))

         (make-command (concat "make clean && bear make -j8 BUILD="
                               build))

         (arch (if (not x)
                   (if cdyq-arch
                       cdyq-arch
                     freescale-string)
                 (ivy-read "Which ARCH :" (list freescale-string
                                                broadcom-string
                                                x86-string))))
         (my-action (ivy-read (concat "Compile ARCH="
                                      arch
                                      " BUILD="
                                      build
                                      " Action: ") (list
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
    (let ((my-command (cond
                       ((equal freescale-string arch)
                        (concat freescale-env " && " make-command))

                       ((equal broadcom-string arch)
                        (concat broadcom-env " && " make-command))

                       (t make-command))))
      (progn
        (setq cdyq-arch arch)
        (setq cdyq-build build)
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

(defun peng-switch-all-tmux-window ()
  (interactive)

  (let* ((line (ivy-read "Please choose a terminal to switch: " (split-string (shell-command-to-string "tmux list-windows -a") "\n")))
         (session-name (car (split-string line ":")))
         (window-index (cadr (split-string line ":")))
         (command (concat "wmctrl -xR lilyterm.Lilyterm && "
                          "tmux switchc -t "
                          session-name
                          " && tmux select-window -t "
                          session-name
                          ":"
                          window-index)))
    (shell-command command)))

(defun peng-switch-all-tmux-window ()
  (interactive)
  (let* ((tmux-list-command "tmux list-windows -a -F '#{session_name}:#{window_index}: #{window_name} #{pane_current_path} pane:#{window_panes}'")
         (line (ivy-read "Please choose a terminal to switch: "
                         (split-string (shell-command-to-string
                                        tmux-list-command) "\n")))
         (session-name (car (split-string line ":")))
         (window-index (cadr (split-string line ":")))
         (command (concat "wmctrl -xR lilyterm.Lilyterm && "
                          "tmux switchc -t "
                          session-name
                          " && tmux select-window -t "
                          session-name
                          ":"
                          window-index)))
    (shell-command command)))

(provide 'init-cdyq)
