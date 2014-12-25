(provide hcsm-set-basepath)
(defun hcsm-set-basepath()
  "read and set TEX-Genkou folder bath."
  (interactive)
  (progn
    (defvar hcsm-basepath)
    (save-excursion
      (let ((true-path-p nil))
	(while (not true-path-p)
	  (setq hcsm-basepath 
		(read-string (append "TEX-Genkouの存在するパスを入力\n"
				     "例：C:\\work\\TEX-Genkou\\14-Nyushi\\...なら\n"
				     "C:\\work : ")) ;use append only for code indent
		(setq hcsm-basepath (concat hcsm-basepath "\\TEX-Genkou\\"))
		(setq true-path-p 
		      (yes-or-no-p (format "TEX-Genkouのパスは%sですか？" hcsm-basepath)))
		);while end

	  (setq hcsm-basepath ;convert windows path into *nix-like path
		(mapconcat 'identity (split-string hcsm-basepath "\\\\") "/")) 
	  ))))
  ;;code end
