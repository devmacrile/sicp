(define (square n)
	(* n n))

(define (even? n)
	(= (remainder n 2) 0))

(define (fast-expt b n)
    (define (fast-expt-iter b counter product)
        (cond ((= counter 0) product)
              ((even? n) (fast-expt-iter (square b) (/ counter 2) product))
              (else (fast-expt-iter b (- counter 1) (* product b)))))
    (fast-expt-iter b n 1))


(fast-expt 2 5)
(fast-expt 3 3)
(fast-expt 12 7)