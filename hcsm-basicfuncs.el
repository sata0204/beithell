(provide 'hcsm-basicfuncs)

(defun hcsm-set-string-var(varname prompt &optional convert-option)
  "set `varname` from mini-buffer." ()
  (save-excursion
    (if (eq convert-option nil)
	(set varname (read-string prompt))
      (set varname (funcall convert-option (read-string prompt)))
      )))

(defun hcsm-replace (regexp to-string)
  "バッファ内でregexpにマッチした部分をto-stringに置き換える"
  (goto-char (point-min))
  (while (re-search-forward regexp nil t)
    (replace-match to-string)))

(defun hcsm-open-to-kill (file function &optional argument-list)
  "fileを開き，functionを実行後保存し消す"
  (with-current-buffer (find-file-noselect file)
    (if argument-list
	(apply function argument-list)
      (apply function nil))
    (save-buffer)
    (kill-buffer)))

(defun hcsm-overwrite-defvar (var-name value)
  "カレントバッファの変数を書き換える"
  (hcsm-replace (format "(defvar %s .*)" var-name) 
		(format "(defvar %s \"%s\")" var-name value)))
;;might buggy. see #16 and fix it
;;use it only for `hcsm-modify-settings` in `hcsm-setup.el` before get fixed.

(defun hcsm-write-defvar (var-name value)
  "カレントバッファの変数を追加する"
  (save-excursion
    (goto-line (point-max))
    (insert (format "(defvar %s \"%s\")" var-name value))))
;;same as hcsm-overwrite-defvar
;;will be integrated

(defun hcsm-create-new-directory (path-to-dir)
  "ディレクトリを存在しないときのみ作成する"
  (unless (file-directory-p path-to-dir)
    (make-directory path-to-dir 'recursive)))

(defun hcsm-ask-if-create-file (file-name &optional template-path force-flag)
  "when `file-name` doesn't exists, ask if create it. you can use template."
  (unless (file-exists-p file-name)
    (when (if force-flag t (y-or-n-p (format "%sを作成しますか?" file-name)))
      (if template-path
	  (hcsm-open-to-kill file-name (lambda () (insert-file-contents template-path)) nil)
	(hcsm-open-to-kill file-name (lambda ()) nil)))))

(defun hcsm-add-to-list-in-format(listname format-string &rest arg-list)
  (add-to-list listname (format format-string arg-list)))
;code end
