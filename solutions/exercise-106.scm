(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
         (else else-clause)))

(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
    	        x)))

(sqrt-iter 1 2)

; Running this hangs.
; Why?  Because new-if is a procedure, so with
; applicative-order evaluation, the arguments will be evaluated
; and thus the sqrt-iter procedure will be called recursively 
; before the predicate is evaluated.
; => infinite recursion
