; Given a one-argument procedure p and an object a, p is said
; to "halt" on a if evaluating the expression (p a) returns
; a value (as opposed to terminating with an error message
; or running forever).  Show that is is impossible to write
; a procedure halts? that correctly determines whether p
; halts on a for any procedure p and object a.

; if we had halts?, could implement:
(define (run-forever) (run-forever))

(define (try p)
    (if (halts? p p)
        (run-forever)
        `halted))

; Now consider evaluating:
(try try)

; Then inside try, (halts? try try) is called.
; If this returns true, then the procedure runs forever (X)
; If this returns false, then the proceudre halts (X)
; So we have a contradiction.
