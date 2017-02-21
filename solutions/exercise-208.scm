(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (cdr x))

(define (lower-bound x)
    (car x))

(define (sub-interval x y)
    (let ((s1 (- (upper-bound x) (lower-bound y)))
          (s2 (- (lower-bound x) (upper-bound y))))
        (make-interval (min s1 s2) (max s1 s2))))


(sub-interval (make-interval 10 15) (make-interval 7 12))
(sub-interval (make-interval 7 12) (make-interval 10 15))
(sub-interval (make-interval 7 10) (make-interval 1 3))
