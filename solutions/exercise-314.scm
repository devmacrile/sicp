(define (mystery x)
    (define (loop x y)
        (if (null? x)
            y
            (let ((temp (cdr x)))
                (set-cdr! x y)
                (loop temp x))))
    (loop x `()))

(define v (list `a `b `c `d))
v
; (a b c d)

(define w (mystery v))
v  ; (a)
w  ; (d c b a)

; in general, this "mystery" returns the list passed in reverse order, while
; mutating the provided list, leaving only the first element

; v --> ( . ) -> ( . ) -> ( . ) -> ( . )
;        |        |        |        |
;       [a]      [b]      [c]      [d]

;         v<----------------<
;         |                  ^
; v --> ( . )                |
;        |                   |
;       [a]                  |
;                            ^
; w --> ( . ) -> ( . ) -> ( . )
;        |        |        |
;       [d]      [c]      [b]