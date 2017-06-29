(define (make-monitored f)
    (let ((call-count 0))
        (define (inc-count input)
            (begin (set! call-count (+ call-count 1))
                    (f input)))
        (define (dispatch m)
            (if (eq? m `how-many-calls?)
                call-count
                (inc-count m)))
        dispatch))


(define s (make-monitored sqrt))
(s 100)
(s `how-many-calls?)