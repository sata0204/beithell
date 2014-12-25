(provide hcsm-folderinit)
(require hcsm-basicfunc)

(defun hcsm-folderinit ()
  "Initialize folders."
  (interactive)
  (let (;;local functions
	;;local variables
	ritsu univ-name univ-short-name college-name 
	      numbers-of-questions univ-folder-path univ-college-folder-name
	      college-folder-path suffixes-of-folders
	      )
    (save-excursion
      ;;大学基本設定
      (setq ritsu hcsm-ask-ritsu)
      (hcsm-set-string-var 'univ-name "大学名をローマ字12文字以内で入力" 'capitalize)
      (hcsm-set-string-var 'univ-short-name "大学略称をローマ字で入力" 'upcase)
      ;;学部設定
      (setq college-name hcsm-ask-collage)
      ;;大問・小問設定
      (setq numbers-of-questions (hcsm-question-setting))

      ;;フォルダ名セット
      (when (eq hcsm-basepath nil) (hcsm-set-basepath)) ;confirm basepath exsistence
      (setq univ-folder-path 
	    (expand-file-name (format "%s/14-Nyushi/14-%s/14-%s" 
				      hcsm-basepath ritsu univ-name)))
      (setq univ-college-folder-name (format "14-%s-%s" univ-short-name college-name))
      (setq college-folder-path (format "%s/%s" univ-folder-path univ-college-folder-name))
      ;;フォルダ名の問題番号部分を作成
      (setq suffixes-of-folders (hcsm-create-suffixes))

      ;;フォルダ実作成
      (hcsm-create-folders suffixes-of-folders college-folder-path univ-college-folder-name)
      ) ;save-excursion
    ) ;let
  );defun

(defun hcsm-ask-ritsu()
  "nani ritsu daigaku?" ()
  (let (ritsu)
    (save-excursion
      (hcsm-set-string-var 'ritsu "国立大なら1を、私立大なら2を入力" 'string-to-number)
      (cond ((equal ritsu 1) (setq ritsu "kokuritsu"))
	    ((equal ritsu 2) (setq ritsu "shiritsu"))
	    (t (error "なに立大学か不明。"))
	    )
      ritsu)))

(defun hcsm-ask-collage()
  "nani gakubu?" ()
  (let (has-only-college college-option college-name)
    (save-excursion
      (hcsm-set-string-var 'has-only-college 
			   "単学部なら1を、そうでないなら2を入力" 'string-to-number)
      (cond 
       ((equal has-only-college 1) 
	(progn 
	  (hcsm-set-string-var 
	   'college-option "前期なら1、中期なら2、後期なら3、医学部のみなら4を入力" 
	   'string-to-number)
	  (cond
	   ((equal college-option 1) (setq college-name "zen"))
	   ((equal college-option 2) (setq college-name "chu"))
	   ((equal college-option 3) (setq college-name "ko"))
	   ((equal college-option 4) (setq college-name "i"))
	   (t (error "何期大学か不明。")))));cond=1 end
       ((equal has-only-college 2) 
	(hcsm-set-string-var 'college-name ;use append only for code indent
			     (append "学部名を10字以内のローマ字で入力\n"  
				     "学科名は-で繋ぐこと\n" 
				     "(例：ri-oubutsu)") 'downcase));cond=2 end
       (t (error "何学部か不明。")));cond end
      )))

(defun hcsm-question-setting()
  "return list `numbers of questions`. numbers-of-parts is equal to its length." ()
  (let (numbers-of-parts parts-consist-of-questions numbers-of-questions)
    ;;大問設定
    (hcsm-set-string-var 'numbers-of-parts "大問数を入力" 'string-to-number)
    (setq parts-consist-of-questions
	  (split-string 
	   (hcsm-set-string-var 'parts-consist-of-questions 
				"小問集合問題である大問を入力\n半角数字、半角スペース区切り")))
    (setq parts-consist-of-questions ;リストの要素を文字から数字リテラルに変換
	  (mapcar #'string-to-number parts-consist-of-questions)) 
    ;;小問設定
    (let ((i 0))
      (while (< i numbers-of-parts)
	(progn 
	  (push ;push (True:ask False:0) into numbers-of-questions
	   (if (member (+ i 1) parts-consist-of-questions) 
	       (string-to-number (read-string (format "大問%dの小問数を入力" (+ i 1)))) 0) 
	   numbers-of-questions)
	  (setq i (+ i 1))
	  )));progn, while, let
    (setq numbers-of-questions (reverse numbers-of-questions))
    )))

(defun hcsm-create-folders(list-of-suffixes college-folder-path univ-college-folder-name)
  "create tex folders." ()
  (let (suffix)
    (dolist (suffix list-of-suffixes)
      (make-directory 
       (format "%s/%s-%s" college-folder-path univ-college-folder-name suffix) 
       'recursive))))

(defun hcsm-create-suffixes()
  "create list of suffixes about parts and questions." ()
  (let (suffixes-of-folders)
    (save-excursion
      (setq suffixes-of-folders nil)
      (let  ((i 1))
	(while (<= i numbers-of-parts)
	  (if (equal (nthcdr (- i 1) numbers-of-questions) 0) 
	      (add-to-list 'suffixes-of-folders (list i))
	    (let ((j 1))
	      (while (<= j (nthcdr (- i 1) numbers-of-questions))
		(add-to-list 'suffixes-of-folders (list (format "%d-%d" i j)))
		(setq j (+ j 1)))));let j, if end
	  (setq i (+ i 1))));loop end
      (add-to-list 'suffixes-of-folders (list "end" "matome")))
    ))
