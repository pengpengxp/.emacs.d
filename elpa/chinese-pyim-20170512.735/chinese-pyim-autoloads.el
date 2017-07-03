;;; chinese-pyim-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "chinese-pyim-dictools" "chinese-pyim-dictools.el"
;;;;;;  (22873 42226 0 0))
;;; Generated autoloads from chinese-pyim-dictools.el

(autoload 'pyim-hanzi2pinyin "chinese-pyim-dictools" "\
将汉字字符串转换为对应的拼音字符串, 如果 `shou-zi-mu' 设置为t,转换仅得到拼音
首字母字符串。当 `return-list' 设置为 t 时，返回一个拼音列表，这个列表包含词条的一个
或者多个拼音（词条包含多音字时）；如果 `ignore-duo-yin-zi' 设置为t, 遇到多音字时，
只使用第一个拼音，其它拼音忽略；当 `adjuct-duo-yin-zi' 设置为t时，pyim-hanzi2pinyin
会使用 Chinese-pyim 已安装的词库来校正多音字，但这个功能有一定的限制:

1. Chinese-pyim 普通词库中不存在的词条不能较正
2. 多音字校正速度比较慢，实时转换会产生卡顿。

BUG: 当 `string' 中包含其它标点符号，并且设置 `separator' 时，结果会包含多余的连接符：
比如： '你=好' --> 'ni-=-hao'

\(fn STRING &optional SHOU-ZI-MU SEPARATOR RETURN-LIST IGNORE-DUO-YIN-ZI ADJUCT-DUO-YIN-ZI)" nil nil)

(autoload 'pyim-hanzi2pinyin-simple "chinese-pyim-dictools" "\
简化版的 `pyim-hanzi2pinyin', 不处理多音字。

\(fn STRING &optional SHOU-ZI-MU SEPARATOR RETURN-LIST)" nil nil)

(autoload 'pyim-dicts-manager "chinese-pyim-dictools" "\
Chinese-pyim 词库管理器。

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("chinese-pyim-benchmark.el" "chinese-pyim-core.el"
;;;;;;  "chinese-pyim-devtools.el" "chinese-pyim-pkg.el" "chinese-pyim-probe.el"
;;;;;;  "chinese-pyim-pymap.el" "chinese-pyim-utils.el" "chinese-pyim.el")
;;;;;;  (22873 42226 89262 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; chinese-pyim-autoloads.el ends here
