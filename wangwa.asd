;;;; wangwa.asd

(asdf:defsystem #:wangwa
  :description "A collection of Common Lisp helper functions"
  :author "Vee Satayamas <vsatayamas@gmail.com>"
  :license  "APACHE-2.0"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "wangwa")
	       (:file "seq")
	       (:file "alist")
	       (:file "tsv")
	       (:file "progress")))
