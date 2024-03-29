; Computed p' and q' via simple substitution, factoring out a/b,
; and solving for p', q' in terms of p and q.

(define (fib n)
	(fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
	(cond ((= count 0) b)
		  ((even? count)
		  	(fib-iter a
		  			  b
		  			  (+ (* q q) (* p p)) ; compute p'
		  			  (+ (* q q) (* 2 p q)) ; compute q'
		  			  (/ count 2)))
		  (else (fib-iter (+ (* b q) (* a q) (* a p))
		  	              (+ (* b p) (* a q))
		  	              p
		  	              q
		  	              (- count 1)))))

(fib 1)
(fib 3)
(fib 10)
