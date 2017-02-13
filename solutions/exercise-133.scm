(define (filtered-accumulate filter combiner base-value term a next b)
    (define (iter a result)
        (cond ((> a b) result)
            ((filter a) (iter (next a) (combiner result (term a))))
            (else (iter (next a) result))))
    (iter a base-value))


(define (identity x) x)
(define (square x) (* x x))
(define (inc x) (+ x 1))

; (a)
(define (smallest-divisor n)
    (find-divisor n 2))

(define (next n)
  (cond ((= n 2) 3)
    (else (+ n 2))))

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(filtered-accumulate prime? + 0 square 1 inc 10)


; (b)
(define (relative-prime? a b)
  (= 1 (gcd a b)))

(define (product-relative-primes n)
  (define (filter i)
    (relative-prime? i n))
  (filtered-accumulate filter * 1 identity 1 inc n))

(product-relative-primes 10)

