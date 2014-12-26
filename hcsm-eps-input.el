(provide 'hcsm-eps-input)
;;;run the function under the path like 
;;;/TEX-Genkou/14-kokuritsu/14-Daigaku/14-DIGK-gkb/14-DIGK-gkb-1/14-DIGK-gkb-toi-1.tex
(defun hcsm-eps-input()
  "Provides easy insertion of .eps pictures"
  (interactive)
  (let 
      (current-path 
       split-path 
       split-actual-tex-path 
       split-relative-tex-path 
       tex-file-name
       iterator-of-question
       eps-file-name
       split-relative-eps-path
       relative-eps-path
       formatted-eps-path
       )
    (save-excursion
      ;;パス下ごしらえ
      (setq current-path buffer-file-name)
      (setq split-path (split-string current-path "/"))
      ;;大学名から図名を取得
      (setq split-actual-tex-path (member "TEX-Genkou" split-path))
      (setq split-relative-tex-path (push "../../../../../.." split-actual-tex-path))
      (setq tex-file-name (elt (last split-relative-tex-path) 0))
      (setq iterator-of-question (read-string "図の番号は：")) ; will be replaced and automated 

      (setq eps-file-name 
	    (concat 
	     (substring tex-file-name 0 -4) "-" iterator-of-question ".eps"
	     )
	    )

      ;;epsのpathになるよう加工
      (setq split-relative-eps-path (copy-sequence split-relative-tex-path))
      (setf (elt 
	     split-relative-eps-path 
	     (- (length split-relative-eps-path) 1)
	     ) 
	    eps-file-name
	    )
      (setq relative-eps-path "")
      (while split-relative-eps-path
	(setq relative-eps-path 
	      (concat relative-eps-path "/" (pop split-relative-eps-path))
	)
      )
      ;;relative-eps-pathを整形して出力
      (setq formatted-eps-path (concat "\\includegraphics[width=3.5cm]{" (substring relative-eps-path 1 nil) "}"))
      (insert formatted-eps-path)
      ) 
    )
  )

  
