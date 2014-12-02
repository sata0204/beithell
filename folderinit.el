(defun beit-hell-test ()
(interactive)
("This is a test of the beithell.")
;daigaku settei
(setq is_kokuritsu (read-string "kokuritsu:1 shiritsu:2"))
(setq univ_name (read-string "univ full name:"))
(setq univ_short_name (read-string "univ short name:"))
(setq has_only_college (read-string "tangakubu:1 others:2 :"))
(if (equal has_only_college 1)
  (setq college_option (read-string "zen:1 chu:2 kou:3 i:4 :"))
  (setq college_name (read-string "college name:"))
)
;taimon settei
(setq numbers_of_parts (read-string "number of parts:"))
(setq i 0)
(while i < numbers_of_parts
  ((push number_of_questions (read-string "number of questions:"))
   (setq i (+ i 1)))
)
;folder name setting
(setq univ_folder_path (read-string "number of parts:")) ;how to find TEX-Genkou dir?
(setq numbers_of_parts (read-string "number of parts:"))
(setq numbers_of_parts (read-string "number of parts:"))
(setq numbers_of_parts (read-string "number of parts:"))
(setq numbers_of_parts (read-string "number of parts:"))
(setq numbers_of_parts (read-string "number of parts:"))
(setq numbers_of_parts (read-string "number of parts:"))
(setq numbers_of_parts (read-string "number of parts:"))
(setq numbers_of_parts (read-string "number of parts:"))
(setq numbers_of_parts (read-string "number of parts:"))

