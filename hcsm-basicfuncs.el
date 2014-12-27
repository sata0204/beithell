(provide 'hcsm-basicfuncs)
(defun hcsm-set-string-var(varname prompt &optional convert-option)
  "set `varname` from mini-buffer." ()
  (save-excursion
    (if (eq convert-option nil)
	(set varname (read-string prompt))
      (set varname (funcall convert-option (read-string prompt)))
      )))

(defun hcsm-set-basepath()
  "read and set TEX-Genkou folder bath."
  (interactive)
  (progn
    (defvar hcsm-basepath)
    (save-excursion
      (let ((true-path-flag nil))
	(while (not true-path-flag)
	  (setq hcsm-basepath (concat (read-string "TEX-Genkouの存在するパスを入力\n例：C:\\work\\TEX-Genkou\\14-Nyushi\\...なら\nC:\\work : ") "\\TEX-Genkou"))
	  (setq true-path-flag 
		(yes-or-no-p (format "TEX-Genkouのパスは%sですか？" hcsm-basepath)))
	  );while end

	(setq hcsm-basepath ;convert windows path into *nix-like path
	      (mapconcat 'identity (split-string hcsm-basepath "\\\\") "/")) 
	))))

(defun hcsm-replace (regexp to-string)
  "バッファ内でregexpにマッチした部分をto-stringに置き換える"
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
;;code end
