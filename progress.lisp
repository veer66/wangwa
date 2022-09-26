(in-package :wangwa)

(defun print-progress (i &key (prefix "LINE") (freq 1000))
  (when (eq 0 (mod i freq))
    (format t "~A: ~A~%" prefix i)))
