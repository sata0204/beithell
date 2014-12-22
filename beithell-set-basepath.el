(provide beithell-set-basepath)
(defun beithell-set-basepath()
  "read and set TEX-Genkou folder bath."
  (interactive)
  (progn
    (defvar beithell-base-path)
    (save-excursion
      (let ((true-path-p nil))
	(while (not true-path-p)
	  (setq beithell-base-path 
		(read-string "TEX-Genkouの存在するパスを入力\n例：C:\\work\\TEX-Genkou\\14-Nyushi\\...なら\nC:\\work :"))
	  (setq beithell-base-path (concat beithell-base-path "\\TEX-Genkou\\"))
	  (setq true-path-p (yes-or-no-p (format "TEX-Genkouのパスは%sですか？" beithell-base-path)))
	  )))))
;;code end
