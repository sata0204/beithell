﻿;;; -*- coding: utf-8; lexical-binding: t -*-
(provide 'hcsm-setup)
(require 'hcsm-basicfuncs)
(defun hcsm-setup()
  "provide setting functions."
  (interactive)
  (progn
    ;;hcsm-TEX-Genkou-path
    (hcsm-modify-settings 'hcsm-TEX-Genkou-path (hcsm-get-TEX-Genkou-path))
    (hcsm-create-new-directory hcsm-TEX-Genkou-path)

    ;;hcsm-school-year
    (hcsm-modify-settings 'hcsm-school-year (read-string "年度を入力(2015年度なら15): "))

    ;;hcsm-template-path
;    (hcsm-modify-settings 'hcsm-template-path (read-directory-name "template-path:"));temp
    (message "セットアップ完了")
    );progn
  );defun


(defun hcsm-modify-settings(name value)
  "modify/generate setting written in `hcsm-var-settings.el`."
  (save-excursion 
    (if (boundp name) 
	(when (y-or-n-p (format "%s の値を %s に変更しますか？" name value))
	  (hcsm-open-to-kill "~/.emacs.d/hocsom/hcsm-var-settings.el"   ;; var `name` exists
			     'hcsm-overwrite-defvar (list name value)))  ;; -> modify setting
      (hcsm-open-to-kill "~/.emacs.d/hocsom/hcsm-var-settings.el" ;; when `name` is void 
			 'hcsm-write-defvar (list name value)))   ;; -> create new setting
    (set name value)))

(defun hcsm-get-TEX-Genkou-path()
  "read TEX-Genkou folder bath."
  (let (correct-path-flag TEX-Genkou-path)
    (while (not correct-path-flag)
      (setq TEX-Genkou-path (format "%sTEX-Genkou" (read-directory-name "TEX-Genkouの存在するパス(フォルダの位置)を入力\n例：C:/work/TEX-Genkou/(年度)-Nyushi/...ならC:/work/\n例：~/work/TEX-Genkou/(年度)-Nyushi/...なら~/work/\n")))
      (setq correct-path-flag
	    (y-or-n-p (format "TEX-Genkouのパス(フォルダの位置)は%sですか？" TEX-Genkou-path))))
    TEX-Genkou-path			;return it
    ))
;;code end
