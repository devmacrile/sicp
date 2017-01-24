(define (p) (p))

(define (test x y)
  (if (= x 0)
    0
    y))

(test 0 (p))

; With applicative-order, I believe, we hit some improper
; recursion that does not terminate.  With normal-order, however,
; since x is 0 (i.e. the if statement evalutes to #t), the test
; procedure would return 0 without ever evaluating (p).
