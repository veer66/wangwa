(in-package :wangwa)

(defun assoc* (m k v &key test)
  (acons k
	 v
	 (remove-if (lambda (i)
		      (if test
			  (funcall test (car i) k)
			  (eq (car i) k)))
		    m)))
