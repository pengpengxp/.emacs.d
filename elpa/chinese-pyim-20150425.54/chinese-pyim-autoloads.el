;;; chinese-pyim-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "chinese-pyim-company" "chinese-pyim-company.el"
;;;;;;  (21846 45016 0 0))
;;; Generated autoloads from chinese-pyim-company.el

(autoload 'pyim-company-complete "chinese-pyim-company" "\
`company-mode' 补全命令的包装函数，专门用户 `chinese-pyim'

\(fn)" t nil)

;;;***

;;;### (autoloads nil "chinese-pyim-dictools" "chinese-pyim-dictools.el"
;;;;;;  (21846 45016 0 0))
;;; Generated autoloads from chinese-pyim-dictools.el

(autoload 'pyim-hanzi2pinyin "chinese-pyim-dictools" "\
将汉字字符串转换为对应的拼音字符串, 如果 `shou-zi-mu' 设置为t,转换仅得到拼音
首字母字符串。如果 `ignore-duo-yin-zi' 设置为t, 遇到多音字时，只使用第一个拼音。
其它拼音忽略。

\(fn STRING &optional SHOU-ZI-MU SEPARATOR RETURN-LIST IGNORE-DUO-YIN-ZI)" nil nil)

(autoload 'pyim-hanzi2pinyin-simple "chinese-pyim-dictools" "\
简化版的 `pyim-hanzi2pinyin', 不处理多音字。

\(fn STRING &optional SHOU-ZI-MU SEPARATOR RETURN-LIST)" nil nil)

(autoload 'pyim-update-dict-file "chinese-pyim-dictools" "\
手动调整 Chinese-pyim 词库文件后，执行此命令可以：
1. 按照每行拼音对文件进行排序。
2. 删除重复的词条。

当我们明确无误的知道此命令的使用条件已经符合时。可以将 `force' 设置
为 t ，此时，就不需要用户进一步确认是否执行此命令。

当 `sort-by-freq' 设置位 t 时，删除每一行的重复词条之前，首先将词条按照
词条出现的频率大小排序，这个选项适用于：从文章构建词库，文章中词条出现
频率可以代表此词条的使用频率。

\(fn &optional FORCE SORT-BY-FREQ)" t nil)

(autoload 'pyim-article2dict-chars "chinese-pyim-dictools" "\
将一篇中文文章转换为 Chinese-pyim 可以识别的拼音词库。
这个命令只将文章中 *非词语* 中文字符转化为词库。

这个命令可以得到一篇文章中常用单字词语的词频信息。

\(fn)" t nil)

(autoload 'pyim-article2dict-words "chinese-pyim-dictools" "\
将一篇中文文章转换为 Chinese-pyim 可以识别的拼音词库。
这个命令将文章中 *正确词语*，转化为词库。

这个命令使用频率很低，原因有两点：
1. 寻找准确的中文词条非常容易，一般不需要从一篇文章中通过分词的手段获得。
2. 文章很大时，这个命令运行速度太慢。

这个命令最大的用途就是为没有拼音的中文词库添加拼音code。

\(fn)" t nil)

(autoload 'pyim-article2dict-misspell-words "chinese-pyim-dictools" "\
将一篇中文文章转换为 Chinese-pyim 可以识别的拼音词库。
这个命令将文章中 *连续出现的独立汉字* 组合成中文字符串，
然后将其转化为词库，例如：

   “哪  狗  天”

会被转换为：

   “哪狗天”

有一句话说：“对的都一样，错的万万千”，对用户来说，这个命令可能
最有用处，它可以增加许多新词，也许这些新词毫无意义，但其代表了一种
输入习惯，可以提高输入体验。

\(fn)" t nil)

(autoload 'pyim-dicts-manager "chinese-pyim-dictools" "\
Chinese-pyim 词库管理器。

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("chinese-pyim-core.el" "chinese-pyim-devtools.el"
;;;;;;  "chinese-pyim-pkg.el" "chinese-pyim-pymap.el" "chinese-pyim.el")
;;;;;;  (21846 45016 343344 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; chinese-pyim-autoloads.el ends here
