(define (make-account balance)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (define (dispatch m)
        (cond ((eq? m `withdraw) withdraw)
            ((eq? m `deposit) deposit)
            (else (error "Unkown request -- MAKE-ACCOUNT" m))))
    dispatch)

; show environment structure generated by this sequence
(define acc (make-account 50))
; global-env --> [make-account                       acc]
;                     |                               |
;                 param: balance                   balance: 50
;                 body: (define (withdraw ...      withdraw: 
;                       (define (deposit ...       deposit:
;                                                  dispatch

((acc `deposit) 40)
; global-env --> [make-account                       acc]
;                     |                               |
;                 param: balance                E1 balance: 90
;                 body: (define (withdraw ...      withdraw: 
;                       (define (deposit ...       deposit:
;                                                  dispatch
;                                                  /       \
;                                   E2 (call to dispatch)   E3 (call to withdraw)
;                                       m: `deposit           amount: 40

((acc `withdraw) 60)
; global-env --> [make-account                       acc]
;                     |                               |
;                 param: balance                E1 balance: 30
;                 body: (define (withdraw ...      withdraw: 
;                       (define (deposit ...       deposit:
;                                                  dispatch
;                                                  /       \
;                                   E2 (call to dispatch)   E3 (call to withdraw)
;                                       m: `withdraw            amount: 60


; The local state for acc is kept in environment E1.  All calls to subdefinitions
; of acc are evaluated with this E1 as the parent environment.
; Say we define another account.  acc2 would have its own environment maintaining its 
; local state.
(define acc2 (make-account 100))

; What is shared would be an implementation detail.  The body of the subdefined withdraw/deposit would
; likely be shared.
