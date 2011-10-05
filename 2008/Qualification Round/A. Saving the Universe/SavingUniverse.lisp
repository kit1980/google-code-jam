;;;; Google Code Jam 
;;;; Qualification Round 2008
;;;; A. Saving the Universe
;;;; https://code.google.com/codejam/contest/dashboard?c=32013#s=p0
;;;;
;;;; Author: Sergey Dymchenko <kit1980@gmail.com>
;;;;
;;;; Language: Common Lisp
;;;; Tested with SBCL 1.0.29 - http://www.sbcl.org/
;;;; Usage: sbcl --noinform --load SavingUniverse.lisp < in-file > out-file

;; Only number of search engines is important,
;; and not the actual engines names.
(defun switches (s queries)
  (let ((already nil) (y 0))
    (dolist (q queries)
      (pushnew q already :test 'equal)
      (if (>= (length already) s)
          (progn
            (incf y)
            (setf already (list q)))))
    y))

(defun print-case (case-num result)
  (format t "Case #~a: ~a~%" case-num result))

(defun do-case (case-num s queries)
  (print-case case-num (switches s queries)))

(defun main ()
  (dotimes (case-num-0 (read))
    (let (s (queries nil))

      ;; input search engines
      (setf s (read))
      (loop repeat s do (read-line))

      ;; input queries
      (loop repeat (read) do (push (read-line) queries))
      (setf queries (nreverse queries))

      (do-case (1+ case-num-0) s queries))))

(main)
(quit)
