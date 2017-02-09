(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a) 
            (sum term (next a) next b))))

; defined in book, for numerical accuracy comparison
(define (integral f a b dx)
    (define (add-dx x) (+ x dx))
    (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(define (cube x)
    (* x x x)))

(define (simpson-integral f a b n)
    (define (yval k)
        (f (+ a (* k (/ (- b a) n)))))
    (define (term k)
        (* (cond ((= k 0) 1)
                ((= k n) 1)
                ((even? k) 2)
                (else 4))
            (yval k)))
    (define (next x)
        (+ x 1))
    (/ (* (/ (- b a) n) (sum term 0 next n)) 3))

; run some comparison cases
(simpson-integral cube 0 1 100)
(integral cube 0 1 .01)

(simpson-integral cube 0 3.14 1000)
(integral cube 0 3.14 .0001)  ; hits recursion depth limit
