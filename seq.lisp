(in-package :wangwa)

(defun take (s n)
  (subseq s
	  0
	  (min n (length s))))
