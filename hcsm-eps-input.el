;; -*- coding: utf-8 -*-
(provide 'hcsm-eps-input)
(require 'hcsm-basicfuncs)
;;;run the function under the path like 
;;;/TEX-Genkou/14-kokuritsu/14-Daigaku/14-DIGK-gkb/14-DIGK-gkb-1/14-DIGK-gkb-toi-1.tex

;;;文字化け対策の応急処置
(defun hcsm-ask-if-create-file2 (file-name &optional template-path force-flag)
  "when `file-name` doesn't exists, ask if create it. you can use template."
  (unless (file-exists-p file-name)
    (when (if force-flag t (y-or-n-p (format "%sを作成しますか?" file-name)))
      (if template-path
	  (copy-file template-path file-name)
	(hcsm-open-to-kill file-name (lambda ()) nil)))))

(defun hcsm-eps-input (number)
  "Provides easy insertion of .eps pictures"
  (interactive "n図の番号: ")
  ;;the template should be in ~/.emacs.d/hcsm/templates/hcsm-empty.eps
  ;; -> temp coding. should be fixed
  (hcsm-ask-if-create-file2 (format "%s-%s.eps" (file-name-sans-extension (buffer-file-name)) number) "~/.emacs.d/hocsom/templates/hcsm-empty.eps")
  (insert (format "\\includegraphics[width=3.5cm]{../../../../../../TEX-Genkou/%s-%s.eps}" (file-name-sans-extension (file-relative-name buffer-file-name hcsm-TEX-Genkou-path)) number)))
;;code end
