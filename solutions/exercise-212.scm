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
    (make-interval (- c (* c p)) (+ (c (* c p)))))

(define (percent x)
    (/ (- (upper-bound x) (center x)) (center x)))