; Introducing assignment => order of evaluation of arguments
; makes a difference

(define (make-such-function)
    (let ((last-argument 0))
        (define (dispatch n)
            (let ((return-val last-argument))
                (begin (set! last-argument n)
                    return-val)))
        dispatch))

(define f (make-such-function))

;(+ (f 0) (f 1))

; left to right will be 0, 0
;(f 0)
;(f 1)

; right to left will be 0, 1
; (f 1)
; (f 0)
