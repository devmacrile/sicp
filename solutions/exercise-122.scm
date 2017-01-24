(define (smallest-divisor n)
	(find-divisor n 2))

(define (find-divisor n test-divisor)
	(cond ((> (square test-divisor) n) n)
		((divides? test-divisor n) test-divisor)
		(else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
	(newline)
	(display n)
	(start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes lower upper)
  (define (test-iter current-value)
    (if (<= current-value upper)
	(timed-prime-test current-value))
    (if (<= current-value (- upper 2))
	(test-iter (+ current-value 2))))
  (test-iter (if (even? lower)
		 (+ lower 1)
		 lower)))


(search-for-primes 1000 1019)
(search-for-primes 10000 10100)
(search-for-primes 100000 100100)
(search-for-primes 1000000 1000100)

; book dates itself with the comparisons!
; Uncomment the below for more discernible comparison
(search-for-primes 10000000000 10000001000)
(search-for-primes 100000000000 100000001000)
