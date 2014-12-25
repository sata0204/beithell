(provide beithell-set-basepath)
(defun beithell-set-basepath()
  "read and set TEX-Genkou folder bath."
  (interactive)
  (progn
    (defvar beithell-basepath)
    (save-excursion
      (let ((true-path-p nil))
	(while (not true-path-p)
	  (setq beithell-basepath 
		(read-string (append "TEX-Genkouの存在するパスを入力\n"
				     "例：C:\\work\\TEX-Genkou\\14-Nyushi\\...なら\n"
				     "C:\\work : ")) ;use append only for code indent
		(setq beithell-basepath (concat beithell-basepath "\\TEX-Genkou\\"))
		(setq true-path-p 
		      (yes-or-no-p (format "TEX-Genkouのパスは%sですか？" beithell-basepath)))
		);while end

	  (setq beithell-basepath ;convert windows path into *nix-like path
		(mapconcat 'identity (split-string beithell-basepath "\\\\") "/")) 
	  ))))
  ;;code end