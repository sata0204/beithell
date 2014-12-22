(provide beithell-set-basepath)
(defun beithell-set-basepath()
  "read and set TEX-Genkou folder bath."
  (interactive)
  (progn
    (defvar base-path)
    (save-excursion
      (setq base-path (read-string "TEX-Genkouのフォルダパスを入力\n例：C:\work\TEX-Genkou"))
      )))
