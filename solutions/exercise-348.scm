; The deadlock avoidance works in this case since the only way a deadlock 
; would happen in the first place is if the calls are exactly opposite (i.e. 
; (exhange a1 a2) and (exchange a2 a1)).  Enforcing this ordering ensures 
; that these are equivalent to making the same call twice, and so there is no
; way that a2 can be held without a1 (in this example).

(define (make-serializer)
    (let ((mutex (make-mutex)))
        (lambda (p)
            (define (serialized-p . args)
                (mutex `acquire)
                (let ((val (apply p args)))
                    (mutex `release)
                    val))
            serialized-p)))


(define (make-mutex)
    (let ((cell (list #f)))
        (define (the-mutex m)
            (cond 
                ((eq? m `acquire)
                    (if (test-and-set! cell)
                        (the-mutex `acquire)))
                ((eq? m `release) (clear! cell))))))


(define (clear! cell)
    (set-car! cell false))


(define (test-and-set! cell)
    (if (car cell)
        #t
        (begin (set-car! cell true)
            #f)))


(define (make-account-and-serializer balance id)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (let ((balance-serializer (make-serializer)))
        (define (dispatch m)
            (cond ((eq? m `withdraw) withdraw)
                  ((eq? m `deposit) deposit)
                  ((eq? m `balance) balance)
                  ((eq? m `id) id)
                  ((eq? m `serializer) balance-serializer)
                  (else (error "Unknown request -- MAKE-ACCOUNT" m))))
        dispatch))


(define (exchange account1 account2)
    (let ((difference (- (account1 `balance)
                         (account2 `balance))))
    ((account1 `withdraw) difference)
    ((account2 `deposit) difference)))


(define (serialized-exchange account1 account2)
    (let ((serializer1 (account1 `serializer))
          (serializer2 (account2 `serializer)))
        (if (> (account1 `id)
               (account2 `id))
            ((serializer2 (serializer1 exchange))
                account1 
                account2)
            ((serializer1 (serializer2 exchange))
                account1
                account2))))
