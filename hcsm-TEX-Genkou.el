(provide 'hcsm)

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
  (hcsm-replace (format "(defvar %s .*)" variable-name) (format "(defvar %s \"%s\")" variable-name variable)))

(defun hcsm-new-directory (directory position)
  "ディレクトリを存在しないときのみ作成する"
  (unless (file-directory-p (concat position directory))
        (make-directory (concat position directory))))

(defun hcsm-base-position (position)
  "TEX-Genkouディレクトリを指定・作成する"
  (interactive "D\"TEX-Genkou\"を置くディレクトリ: ")
  (hcsm-open-to-kill "~/.emacs.d/hocsom/hcsm-setup.el" 'hcsm-defvar (list "hcsm-TEX-Genkou-position" position))
  (hcsm-new-directory "TEX-Genkou" position))

(defun hcsm-new-file (file-name)
  "ファイルが存在しないとき作成するか質問する"
  (unless (file-exists-p file-name)
    (when (y-or-n-p (format "%sを作成しますか?" file-name))
      (hcsm-open-to-kill file-name (lambda ()) nil))))

(defun hcsm-eps (number)
  "includegraphicsを挿入する"
  (interactive "n図の番号: ")
  (hcsm-new-file (format "%s-%s.eps" (file-name-sans-extension (buffer-file-name) ) number)) ;該当epsが存在しないとき空ファイルを置くか聞く
  (insert (format "\\includegraphics[width=3.5cm]{../../../../../../%s-%s}" (file-name-sans-extension (file-relative-name buffer-file-name hcsm-TEX-Genkou-position)) number)))

(defun hcsm-folderinit ()
  (interactive)
(let ((hcsm-ritsu (completing-read "国立大ならk，私立大ならs: " '("k" "s") nil t)))))
