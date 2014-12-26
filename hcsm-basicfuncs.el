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
  ;;code end
