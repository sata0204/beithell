(defun hcsm-replace (regexp to-string)
  "バッファ内でregeupにマッチした部分をto-stringに置き換える"
  (goto-char (point-min))
  (while (re-search-forward regexp nil t)
    (replace-match to-string)))

(defun hcsm-open-to-kill (file function argument-list)
  "fileを開き，functionを実行後保存し消す"
  (with-current-buffer (find-file-noselect file)
    (apply function argument-list)
    (save-buffer)
    (kill-buffer)))

(defun hcsm-defvar (variable-name variable)
  "カレントバッファの変数を書き換える"
  (hcsm-replace (format "(defvar %s .*)" variable-name) (format "(defvar %s %s)" variable-name variable)))

(defun hcsm-new-directory (directory position)
  "ディレクトリを存在しないときのみ作成する"
  (unless (file-directory-p (concat position directory))
        (make-directory (concat position directory))))

(defun hcsm-base-position (position)
  "TEX-Genkouディレクトリを指定・作成する"
  (interactive "D\"TEX-Genkou\"を置くディレクトリ: ")
  (hcsm-open-to-kill "~/.emacs.d/hocsom/setup.el" 'hcsm-defvar (list "hcsm-TEX-Genkou-position" position))
  (hcsm-new-directory "TEX-Genkou" position))

