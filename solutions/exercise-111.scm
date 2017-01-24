; recursive
(define (superfib n)
	(if (< n 3) 
		n
	    (+ (superfib (- n 1)) 
	       (superfib (- n 2)) 
	       (superfib (- n 3)))))

; iterative
(define (superfib-iter n)
	(if (< n 3) 
		n
        (superfib-iter-helper 2 1 0 n)))

(define (superfib-iter-helper a b c count)
	(cond ((= count 2) a)
		  (else (superfib-iter-helper (+ a b c) a b (- count 1)))))

(superfib 7)
(superfib-iter 7)
(= (superfib 7) (superfib-iter 7))
