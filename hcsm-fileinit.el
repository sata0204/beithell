(require 'hcsm-basicfuncs)
(provide 'hcsm-fileinit)
;;college-folder-path, univ-college-folder-name is for hcsm-create-tex-file

(defun hcsm-create-tex-files(college-folder-path univ-college-folder-name suffix univ-short-name college-name)
  "create tex files."
  (cond 
   ;;about parts/questions
   ((string-match "[0-9]" suffix)
    (let (format-list template-list)
      ;;formats are common in all parts
      (setq format-list '("%s/%s-%s/%s-toi-%s.tex" "%s/%s-%s/%s-kai-%s.tex" "%s/%s-%s/%s-%s-kakunin.tex"))
      ;;templates are different
      (setq template-list '("year-univ-toi-2.tex" "year-univ-kai-1-1.tex" "year-univ-2-kakunin.tex"))
      (when (string-match "-" suffix)
	(setq template-list '("year-univ-toi-1-1.tex" "year-univ-kai-1-2.tex" "year-univ-1-1-kakunin.tex"))
	(when (string-match "-1" suffix) 
	  (setq template-list '("year-univ-toi-1-1.tex" "year-univ-kai-1-1.tex" "year-univ-1-1-kakunin.tex"))))
      ;;create files
      (let (i) (dotimes (i 3) (hcsm-initialize-tex-file univ-short-name college-name 
						    (nth i format-list) (nth i template-list) t)))))
    ;;about matome
    ((string-match "matome" suffix)
     (hcsm-initialize-tex-file univ-short-name college-name 
			       "%s/%s-%s/%s.tex" "year-univ.tex")
     (hcsm-initialize-tex-file univ-short-name college-name 
			       "%s/%s-%s/%s-kakunin.tex" "year-univ-kakunin.tex"))
    ;;about end
    ((string-match "end" suffix)
     (hcsm-initialize-tex-file univ-short-name college-name 
			       "%s/%s-%s/%s-end.tex" "year-univ-end.tex"))))

;;univ-short-name college-name is for hcsm-replace-in-tex-file
;;tex-file-path-format template-name suffix-flag is for hcsm-create-tex-file
(defun hcsm-initialize-tex-file(univ-short-name college-name tex-file-path-format template-name &optional suffix-flag)
  "initialize .tex files."
  (hcsm-replace-in-tex-file 
   (if suffix-flag
       (hcsm-create-tex-file tex-file-path-format template-name suffix-flag)
     (hcsm-create-tex-file tex-file-path-format template-name))
   univ-short-name
   college-name))


(defun hcsm-create-tex-file(tex-file-path-format template-name &optional suffix-flag)
  "actually work to create .tex file reading some templates. returns a path to the file created."
  (let (path-to-tex-file)
    (if suffix-flag ; t: %s * 5, about parts     nil: %s * 4, about others
	(setq path-to-tex-file (format tex-file-path-format college-folder-path 
				       univ-college-folder-name suffix univ-college-folder-name suffix))
      (setq path-to-tex-file (format tex-file-path-format college-folder-path 
				     univ-college-folder-name suffix univ-college-folder-name)))
    (hcsm-ask-if-create-file path-to-tex-file (format "%s/tex/%s" hcsm-template-path template-name) t)
    path-to-tex-file)) ;return path

(defun hcsm-replace-in-tex-file(path-to-tex-file univ-short-name college-name)
  "actually work to replace containts of template .tex file."
  (hcsm-open-to-kill 
   path-to-tex-file 
    (lambda ()
      (progn
	(perform-replace "(大学名)" univ-short-name nil nil nil)
	(perform-replace "(学部名)" college-name nil nil nil)
	(perform-replace "(年度)" hcsm-school-year nil nil nil)
	))));lambda end
