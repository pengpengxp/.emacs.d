    ;;; integrate ido with artist-mode
(defun artist-ido-select-operation (type)
  "Use ido to select a drawing operation in artist-mode"
  (interactive (list (ido-completing-read "Drawing operation: " 
                                          (list "Pen" "Pen Line" "line" "straight line" "rectangle" 
                                                "square" "poly-line" "straight poly-line" "ellipse" 
                                                "circle" "text see-thru" "text-overwrite" "spray-can" 
                                                "erase char" "erase rectangle" "vaporize line" "vaporize lines" 
                                                "cut rectangle" "cut square" "copy rectangle" "copy square" 
                                                "paste" "flood-fill"))))
  (artist-select-operation type))
(defun artist-ido-select-settings (type)
  "Use ido to select a setting to change in artist-mode"
  (interactive (list (ido-completing-read "Setting: " 
                                          (list "Set Fill" "Set Line" "Set Erase" "Spray-size" "Spray-chars" 
                                                "Rubber-banding" "Trimming" "Borders"))))
  (if (equal type "Spray-size") 
      (artist-select-operation "spray set size")
    (call-interactively (artist-fc-get-fn-from-symbol 
                         (cdr (assoc type '(("Set Fill" . set-fill)
                                            ("Set Line" . set-line)
                                            ("Set Erase" . set-erase)
                                            ("Rubber-banding" . rubber-band)
                                            ("Trimming" . trimming)
                                            ("Borders" . borders)
                                            ("Spray-chars" . spray-chars))))))))

(defhydra hydra-artist-mode-menu (:exit t
                                        :columns 3)
  "
     Artist Mode: Are you a artist?

"
  ("V" artist-select-op-vaporize-lines "artist-select-op-vaporize-lines")
  ("v" artist-select-op-vaporize-line "artist-select-op-vaporize-line")
  ("E" artist-select-op-erase-rectangle "artist-select-op-erase-rectangle")
  ("z" artist-select-op-spray-set-size "artist-select-op-spray-set-size")
  ("S" artist-select-op-spray-can "artist-select-op-spray-can")
  ("T" artist-select-op-text-overwrite "artist-select-op-text-overwrite")
  ("t" artist-select-op-text-see-thru "artist-select-op-text-see-thru")
  ("c" artist-select-op-circle "artist-select-op-circle")
  ("e" artist-select-op-ellipse "artist-select-op-ellipse")
  ("P" artist-select-op-straight-poly-line "artist-select-op-straight-poly-line")
  ("p" artist-select-op-poly-line "artist-select-op-poly-line")
  ("s" artist-select-op-square "artist-select-op-square")
  ("R" artist-select-op-square "artist-select-op-square")
  ("r" artist-select-op-rectangle "rectangle")
  ("M-w" artist-select-op-copy-rectangle "Copy rectangle")
  ("C-y" artist-select-op-paste "paste")
  ("L" artist-select-op-straight-line "artist-select-op-straight-line")
  ("l" artist-select-op-line "line")
)


(add-hook 'artist-mode-init-hook 
          (lambda ()
            (define-key artist-mode-map (kbd "C-c C-a C-o") 'artist-ido-select-operation)
            (define-key artist-mode-map (kbd "C-c C-a C-c") 'artist-ido-select-settings)
            ))

(add-hook 'artist-mode-hook 
          (lambda ()
            (define-key artist-mode-map (kbd "C-c C-a") 'hydra-artist-mode-menu/body)
            (define-key artist-mode-map (kbd "C-j") 'electric-newline-and-maybe-indent)
            
            (define-key evil-emacs-state-local-map (kbd "C-c C-a") 'hydra-artist-mode-menu/body)
            (define-key evil-emacs-state-local-map (kbd "C-j") 'electric-newline-and-maybe-indent)
            (evil-emacs-state)))


(provide 'init-artist-mode)
