(provide 'hcsm-setup)
(require 'hcsm-basicfuncs)

(defun hcsm-setup()
  "provide setting functions."
  (interactive)
  (save-excursion
    ;;hcsm-TEX-Genkou-path
    (hcsm-modify-settings 'hcsm-TEX-Genkou-path (hcsm-get-basepath))
    (hcsm-create-new-directory hcsm-basepath)

    ;;hcsm-school-year
    (hcsm-modify-settings 'hcsm-school-year (read-string "何年度?"))

    );save-excursion
  );defun


(defun hcsm-modify-settings(name value)
  "modify/generate setting written in `hcsm-var-settings.el`."
  (save-excursion 
    (if (boundp name) 
	(when (y-or-n-p (format "%s の値を %s にしますか？" name value))
	  (hcsm-open-to-kill "~/.emacs.d/hocsom/hcsm-var-settings.el"   ;; var `name` exists
			     'hcsm-overwrite-defvar (list name value))) ;; -> modify setting
      (hcsm-open-to-kill "~/.emacs.d/hocsom/hcsm-var-settings.el" ;; when `name` is void 
                         'hcsm-write-defvar (list name value)))   ;; -> create new setting
    (set name value)))

(defun hcsm-get-basepath()
  "read and set TEX-Genkou folder bath."
  (save-excursion
    (defvar hcsm-basepath) ;hcsm-basepath should be void If you run the func.
    (let (correct-path-flag)
      (while (not correct-path-flag)
	(setq hcsm-basepath (format "%sTEX-Genkou" (read-directory-name "TEX-Genkouの存在するパスを入力\n例：C:\\work\\TEX-Genkou\\14-Nyushi\\...なら\nC:/work/ :\n例：~/work/TEX-Genkou/14-Nyushi/...なら\n~/work/ ")))
	(setq correct-path-flag
	      (yes-or-no-p (format "TEX-Genkouのパスは%sですか？" hcsm-basepath))))
	hcsm-basepath ;return it
	)))
;;code end
