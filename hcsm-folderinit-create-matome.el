;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

;;; -*- coding: utf-8; lexical-binding: t -*-
(require 'hcsm-basicfuncs)
(provide 'hcsm-folderinit-create-matome)

(defun hcsm-create-matome()
  "create matome file. insert lines into toi/kai/end list, then finally output strings using mapconcat."
  (let ((numbers-of-parts (length numbers-of-questions)) 
	toi-text-lists kai-text-lists end-text-lists)
    (dotimes (i numbers-of-parts)
      (if (equal (nth i numbers-of-questions) 0) ;if non questional parts
	  ;;true: non questional parts
	  (progn 
	    (add-to-list 'toi-text-lists 
			 (format "\\\\input{../../%s/%s-%s/%s-toi-%s}" univ-college-folder-name 
				 univ-college-folder-name (+ i 1) univ-college-folder-name (+ i 1)))
	    (add-to-list 'kai-text-lists 
			 (format "\\\\input{../../%s/%s-%s/%s-kai-%s}" univ-college-folder-name 
				 univ-college-folder-name (+ i 1) univ-college-folder-name (+ i 1))))

	;;false: questional parts
	(add-to-list 'toi-text-lists "\\\\begin{reidai}")
	(dotimes (j (nth i numbers-of-questions))
	  (add-to-list 'toi-text-lists (format "\\\\begin{shomonr}\\n\\\\input{../../%s/%s-%s-%s/%s-toi-%s-%s}\\\\end{shomonr}"
					       univ-college-folder-name univ-college-folder-name (+ i 1) (+ j 1) 
					       univ-college-folder-name (+ i 1) (+ j 1))))
	(add-to-list 'toi-text-lists "\\\\end{reidai\\\\\\\\b}")
	;;questional parts end
	)
      (add-to-list `kai-text-lists "\\\\vspace{2mm}")
      );dotimes i end

    ;;end folder
    (add-to-list 'end-text-lists (format "\\\\input{../../%s/%s-end/%s-end}"
					 univ-college-folder-name univ-college-folder-name univ-college-folder-name))
    
    (hcsm-replace "\%toi\%" (mapconcat 'identity (reverse toi-text-lists) "\n"))
    (hcsm-replace "\%kai\%" (mapconcat 'identity (reverse kai-text-lists) "\n"))
    (hcsm-replace "\%end\%" (mapconcat 'identity (reverse end-text-lists) "\n"))
    ))
