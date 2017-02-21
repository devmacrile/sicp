(define (make-int-pair x y)
    (* (expt 2 x) (expt 3 y)))

(define (extract-power x a)
    (define (iter z counter)
        (if (> (remainder z a) 0)
            counter
            (iter (/ z a) (+ counter 1))))
    (iter x 0))

(define (car z)
    (extract-power z 2))

(define (cdr z)
    (extract-power z 3))

(car (make-int-pair 2 3))
(cdr (make-int-pair 2 3))
(car (make-int-pair 4 4))
(cdr (make-int-pair 4 4))