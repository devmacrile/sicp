(define (make-rat n d)
    (let ((g (gcd n d)))
        (if (< (* n d) 0)
            (cons (- (abs (/ n g))) (abs (/ d g)))
            (cons (abs (/ n g)) (abs (/ d g))))))

(make-rat -1 -2)
(make-rat -1 3)
(make-rat 7 -49)
