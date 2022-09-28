(in-package :wangwa)

(defun escape (v)
  (loop with escaped-v = (make-array (length v) :element-type 'character :fill-pointer 0)
	for ch across v
	do
	   (cond
	     ((eq ch #\Tab) (progn (vector-push-extend #\\ escaped-v)
				   (vector-push-extend #\t escaped-v)))
	     ((eq ch #\Newline) (progn (vector-push-extend #\\ escaped-v)
				       (vector-push-extend #\n escaped-v)))
	     ((eq ch #\Return) (progn (vector-push-extend #\\ escaped-v)
				       (vector-push-extend #\r escaped-v)))
	     (t (vector-push-extend ch escaped-v)))
	finally
	   (return (make-array (length escaped-v)
			       :element-type 'character
			       :initial-contents escaped-v))))

(defun unescape (s)
  (loop with found-backspace = nil
	with unescaped-s = (make-array (length s) :element-type 'character :fill-pointer 0)
	for ch across s
	do
	   (cond
	     ((and found-backspace (eq ch #\t)) (progn (vector-push-extend #\Tab unescaped-s)
						       (setq found-backspace nil)))
	     ((and found-backspace (eq ch #\r)) (progn (vector-push-extend #\Return unescaped-s)
						       (setq found-backspace nil)))
	     ((and found-backspace (eq ch #\n)) (progn (vector-push-extend #\Newline unescaped-s)
						       (setq found-backspace nil)))
	     (found-backspace (progn (vector-push-extend #\\ unescaped-s)
				     (vector-push-extend ch unescaped-s)
				     (setq found-backspace nil)))
	     ((eq ch #\\) (setq found-backspace t))
	     (t (vector-push-extend ch unescaped-s)))
	finally
	   (when found-backspace
	     (vector-push-extend #\\ unescaped-s))
	   (return (make-array (length unescaped-s)
			       :element-type 'character
			       :initial-contents unescaped-s))))

(defun to-tsv (values)
  (let ((pre-format (format nil "~~{~~a~~^~a~~}" #\Tab))
	(escaped-values (loop for v in values
			      collect
			      (if (stringp v)
				  (escape v)
				  v))))
    (format nil pre-format escaped-values)))

(defconstant +buf-size+ 1024)

(defun from-tsv (s)
  (loop with vals = '()
	with buf = #1=(make-array +buf-size+ :element-type 'character :fill-pointer 0)
	for ch across s
	do
	   (cond 
	     ((eq ch #\Tab) (progn #2=(setq vals (cons (make-array (length buf) :element-type 'character :initial-contents buf) vals))
				   (setq buf #1#)))
	     (t (vector-push-extend ch buf)))
	finally
	   #2#
	   (return (reverse vals))))
