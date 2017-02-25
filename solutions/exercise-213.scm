(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (cdr x))

(define (lower-bound x)
    (car x))

(define (make-center-width c w)
    (make-interval (- c w) (+ c w)))

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width x)
    (/ (- (upper-bound x) (lower-bound x)) 2))

(define (make-center-percent c p)
    (make-interval (- c (* c p)) (+ c (* c p))))

(define (percent x)
    (/ (- (upper-bound x) (center x)) (center x)))

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
      (make-interval (min p1 p2 p3 p4)
        (max p1 p2 p3 p4))))

(percent (mul-interval (make-center-percent 10 0.05) (make-center-percent 10 0.05)))
;(percent (mul-interval (make-center-percent 10 0.1) (make-center-percent 10 0.1)))
;(percent (mul-interval (make-center-percent 10 0.2) (make-center-percent 10 0.3)))

; If the percentage tolerances are assumed to be small enough, then you can simply
; add the tolerances together for the resulting product interval.  i.e. the true 
; tolerance of the above product is .099750623, whereas the sum is .01.
