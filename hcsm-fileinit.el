(provide 'hcsm-fileinit)
(defun hcsm-mondai-folder()
  "inside mondai folder."
  (interactive)
  (let 
      (
       ;;local functions
       ;;local variables
       )
    (save-excursion
      (hcsm-create-tex)
      (hcsm-create-tex toi)
      (hcsm-create-kakunin-tex)
      );save-excursion
    );let
  );defun

(defun hcsm-create-tex(filename buffer)
  "create .tex file"
  ()
  (save-excursion
    (with-temp-file filename 
      (insert buffer)
      )))
(let (filename)
(defun hcsm-create-filename(year univ &optional suffix1 question-num suffix2)
  "create .tex filename."
  ()
  (save-excursion
    ()
    )))
