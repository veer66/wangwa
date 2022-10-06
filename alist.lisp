(in-package :wangwa)

(defun assoc* (m k v &key test)
  (loop with attached = nil
	for i in m	
	collecting
	(cond
	  ((and test (funcall test (car i) k)) #1=(progn (setq attached t)
							 (cons k v)))
	  ((and (not test) (eq (car i) k)) #1#)
	  (t i))
	  into c
	finally
	   (return (if attached
		       c
		       (acons k v m)))))

(defun update (m k f &key test)
  (loop for i in m
	collect
	(cond
	  ((and test (funcall test (car i) k)) #1=(funcall f i))
	  ((and (not test) (eq (car i) k)) #1#)
	  (t i))))

;; (update '((:X . 10) (:Y . 20)) :Y (lambda (i) (cons (car i) (+ 30 (cdr i)))))

