(defun beit-hell-test ()
  "This is a test of the beithell."
  (interactive)
  (let (;;local functions
	(set-string-var (lambda (varname prompt) 
			  (set varname (read-string prompt))))
	(set-numerical-var (lambda (varname prompt) 
			     (set varname (string-to-number (read-string prompt)))))
	(set-upcased-string-var (lambda (varname prompt) 
				  (set varname (upcase (read-string prompt)))))
	(set-downcased-string-var (lambda (varname prompt) 
				    (set varname (downcase (read-string prompt)))))
	(set-capitalized-string-var (lambda (varname prompt) 
				      (set varname (capitalize (read-string prompt)))))
	;;local variables
	ritsu univ_name univ_short_name has_only_college college_option college_name 
	numbers_of_parts i numbers_of_questions univ_folder_path univ_college_folder_name
	college_folder_path suffixes_of_folders j suffix
	)
    (save-excursion
      ;;大学基本設定
      (funcall set-numerical-var 'ritsu "国立大なら1を、私立大なら2を入力")
      (cond ((equal ritsu 1) (setq ritsu "kokuritsu"))
	    ((equal ritsu 2) (setq ritsu "shiritsu"))
	    (t (message "error-ritsu-value"))
	    )
      (funcall set-capitalized-string-var 'univ_name "大学名をローマ字12文字以内で入力")
      (funcall set-upcased-string-var 'univ_short_name "大学略称をローマ字で入力")

      ;;学部設定
      (funcall set-numerical-var 'has_only_college "単学部なら1を、そうでないなら2を入力")
      (cond ((equal has_only_college 1) 
	     (progn 
	       (funcall set-numerical-var 'college_option "前期なら1、中期なら2、後期なら3、医学部のみなら4を入力")
	       (cond
		((equal college_option 1) (setq college_name "zen"))
		((equal college_option 2) (setq college_name "chu"))
		((equal college_option 3) (setq college_name "ko"))
		((equal college_option 4) (setq college_name "i"))
		(t (message "error-college-option"))
		)
	       )
	     )
	    ((equal has_only_college 2) 
	     (funcall set-downcased-string-var 'college_name "学部名を10字以内のローマ字で入力\n学科名は-で繋ぐこと\n(例：ri-oubutsu)")
	     )
	    (t (message "error-college-value"))
	    )

      ;;問題設定
      (funcall set-numerical-var 'numbers_of_parts "大問数を入力")
      (setq i 0)
      (while (< i numbers_of_parts)
	(progn 
	  (push (read-string (format "大問%dの小問数を入力" i)) numbers_of_questions)
	  (setq i (+ i 1))
	\  )
	)

      ;;フォルダ名セット
      (setq univ_folder_path (expand-file-name 
			      (format "../TEX-Genkou/14-Nyushi/14-%c/14-%c" ritsu univ_name))
	    )
      (setq univ_college_folder_name (format "14-%c-%c" univ_short_name college_name))
      (setq college_folder_path (format "%c/%c" univ_folder_path univ_college_folder_name))
      ;;フォルダ名の語幹部と活用語尾部を別にセッティング
      (setq suffixes_of_folders nil)
      (setq j 0)
      (setq k 0)
      (while (< j numbers_of_parts)
	(if (equal (elt numbers_of_questions j) 0) 
	    (append suffixes_of_folders (list j))
	  (while (< k (elt numbers_of_questions j))
	    (append suffixes_of_folders (list (format "%d-%d" j k)));True
	    );while k end
	  )
	(setq j (+ j 1))
	);while j end
      (append suffixes_of_folders (list "end" "matome"))
      ;;フォルダ実作成
      (make-directory college_folder_path)
      (dolist (suffix suffixes_of_folders)
	(make-directory (format "%s/%s-%s" college_folder_path univ_college_folder_name suffix))
	)
      ) ;save-excursion
    ) ;let
  ) ;defun
