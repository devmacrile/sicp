(define (even n)
	(= (remainder n 2) 0))

(define (mult a b)
    (define (double x)
    	(+ x x))
    (define (halve x)
    	(/ x 2))
    (cond ((= b 0) 0)
    	  ((even? a) (mult (halve a) (double b)))
    	  (else (+ a (mult a (- b 1))))))


(mult 4 7)
(mult 11 11)
