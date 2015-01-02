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
    (hcsm-modify-settings 'hcsm-school-year (format "%s/TEX-Genkou" (hcsm-get-school-year)))

    ;;hcsm-template-path
;    (hcsm-modify-settings 'hcsm-template-path (read-directory-name "template-path:"));temp
    );save-excursion
  (message "セットアップ完了")
  );defun


(defun hcsm-modify-settings(name value)
  "modify/generate setting written in `hcsm-var-settings.el`."
  (save-excursion 
    (if (boundp name) 
	(hcsm-open-to-kill "~/.emacs.d/hocsom/hcsm-var-settings.el"   ;; var `name` exists
			   'hcsm-overwrite-defvar (list name value)) ;; -> modify setting
      (hcsm-open-to-kill "~/.emacs.d/hocsom/hcsm-var-settings.el" ;; when `name` is void 
                         'hcsm-write-defvar (list name value)))   ;; -> create new setting
    (set name value)))

(defun hcsm-get-school-year ()
  "set hcsm-school-year."
  (let ((school-year (read-number "年度を入力(2015年度なら\"15\"): ")))
    (if (y-or-n-p (format "20%s年度ですか?" school-year))
	school-year
      (hcsm-get-school-year))))

(defun hcsm-get-TEX-Genkou-path ()
  "read and set TEX-Genkou folder bath."
  (let ((TEX-Genkou-path (read-directory-name "TEX-Genkouの存在するパス(フォルダ)を入力\n例：C:/work/TEX-Genkou/...ならC:/work/\n例：~/work/TEX-Genkou/...なら~/work/\n")))
    (if (y-or-n-p (format "TEX-Genkouの存在するパス(フォルダ)は%sですか?" TEX-Genkou-path))
	TEX-Genkou-path
      (hcsm-get-TEX-Genkou-path))))

