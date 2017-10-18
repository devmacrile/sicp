(define (unless condition usual-value exceptional-value)
    (if condition exceptional-value usual-value))

(define (factorial n)
    (unless (= n 1)
        (* n (factorial (- n 1)))
        1))

(factorial 6)

; maximum recursion depth hit
; basically unless will evaluate the usual-value
; in each call even when n is 1, and so keeps
; decrementing n infinitely.