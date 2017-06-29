;; Author : pluskid
;; Modified By : lishuo
;;
;; 调用 stardict 的命令行程序 sdcv 来查辞典
;; 安装: sudo apt-get install stardict
;; sudo apt-get install sdcv
;;
;; 如果选中了 region 就查询 region 的内容，否则查询当前光标所在的单词
;; 查询结果在一个叫做 *sdcv* 的 buffer 里面显示出来，在这个 buffer 里面
;; 按 q 可以把这个 buffer 放到 buffer 列表末尾，按 d 可以查询单词
;; 注意自己编写.el的时候必须加上开头和结尾
(require 'cl)
(defun view-stardict-in-buffer ()
  (interactive)
  (let ((word (if mark-active
		  (buffer-substring-no-properties (region-beginning) (region-end))
		(current-word nil t))))
    (setq word (read-string (format "Search the dictionary for (default %s): " word) nil nil word))
    (set-buffer (get-buffer-create "*sdcv*"))
    (buffer-disable-undo)
    (erase-buffer)
    (let ((process (start-process-shell-command "sdcv" "*sdcv*" "sdcv" "-n" word)))
      (set-process-sentinel
       process
       (lambda (process signal)
	 (when (memq (process-status process) '(exit signal))
	   (unless (string= (buffer-name) "*sdcv*")
	     (setq kid-sdcv-window-configuration (current-window-configuration))
	     (switch-to-buffer-other-window "*sdcv*")
	     (local-set-key (kbd "d") 'view-stardict-in-buffer)

	     (evil-emacs-state nil)
	     ;;用回车来触发
	     (local-set-key (kbd "RET") 'view-stardict-in-buffer)

	     ;;这是我加的，在stardict的buffer中用del(退格键，不是delete)来关闭window
	     (local-set-key (kbd "DEL") (lambda ()
					  (interactive)
					  (bury-buffer)
					  (unless (null (cdr (window-list)))
					    (delete-window))))
	     ;;
	     
	     ;;
	     ;; (local-set-key (kbd "p") (lambda ()
	     ;; 			     (interactive)
	     ;; 			     (bury-buffer)
	     ;; 			     (unless (null (cdr (window-list)))
	     ;; 			       (delete-window))))
	     ;;
	     ;; (local-set-key (kbd "q") (lambda ()
		
	     ;;    			(bury-buffer)
	     ;;    			(unless (null (cdr (window-list))) ; only one window
	     ;;    			  (delete-window))))

	     (local-set-key (kbd "q") 'quit-window)
             )
	   (goto-char (point-min))))))))
(provide 'stardict)
