(defun peng-w3m-to-kindle ()
  (interactive)
  (let* ((file-name (replace-regexp-in-string "[^[:alnum:]_-]" "_"
                                              (buffer-name)))
         (temp-path (concat "/tmp/"
                            file-name
                            ".txt"))
         (dst-path "/media/pengpengxp/Kindle/documents/")
         (command (concat "cp -rf "
                          temp-path
                          " "
                          dst-path)))
    (write-file temp-path)
    (shell-command command)
    (find-file (concat dst-path
                       file-name
                       ".txt"))
    ))
