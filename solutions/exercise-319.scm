(define (detect-cycles x)
    (define (detect-cycles-iter leader follower)
        (cond ((not (pair? leader)) #f)
              ((not (pair? follower)) #f)
              ((eq? leader follower) #t)
              (else (detect-cycles-iter (cdr leader) (cddr follower)))))
    (detect-cycles-iter x (cdr x)))

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
