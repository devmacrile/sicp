; very much the same as count-pairs (naturally)
; 'cycles' 
(define (detect-cycles x)
    (let ((seen (list)))
        (define (detect-cycles-iter x)
            (cond ((null? x) #f)
                ((pair? x)
                    (if (visited? x seen)
                        #t
                        (begin (set! seen (append (list x) seen))
                            (or (detect-cycles (car x))
                                (detect-cycles-iter (cdr x))))))
                (else #f)))
        (detect-cycles-iter x)))


; should use a set, but whatevs
(define (visited? x seen)
    (if (null? seen)
        #f
        (if (eq? (car seen) x)
            #t
            (visited? x (cdr seen)))))

; #f
(define x (cons `a (cons `b (cons `c `d))))
(detect-cycles x)

; #f
(define x1 (cons `a `b))
(define x2 (cons x1 x1))
(define x3 (cons x2 x2))
(detect-cycles x3)

; #t
(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)
(define z (make-cycle (cons `a (cons `b (cons `c `d)))))
(detect-cycles z)
