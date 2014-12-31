;;; -*- coding: utf-8; lexical-binding: t -*-
(provide 'hcsm-folderinit)
(require 'hcsm-basicfuncs)
(require 'hcsm-folderinit-setting-funcs)

(defun hcsm-folderinit ()
  "Initialize folders."
  (interactive)
  (save-excursion
    ;;大学基本設定
    (defconst ritsu (hcsm-ask-ritsu))
    (defconst univ-name (capitalize (read-string "大学名をローマ字12文字以内で入力")))
    (defconst univ-short-name (upcase (read-string "大学略称をローマ字で入力")))
    (defconst univ-japanese-name (read-string "大学名を日本語で入力")) ;temp
    ;;学部設定
    (defconst college-name (hcsm-ask-collage))
    (defconst college-japanese-name (read-string "学部名を日本語で入力")) ;temp
    ;;大問・小問設定
    (defconst numbers-of-questions (hcsm-question-setting))

    ;;フォルダ名セット
    (when (not (boundp 'hcsm-TEX-Genkou-path)) (hcsm-setup)) ;confirm TEX-Genkou-path exsistence
    (defconst univ-folder-path 
      (expand-file-name (format "%s/%s-Nyushi/%s-%s/%s-%s" 
				hcsm-TEX-Genkou-path hcsm-school-year hcsm-school-year ritsu hcsm-school-year univ-name)))
    (defconst univ-college-folder-name (format "%s-%s-%s" hcsm-school-year univ-short-name college-name))
    (defconst college-folder-path (format "%s/%s" univ-folder-path univ-college-folder-name))
    ;;フォルダ名の問題番号部分を作成
    (defconst list-of-suffixes
      (hcsm-create-suffixes (length numbers-of-questions) numbers-of-questions))

    ;;フォルダ実作成
    (hcsm-create-tex)
    ) ;save-excursion
  );defun

(defun hcsm-create-tex()
  "create tex folders."
  (let (suffix)
    (dolist (suffix list-of-suffixes)
      (progn (hcsm-create-tex-folders suffix) (hcsm-create-tex-files suffix)))))

(defun hcsm-create-tex-folders(suffix)
  "manage all about creating directories for .tex files."
  (make-directory (format "%s/%s-%s" college-folder-path univ-college-folder-name suffix) 'recursive))

(defun hcsm-create-tex-files(suffix)
  "manage all about creating .tex files."
  (let (format-list template-list)
    (cond 
     ;;about parts/questions
     ((string-match "[0-9]" suffix)
      ;;formats are common in all parts
      (setq format-list '("%s/%s-%s/%s-toi-%s.tex" "%s/%s-%s/%s-kai-%s.tex" "%s/%s-%s/%s-%s-kakunin.tex"))
      ;;templates are different
      (setq template-list '("year-univ-toi-2.tex" "year-univ-kai-1-1.tex" "year-univ-2-kakunin.tex"))
      (when (string-match "-" suffix)
	(setq template-list '("year-univ-toi-1-1.tex" "year-univ-kai-1-2.tex" "year-univ-1-1-kakunin.tex"))
	(when (string-match "-1" suffix) 
	  (setq template-list '("year-univ-toi-1-1.tex" "year-univ-kai-1-1.tex" "year-univ-1-1-kakunin.tex"))))
      (hcsm-initialize-tex-files format-list template-list suffix t))
     ;;create files
     ;;about matome
     ((string-match "matome" suffix)
      (setq format-list '("%s/%s-%s/%s.tex" "%s/%s-%s/%s-kakunin.tex"))
      (setq template-list '("year-univ.tex" "year-univ-kakunin.tex"))
      (hcsm-initialize-tex-files format-list template-list suffix))
     ;;about end
     ((string-match "end" suffix)
      (setq format-list '("%s/%s-%s/%s-end.tex"))
      (setq template-list '("year-univ-end.tex"))
      (hcsm-initialize-tex-files format-list template-list suffix)))))

;;this sub-routine is for hcsm-copy-tex-files only.
(defun hcsm-initialize-tex-files(format-list template-list suffix &optional suffix-flag)
  "extract format-list / template-list. 
suffix / suffix-flag are needed for hcsm-copy-tex-file."
  (if suffix-flag
      (let (i) (dotimes (i (length format-list)) (hcsm-initialize-tex-file (nth i format-list) (nth i template-list) suffix t)))
    (let (i) (dotimes (i (length format-list)) (hcsm-initialize-tex-file (nth i format-list) (nth i template-list) suffix)))))

(defun hcsm-initialize-tex-file(tex-file-path-format template-name suffix &optional suffix-flag)
  "(1)copy .tex template -> (2)replace its contents properly. 
suffix / suffix-flag are needed for hcsm-copy-tex-file."
  (hcsm-replace-in-tex-file 
   (if suffix-flag
       (hcsm-copy-tex-file tex-file-path-format template-name suffix suffix-flag)
     (hcsm-copy-tex-file tex-file-path-format template-name suffix))
   suffix))

(defun hcsm-copy-tex-file(tex-file-path-format template-name suffix &optional suffix-flag)
  "copy templates and save as proper name. 
the function returns a path to the file being saved."
  (let (path-to-tex-file)
    (if suffix-flag  
	;;t   : %s * 5, about parts
	;;nil : %s * 4, about others
	(setq path-to-tex-file 
	      (format tex-file-path-format college-folder-path univ-college-folder-name suffix univ-college-folder-name suffix))
      (setq path-to-tex-file 
	    (format tex-file-path-format college-folder-path univ-college-folder-name suffix univ-college-folder-name)))
    ;;create `path-to-tex-file`
    (hcsm-ask-if-create-file path-to-tex-file (format "%s/tex/%s" hcsm-template-path template-name) t)
    path-to-tex-file)) ;return path

(defun hcsm-replace-in-tex-file(path-to-tex-file suffix)
  "replace bare .tex file sent from hcsm-copy-tex-file"
  (hcsm-open-to-kill 
   path-to-tex-file 
   (lambda () 
     (progn
       (hcsm-replace "UVS" univ-short-name)
       (hcsm-replace "university" univ-name)
       (hcsm-replace "daigakumei" univ-japanese-name)
       (hcsm-replace "department" college-name)
       (hcsm-replace "gakubu" college-japanese-name)
       (cond 
	((string-match "[0-9]" suffix)
	 (hcsm-replace "daimon-minus-one" (number-to-string (- (string-to-number (match-string 0 suffix)) 1)))
	 (hcsm-replace "mon-bango" suffix))
	((string-match "matome" suffix)
	 (hcsm-create-matome)))))))

(defun hcsm-create-matome()
  "create matome file. insert lines into toi/kai/end list, then finally output strings using mapconcat."
  (let ((numbers-of-parts (length numbers-of-questions)) toi-text-lists kai-text-lists end-text-lists)
    (dotimes (i numbers-of-parts)
      (if (equal (nth i numbers-of-questions) 0) ;if non questional parts
	  ;;true: non questional parts
	  (progn 
	    (add-to-list 'toi-text-lists 
			 (format "\\input{../../%s/%s-%s/%s-toi-%s}" univ-college-folder-name 
				 univ-college-folder-name (+ i 1) univ-college-folder-name (+ i 1)))
	    (add-to-list 'kai-text-lists 
			 (format "\\input{../../%s/%s-%s/%s-kai-%s}" univ-college-folder-name 
				 univ-college-folder-name (+ i 1) univ-college-folder-name (+ i 1))))

	;;false: questional parts
	(add-to-list 'toi-text-lists "\\begin{reidai}")
	(dotimes (j (nth i numbers-of-questions))
	  (add-to-list 'toi-text-lists (format "\\begin{shomonr}\n\\input{../../%s/%s-%s-%s/%s-toi-%s-%s}\\end{shomonr}"
					       univ-college-folder-name univ-college-folder-name (+ i 1) (+ j 1) 
					       univ-college-folder-name (+ i 1) (+ j 1))))
	(add-to-list 'toi-text-lists "\\end{reidai\\\\b}")
	;;questional parts end
	)
      (add-to-list `kai-text-lists "\\vspace{2mm}")
      );dotimes i end

    ;;end folder
    (add-to-list 'end-text-lists (format "\\input{../../%s/%s-end/%s-end}"
					 univ-college-folder-name univ-college-folder-name univ-college-folder-name))
    
    (hcsm-replace "\%toi\%" (mapconcat (lambda()) (reverse list-of-toi-texts) "\n"))
    (hcsm-replace "\%kai\%" (mapconcat (lambda()) (reverse list-of-kai-texts) "\n"))
    (hcsm-replace "\%end\%" (mapconcat (lambda()) (reverse list-of-end-texts) "\n"))
    ))
