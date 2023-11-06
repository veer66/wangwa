(in-package :wangwa)

(defun slurp-ndsexp (ndsexp-pathname)
  (with-open-file (f ndsexp-pathname)
    (loop for line = (read-line f nil :EOF)
	  until (eq line :EOF)
	  collect
	  (read f))))
