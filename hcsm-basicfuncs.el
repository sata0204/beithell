(provide hcsm-basicfunc)

(defun hcsm-set-string-var(varname prompt &optional convert-option)
  "set `varname` from mini-buffer." ()
  (save-excursion
    (if (eq convert-option nil)
    (set varname (read-string prompt))
    (set varname (funcall convert-option (read-string prompt)))
)))
