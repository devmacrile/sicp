; "In principle, logically, once I've introduced one assignment
; operator, I've introduced them all."
; Mutation is just assignment (equipotent, each can be implemented in terms of the other)

(define (cons x y)
    (define (set-x! v) (set! x v))
    (define (set-y! v) (set! y v))
    (define (dispatch m)
        (cond ((eq? m `car) x)
            ((eq? m `cdr) y)
            ((eq? m `set-car!) set-x!)
            ((eq? m `set-cdr!) set-y!)
            (else (error "Undefined operation -- CONS-PAIR" m))))
    dispatch)

(define (car z) (z `car))
(define (cdr z) (z `cdr))
(define (set-car! z new-value)
    ((z `set-car!) new-value)
    z)
(define (set-cdr! z new-value)
    ((z `set-cdr!) new-value)
    z)

(define x (cons 1 2))
(define z (cons x x))
(set-car! (cdr z) 17)

(car x)


; z --> ( . ) -> ( . )
;        |        /   
;        v <------
;        x --> ( . ) -> ( . )
;               |        |  
;              [1]      [2] 

; z --> ( . ) -> ( . )
;        |        /   
;        v -------
;        x --> ( . )
;               |  
;              [17]