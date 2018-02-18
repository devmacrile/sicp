; added the following to the evaluator
; can run via evaluator_test.scm
(define (uniquely-asserted query frame-stream)
  (stream-flatmap
    (lambda (frame)
      (let ((evald (qeval (unique-query query)
                          (singleton-stream frame))))
        (cond ((stream-null? evald) 
               the-empty-stream)
              ((stream-null? (stream-cdr evald)) 
               evald)
              (else 
                the-empty-stream))))
    frame-stream))

(define (unique-query ops) (car ops))


(put `unique `qeval uniquely-asserted)

; query to test
(and (job ?x ?j)
     (unique (supervisor ?anyone ?x)))
