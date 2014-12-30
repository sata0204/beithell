(require 'hcsm-basicfuncs)
(provide 'hcsm-fileinit)
(defun hcsm-create-files(college-folder-path univ-college-folder-name suffix)
  "create tex files." ()
  (cond 
   ((string-match "[0-9]" suffix) ;uncode temp
    (when (string-match "-" suffix)
      (when (string-match "-1" suffix) 
	  (hcsm-create-tex-file "%s/%s-%s/%s-toi-%s.tex" "year-univ-toi-1-1.tex")
	  (hcsm-create-tex-file "%s/%s-%s/%s-kai-%s.tex" "year-univ-kai-1-1.tex")
	  (hcsm-create-tex-file "%s/%s-%s/%s-%s-kakunin.tex" "year-univ-1-1-kakunin.tex"))
      (hcsm-create-tex-file "%s/%s-%s/%s-toi-%s.tex" "year-univ-toi-1-1.tex")
      (hcsm-create-tex-file "%s/%s-%s/%s-kai-%s.tex" "year-univ-kai-1-2.tex")
      (hcsm-create-tex-file "%s/%s-%s/%s-%s-kakunin.tex" "year-univ-1-1-kakunin.tex"))
    (hcsm-create-tex-file "%s/%s-%s/%s-toi-%s.tex" "year-univ-toi-2.tex")
    (hcsm-create-tex-file "%s/%s-%s/%s-kai-%s.tex" "year-univ-kai-1-1.tex")
    (hcsm-create-tex-file "%s/%s-%s/%s-%s-kakunin.tex" "year-univ-2-kakunin.tex"));cond digit end
   ((string-match "matome" suffix) 
    (hcsm-create-tex-file "%s/%s-%s/%s.tex" "year-univ.tex" t)
    (hcsm-create-tex-file "%s/%s-%s/%s-kakunin.tex" "year-univ-kakunin.tex" t))
   ((string-match "end" suffix) 
    (hcsm-create-tex-file "%s/%s-%s/%s-end.tex" "year-univ-end.tex" t))
  ));cond defun

(defun hcsm-create-tex-file(tex-file-path-format template-name &optional no-suffix-flag)
  "actually work to create .tex file reading some templates."
  ()
  (let (tex-path)
    (save-excursion
      (if no-suffix-flag ;for use of matome, end or so
	(setq tex-path (format tex-file-path-format college-folder-path 
			       univ-college-folder-name suffix univ-college-folder-name))
	(setq tex-path (format tex-file-path-format college-folder-path 
			       univ-college-folder-name suffix univ-college-folder-name suffix)))
      (hcsm-ask-if-create-file tex-path (format "%s/tex/%s" hcsm-template-path template-name) t)
      )))
