; (a)
(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))

(define (simple-flatten stream)
  (stream-map stream-car
              (stream-filter (lambda (x) (not (stream-null? s))) 
                             stream)))

; (b)
; No.  The order of the resulting stream will be different (as this 
; will be more directly in-order), but this does not affect correctness.

