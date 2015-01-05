(provide 'hcsm-setup)
(require 'hcsm-basicfuncs)
(defun hcsm-setup()
  "provide setting functions."
  (interactive)
  (save-excursion
    ;;hcsm-TEX-Genkou-path
    (hcsm-modify-settings 'hcsm-TEX-Genkou-path (hcsm-get-TEX-Genkou-path))
    (hcsm-create-new-directory hcsm-TEX-Genkou-path)

    ;;hcsm-school-year
    (hcsm-modify-settings 'hcsm-school-year (read-string "何年度?"))

    ;;hcsm-template-path
    (hcsm-modify-settings 'hcsm-template-path (read-directory-name "template-path:"));temp
    );save-excursion
  );defun


(defun hcsm-modify-settings(name value)
  "modify/generate setting written in `hcsm-var-settings.el`."
  (save-excursion 
    (if (boundp name) 
	(when (y-or-n-p (format "%s の値を %s に変更しますか？" name value))
	  (hcsm-open-to-kill "~/.emacs.d/hocsom/hcsm-var-settings.el"   ;; var `name` exists
			     'hcsm-overwrite-defvar (list name value))) ;; -> modify setting
      (hcsm-open-to-kill "~/.emacs.d/hocsom/hcsm-var-settings.el" ;; when `name` is void 
                         'hcsm-write-defvar (list name value)))   ;; -> create new setting
    (set name value)))

(defun hcsm-get-TEX-Genkou-path()
  "read and set TEX-Genkou folder bath."
  (save-excursion
    (defvar hcsm-TEX-Genkou-path) ;hcsm-TEX-Genkou-path should be void If you run the func.
    (let (correct-path-flag)
      (while (not correct-path-flag)
	(setq hcsm-TEX-Genkou-path (format "%sTEX-Genkou" (read-directory-name "TEX-Genkouの存在するパス(フォルダの位置)を入力\n例：C:\\work\\TEX-Genkou\\(年度)-Nyushi\\...なら\nC:/work/ :\n例：~/work/TEX-Genkou/(年度)-Nyushi/...なら\n~/work/ ")))
	(setq correct-path-flag
	      (y-or-n-p (format "TEX-Genkouのパスは%sですか？" hcsm-TEX-Genkou-path))))
	hcsm-TEX-Genkou-path ;return it
	)))
;;code end
