; (a)
; The predicate for assignment/definitions will return 
; true for the definition of an application as it
; finds the `define symbol.

; (b)
(define (application? exp)
    (tagged-list? exp `call))
    