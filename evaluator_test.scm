(load "evaluator_lazy.scm")

;(define count 0)
;(define (id x)
;    (set! count (+ count 1))
;    x)
;(define w (id (id 10)))



;(define (square x)
;    (* x x))
;
;(define count 0)
;(define (id x)
;    (set! count (+ count 1))
;    x)
;
;(square (id 10))

;count


; 4.30
(define (p1 x)
    (set! x (cons x '(2)))
    x)

(define (p2 x)
    (define (p e)
        e
        x)
    (p (set! x (cons x '(2)))))

(define (p3 x)
    (define (p e)
        e
        (display e)
        x)
    (p (set! x (cons x '(2)))))

(p1 1)
(p2 1)
(p3 1)
