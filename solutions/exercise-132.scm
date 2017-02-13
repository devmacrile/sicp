; (a)
(define (accumulate combiner base-value term a next b)
    (if (> a b)
        base-value
        (combiner (term a) (accumulate combiner base-value term (next a) next b))))

(define (sum term a next b)
     (accumulate + 0 term a next b))

(define (product term a next b)
    (accumulate * 1 term a next b))


(define (identity x) x)
(define (inc x) (+ x 1))

(sum identity 1 inc 5)
(product identity 3 inc 5)

;(b)
(define (accumulate-iter combiner base-value term a next b)
    (define (iter a result)
        (if (> a b) 
            result
            (iter (next a) (combiner result (term a)))))
    (iter a base-value))

(define (sum term a next b)
     (accumulate-iter + 0 term a next b))

(define (product term a next b)
    (accumulate-iter * 1 term a next b))

(sum identity 1 inc 5)
(product identity 3 inc 5)