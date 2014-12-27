(provide 'hcsm-eps-input)
(require 'hcsm-basicfuncs)
;;;run the function under the path like 
;;;/TEX-Genkou/14-kokuritsu/14-Daigaku/14-DIGK-gkb/14-DIGK-gkb-1/14-DIGK-gkb-toi-1.tex
(defun hcsm-eps-input (number)
  "Provides easy insertion of .eps pictures"
  (interactive "n図の番号: ")
  (hcsm-ask-if-create-file (format "%s-%s.eps" (file-name-sans-extension (buffer-file-name)) number))
  (insert (format "\\includegraphics[width=3.5cm]{../../../../../../%s-%s}" (file-name-sans-extension (file-relative-name buffer-file-name hcsm-TEX-Genkou-position)) number)))
  
;code end
