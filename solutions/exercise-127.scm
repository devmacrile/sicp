; Show the first few Carmichael numbers pass the Fermat test

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m)) m))
	(else
	 (remainder (* base (expmod base (- exp 1) m)) m))))


(define (carmichael-tester n)
  (define (check n a)
    (= (expmod a n n) a))
  (define (iter-check n a)
    (cond ((= a 0) true)
	  ((check n a) (iter-check n (- a 1)))
	  (else false)))
  (iter-check n (- n 1)))


(carmichael-tester 561)
(carmichael-tester 1105)
(carmichael-tester 1729)
(carmichael-tester 2465)
(carmichael-tester 2821)
(carmichael-tester 6601)
