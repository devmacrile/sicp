; recall that let is just syntactic sugar for a procedure call
; (let ((<var> <exp>)) <body>)
; is an alternate syntax for
; ((lambda (<var>) <body>) <exp>)

; balance as parameter
(define (make-withdraw balance)
    (lambda (amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                balance)
            "Insufficient funds")))

; balance as explicit local state
(define (make-withdraw initial-amount)
    (let ((balance initial-amount))
        (lambda (amount)
            (if (>= balance amount)
                (begin (set! balance (- balance amount))
                    balance)
                "Insufficient funds"))))

; let, as mentioned above, is syntatic sugar for a procudure call.  So the main difference in the environment structures
; will be that the second (i.e. explicit local state using let) will be one more level removed from the global environment.
