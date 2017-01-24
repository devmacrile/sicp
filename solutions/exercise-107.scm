
(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
    	        x)))

(define (sqrt x)
	(sqrt-iter 1.0 x))

; Simple test.
(sqrt-iter 1 9)
(sqrt 16)

; Example failure of good-enough? on small number.
; returns ±.03, should be 0.0031622776601683794
(sqrt-iter 1 .00001)

; Example failure on a large number.
; Floating point precision is a problem, so this difference is a large number.
(- (square (sqrt-iter 171792506910670443678820376588540424234035840000 29512665430652752148753480226197736314359272517043832886063884637676943433478020332709411004889)) 29512665430652752148753480226197736314359272517043832886063884637676943433478020332709411004889)   ; output as float
; Issues with convergence.
(sqrt-iter 1 12345678)

; Why?
; Since good-enough? has 0.001 hard-coded as the acceptable error,
; as soon as the square of the guess is within 0.001, the iteration
; stops (i.e. early stopping).  For large numbers, the precision of
; can be compromised, but convergence can also be painfully slow.


