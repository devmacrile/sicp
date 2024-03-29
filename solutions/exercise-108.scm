(define (cube x)
	(* x x x))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (cbrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (cbrt-iter (improve guess x)
    	        x)))

; test
(/ (cbrt-iter 1 8) 1.0)
(/ (cbrt-iter 1 27) 1.0)
