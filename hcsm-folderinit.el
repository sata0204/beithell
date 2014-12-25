(provide hcsm-folderinit)
(require hcsm-basicfunc)

(defun hcsm-folderinit ()
  "Initialize folders."
  (interactive)
  (let (;;local functions
	;;local variables
	ritsu univ_name univ_short_name has_only_college college_option college_name 
	numbers_of_parts numbers_of_questions univ_folder_path univ_college_folder_name
	college_folder_path suffixes_of_folders suffix
	)
    (save-excursion
      ;;大学基本設定
      (hcsm-set-string-var 'ritsu "国立大なら1を、私立大なら2を入力" 'string-to-number)
      (cond ((equal ritsu 1) (setq ritsu "kokuritsu"))
	    ((equal ritsu 2) (setq ritsu "shiritsu"))
	    (t (error "なに立大学か不明。"))
	    )
      (hcsm-set-string-var 'univ_name "大学名をローマ字12文字以内で入力" 'capitalize)
      (hcsm-set-string-var 'univ_short_name "大学略称をローマ字で入力" 'upcase)

      ;;学部設定
      (hcsm-set-string-var 'has_only_college "単学部なら1を、そうでないなら2を入力" 'string-to-number)
      (cond 
       ((equal has_only_college 1) 
	(progn 
	  (hcsm-set-string-var 'college_option "前期なら1、中期なら2、後期なら3、医学部のみなら4を入力" 'string-to-number)
	  (cond
	   ((equal college_option 1) (setq college_name "zen"))
	   ((equal college_option 2) (setq college_name "chu"))
	   ((equal college_option 3) (setq college_name "ko"))
	   ((equal college_option 4) (setq college_name "i"))
	   (t (error "何期大学か不明。")))));cond=1 end
       ((equal has_only_college 2) 
	(hcsm-set-string-var 'college_name 
		 (append "学部名を10字以内のローマ字で入力\n" ;use append only for code indent 
			 "学科名は-で繋ぐこと\n" 
			 "(例：ri-oubutsu)") 'downcase));cond=2 end
	(t (error "何学部か不明。"))
	)


       ;;大問設定
       (hcsm-set-string-var 'numbers_of_parts "大問数を入力" 'string-to-number)
       (setq parts_consist_of_questions
	     (split-string 
	      (hcsm-set-string-var 'parts_consist_of_questions 
		       "小問集合問題である大問を入力\n半角数字、半角スペース区切り")))
       (setq parts_consist_of_questions ;リストの要素を文字から数字リテラルに変換
	     (mapcar #'string-to-number parts_consist_of_questions)) 
       ;;小問設定
       (let ((i 0))
	 (while (< i numbers_of_parts)
	   (progn 
	     (push ;push (True:ask False:0) into numbers_of_questions
	      (if (member (+ i 1) parts_consist_of_questions) 
		  (string-to-number (read-string (format "大問%dの小問数を入力" (+ i 1)))) 0) 
	      numbers_of_questions)
	     (setq i (+ i 1))
	     )));progn, while, let
       (setq numbers_of_questions (reverse numbers_of_questions))


       ;;フォルダ名セット
       (when (eq hcsm-basepath nil) (hcsm-set-basepath)) ;confirm basepath exsistence
       (setq univ_folder_path 
	     (expand-file-name (format "%s/14-Nyushi/14-%s/14-%s" 
				       hcsm-basepath ritsu univ_name)))
       (setq univ_college_folder_name (format "14-%s-%s" univ_short_name college_name))
       (setq college_folder_path (format "%s/%s" univ_folder_path univ_college_folder_name))

       ;;フォルダ名の問題番号部分を作成
       (setq suffixes_of_folders nil)
       (let  ((j 1))
	 (while (<= j numbers_of_parts)
	   (if (equal (nthcdr (- j 1) numbers_of_questions) 0) 
	       (add-to-list 'suffixes_of_folders (list j))
	     (let ((k 1))
	       (while (<= k (nthcdr (- j 1) numbers_of_questions))
		 (add-to-list 'suffixes_of_folders (list (format "%d-%d" j k)))
		 (setq k (+ k 1))));let k end
	     );if end
	   (setq j (+ j 1))));loop end
       (add-to-list 'suffixes_of_folders (list "end" "matome")))

      ;;フォルダ実作成
      (make-directory college_folder_path 'recursive)
      (dolist (suffix suffixes_of_folders)
	(make-directory 
	 (format "%s/%s-%s" college_folder_path univ_college_folder_name suffix) 'recursive))
      ) ;save-excursion
    ) ;let
  );defun
